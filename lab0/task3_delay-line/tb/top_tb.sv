module top_tb;

logic       data;
logic [3:0] data_delay;
bit         clk;
bit         rst;
logic       result;

bit         test_passed;
int         test_count;

initial
  begin

    test_count = 0;
    test_passed = 1;

    data = 0;
    data_delay = 2;

    forever
      #5 clk = !clk;
  end

delay_line delay_line_inst (
  .data_i         ( data       ),
  .data_delay_i   ( data_delay ),
  .clk_i          ( clk        ),
  .rst_i          ( rst        ),
  .data_o         ( result     )
);

initial
  begin
    rst <= 1'b1;
    #19;
    rst = 1'b0;
    
    for( test_count = 0; test_count < 100; test_count++ )
      begin
        @( posedge clk );
        data <= test_count % 2;
      end

    if ( test_passed )
      $display( "Tests: %d. Passed.", test_count );
    else
      $display( "Tests: %d. Fail: errors above", test_count );
  end
  
endmodule
