module top_tb;

logic       data;
logic [3:0] data_delay;
logic       clk;
logic       rst;
logic       result;

bit         test_passed;
int         test_count;

delay_line delay_line_inst (
  .data_i         ( data         ),
  .clk_i          ( clk          ),
  .rst_i          ( rst          ),
  .data_o         ( result_right )
);

initial
  begin
    clk = 0;
    test_count = 0;
    test_passed = 1;

    data = 0;

    for( int i = 0; i < 16; i++ )
      begin
        test_count++;
        #10;
        clk = !clk;
      end

    if ( test_passed )
      $display( "Tests: %d. Passed.", test_count );
    else
      $display( "Tests: %d. Fail: errors above", test_count );
  end

endmodule
