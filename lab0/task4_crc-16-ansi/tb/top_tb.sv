module top_tb #(int NUM_TESTS = 3, int TEST_LENGTH = 9);

logic           data;
bit             clk;
bit             rst;
logic  [15:0]   crc;

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
  .crc_0            ( crc        )
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
        $display("\n=== ТЕСТ %0d: %0d бит ===", test_num, test_data[i]);

        //тут тест
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

        crc_ref_reversed = {<<{test_crc_ref}};
        if (crc === crc_ref_reversed)
          $display("УСПЕХ: DUT = 0x%04h | REF = 0x%04h — совпадает", crc, crc_ref_reversed);
        else
          begin
            $display("ПРОВАЛ: DUT = 0x%04h | REF = 0x%04h — НЕ СОВПАДАЕТ, ПЕРЕПИСЫВАЙ МОДУЛЬ", crc, crc_ref_reversed);
            test_passed = 0;
          end

      end

    if ( test_passed )
      $display( "Tests: %d/16. Passed.", test_num );
    else
      $display( "Tests: %d/16. Fail: errors above", test_num );

    $stop;
  end

always @(posedge clk or posedge rst)
begin
  if (rst)
    test_crc_ref <= 16'hFFFF;
  else
    test_crc_ref <= test_crc_next;
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