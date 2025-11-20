module top_tb #(
  int NUM_TESTS = 4,
  int TEST_LENGTH = 64
);

import "DPI-C" function shortint unsigned crc16_ref_c(input byte data_input, input shortint unsigned crc_prev);


logic           data;
bit             clk;
bit             rst;
logic  [15:0]   crc;

bit             test_passed;
int             test_num;
bit             test_data[NUM_TESTS][TEST_LENGTH];

logic           test_feedback;
logic   [15:0]  test_crc_ref;
logic   [15:0]  test_crc_ref_external;

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
    foreach ( test_data[i] )
      begin
        $display( "\n=== Test %0d ===", i );

        @( posedge clk );
        test_crc_ref = 0;
        test_crc_ref_external = 0;
        data=0;
        rst <= 1'b1;
        @( posedge clk );
        rst <= 1'b0;

        for ( int j = 0; j < TEST_LENGTH; j++ )
        begin
          @( posedge clk );
          data <= test_data[i][j];

          test_num++;
          test_crc_ref <= crc16_ref(data, test_crc_ref);
          test_crc_ref_external <= crc16_ref_c(data, test_crc_ref_external);
          
          if ( test_crc_ref !== crc || test_crc_ref_external !== crc )
            begin
              $display( "Failed test %0d, step %0d .\n%16b - DUT\n%16b - Verilog REF\n%16b - External C REF", i, test_num, crc, test_crc_ref, test_crc_ref_external );
              test_passed = 0;
            end
        end

        @( posedge clk);

        if(test_passed)
          $display( "Passed test %0d", i );
      end

    if ( test_passed )
      $display( "All Tests - Passed. %d/%d", test_num, NUM_TESTS*TEST_LENGTH );
    else
      $display( "All Tests - Fail. %d/%d", test_num, NUM_TESTS*TEST_LENGTH );

    $stop;
  end

function automatic logic [15:0] crc16_ref(input logic data_input, input logic [15:0] crc_prev);
    logic feedback;
    logic [15:0] crc_next;

    feedback = crc_prev[15] ^ data_input;
    crc_next = {crc_prev[14:0], 1'b0};
    crc_next[0] ^= feedback;
    crc_next[2] ^= feedback;
    crc_next[15] ^= feedback;

    return crc_next;
endfunction

endmodule