module top_tb #(
  int NUM_TESTS = 3,
  int TEST_LENGTH = 32
);

logic           data;
bit             clk;
bit             rst;
logic  [15:0]   crc;
logic  [15:0]   crc2;

bit             test_passed;
int             test_num;
bit             test_data[NUM_TESTS][TEST_LENGTH];

logic           test_feedback;
logic   [15:0]  test_crc_ref;
logic   [15:0]  test_crc_next;

initial
  begin
    forever
      #5 clk = !clk;
  end

initial
  begin
    test_passed = 1;
    test_num = 0;
    for ( int t = 0; t < NUM_TESTS; t++ )
      begin
        for ( int i = 0; i < TEST_LENGTH; i++ )
          begin
            test_data[t][i] = $urandom() % 2;
          end
      end
  end

crc16 crc16_inst (
  .clk_i            ( clk        ),
  .rst_i            ( rst        ),
  .data_i           ( data       ),
  .crc_o            ( crc        )
);

initial
  begin
    rst <= 1'b1;
    #9;
    data <= 0;
    rst <= 1'b0;

    foreach ( test_data[i] )
      begin
        $display( "\n=== Test %0d ===", i );

        @( posedge clk );
        rst <= 1'b1;
        @( posedge clk );
        rst <= 1'b0;

        for ( int j = 0; j < TEST_LENGTH; j++ )
        begin
          @( posedge clk );
          data <= test_data[i][j];
          test_num++;
        end

        @( posedge clk);

        if ( test_crc_ref === crc )
          begin
            $display( "Test %0d Success: DUT = 0x%04h | REF = 0x%04h", i, crc, test_crc_ref );
          end
        else
          begin
            $display( "Test %0d Failed. DUT | REF\n%16b - DUT\n%16b - REF", i, crc, test_crc_ref );
            test_passed = 0;
          end
      end

    if ( test_passed )
      $display( "All Tests - Passed. %d/%d", test_num, NUM_TESTS*TEST_LENGTH );
    else
      $display( "All Tests - Fail. %d/%d", test_num, NUM_TESTS* NUM_TESTS*TEST_LENGTH );

    $stop;
  end

always @( posedge clk or posedge rst )
  begin
    if ( rst )
      test_crc_ref <= 16'h0000;
    else
      test_crc_ref <= test_crc_next;
  end

always_comb
  begin 
    test_feedback = test_crc_ref[15] ^ data;
    test_crc_next = {test_crc_ref[14:0], 1'b0};

    test_crc_next[0] ^= test_feedback;
    test_crc_next[2] ^= test_feedback;
    test_crc_next[15] ^= test_feedback;
  end
  
endmodule