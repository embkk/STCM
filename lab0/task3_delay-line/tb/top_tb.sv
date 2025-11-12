module top_tb #(int NUM_SIGNALS = 256);

logic                   data;
logic [3:0]             data_delay;
bit                     clk;
bit                     rst;
logic                   result;

bit                     test_passed;
int                     test_num;
logic [15:0]            test_reg;
bit   [NUM_SIGNALS-1:0] test_signals;

initial
  begin
    forever
      #5 clk = !clk;
  end

initial
  begin
    test_num = 0;
    test_passed = 1;
    test_reg = 0;
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
    #9;
    rst = 1'b0;
    
    for( test_num = 0; test_num <16; test_num++ )
      begin
        test_reg = 0;
        for( int i = 0; i < NUM_SIGNALS; i++ )
          test_signals[i] = $random % 2;

        data_delay <= test_num;

        test_delay(test_signals);
      end

    if ( test_passed )
      $display( "Tests: %d/16. Passed.", test_num );
    else
      $display( "Tests: %d/16. Fail: errors above", test_num );

    $stop;
  end

task automatic test_delay(bit [NUM_SIGNALS-1:0] signals);
  
  int i;
  bit expected;

  for( i = 0; i < NUM_SIGNALS; i++ )
    begin
      data <= signals[i];

      @( posedge clk );

      test_reg <= (test_reg << 1) | data;
      expected = test_reg[data_delay];      

      if( result !== expected )
        begin
          test_passed = 0;
          $display( "ERROR at iteration %0d: expected %b, got %b (delay=%0d)", i, expected, result, data_delay );
        end
    end

    $display( "Delay %d tested %d times", data_delay, i );
endtask
  
endmodule