module top_tb;

logic [3:0] data;
logic         data_val;
logic         result_val;
logic [3:0] result_left;
logic [3:0] result_right;

bit            test_val;
logic [3:0] test_left;
logic [3:0] test_right;
bit            test_passed;

outer1bits outer1bits_inst (
  .data_val_i     ( data_val     ),
  .data_i         ( data         ),
  .data_val_o     ( result_val   ),
  .data_left_o    ( result_left  ),
  .data_right_o   ( result_right )
);

initial
  begin

    data = 0;
    test_passed = 1;

    do
      begin

        test_left = 0;
        test_right = 0;

        #10;

        for(int i = 0; i<4; i++ )
          begin

            if( !test_right && data[i] )
               test_right = 4'b0001 << i;

            if( !test_left && data[3-i] )
               test_left = 4'b1000 >> i;

          end
        
        if( test_val !== result_val )
            $display( "Error. Val %b expected, but %b", test_val, result_val );

        if( test_val == 1 && test_left !== result_left || test_right !== result_right )
          begin
            $display( "Error %b. Left %b expected, but %b. Right %b expected, but %b", data, test_left, result_left, test_right, result_right );
            test_passed = 0;
          end

	if(test_val == 0)
          test_val = 1;
        else
          begin
            test_val = 0;
            data+=4'b0001;
          end

      end
    while (data != 4'b0000);

    if (test_passed)
      $display("Test completed. No errors detected");
    else
      $display("Test failed. Errors above");

  end

endmodule