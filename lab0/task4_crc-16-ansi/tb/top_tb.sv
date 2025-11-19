module top_tb #(int NUM_TESTS = 1, int TEST_LENGTH = 32);

logic           data;
bit             clk;
bit             rst;
logic  [15:0]   crc;
logic  [15:0]   crc2;

bit             test_passed;
int             test_num;
logic   [15:0]  test_crc_ref;
logic   [15:0]  test_crc_next;
logic   [15:0]  crc_ref_reversed;
bit             test_data[NUM_TESTS][TEST_LENGTH];

initial
  begin
    forever
      #5 clk = !clk;
  end

initial
  begin
    test_passed = 1;
    test_num = 0;
    for (int t = 0; t < NUM_TESTS; t++) begin
      for (int i = 0; i < TEST_LENGTH; i++) begin
        test_data[t][i] = $urandom() % 2;
      end
    end
  end

crc16 crc16_inst (
  .clk_i            ( clk        ),
  .rst_i            ( rst        ),
  .data_i           ( data       ),
  .crc_o            ( crc        ),
  .crc2_o           ( crc2       )
);

initial
  begin
    rst <= 1'b1;
    #9;
    data <= 0;
    rst <= 1'b0;

    foreach (test_data[i])
      begin
        test_num++;
        $display("\n=== Test %0d ===", test_num);

        // Сброс CRC перед тестом
        @(posedge clk);
        rst <= 1'b1;
        @(posedge clk);
        rst <= 1'b0;

        // Подача битов данных
        for (int j = 0; j < TEST_LENGTH; j++) begin
          @(posedge clk);
          data <= test_data[i][j];
        end

        // Ожидание финального результата
        @(posedge clk);

        
        check_crc16(crc_ref_reversed, crc);
        check_crc16(crc_ref_reversed, crc2);
        check_crc16(test_crc_ref, crc);
        check_crc16(test_crc_ref, crc2);

      end

    if ( test_passed )
      $display( "Tests: %d/%d. Passed.", test_num, NUM_TESTS );
    else
      $display( "Tests: %d/%d. Fail: errors above", test_num, NUM_TESTS );

    $stop;
  end

task automatic check_crc16(
    input logic [15:0] dut,
    input logic [15:0] ref_val
);
    if (dut === ref_val) begin
        $display("Test %0d Success: DUT = 0x%04h | REF = 0x%04h", test_num, dut, ref_val);
    end else begin
        $display("Test %0d Failed. DUT | REF\n%16b - DUT\n%16b - REF", test_num, dut, ref_val);
        test_passed = 0;
    end
endtask

always @(posedge clk or posedge rst)
begin
  if (rst)
    test_crc_ref <= 16'h0000;
  else
    test_crc_ref <= test_crc_next;
    crc_ref_reversed <= {<<{test_crc_ref}};
end

always_comb begin
  logic feedback;

  feedback = test_crc_ref[15] ^ data;
  test_crc_next = {test_crc_ref[14:0], 1'b0};

  test_crc_next[0] ^= feedback;
  test_crc_next[2] ^= feedback;
  test_crc_next[15] ^= feedback;
end
  
endmodule