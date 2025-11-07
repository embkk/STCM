module top_tb;

logic [3:0] data;
logic       data_val;
logic       result_val;
logic [3:0] result_left;
logic [3:0] result_right;

logic [3:0] test_left;
logic [3:0] test_right;
bit         test_passed;
int         test_count;

outer1bits outer1bits_inst (
  .data_val_i     ( data_val     ),
  .data_i         ( data         ),
  .data_val_o     ( result_val   ),
  .data_left_o    ( result_left  ),
  .data_right_o   ( result_right )
);

initial
  begin

    test_count = 0;
    test_passed = 1;

    data = 0;
    data_val = 0;
    

    do
      begin

        test_left = 0;
        test_right = 0;
        test_count++;

        #10;

        for( int i = 0; i<4; i++ )
          begin

            if( !test_right && data[i] )
               test_right = 4'b0001 << i;

            if( !test_left && data[3-i] )
               test_left = 4'b1000 >> i;

          end
        
        if( data_val !== result_val )
            $display( "Error. Val %b expected, but %b", data_val, result_val );

        if( data_val == 1 && test_left !== result_left || test_right !== result_right )
          begin
            $display( "Error %b. Left %b expected, but %b. Right %b expected, but %b", data, test_left, result_left, test_right, result_right );
            test_passed = 0;
          end

	      if(data_val == 0)
          data_val = 1;
        else
          begin
            data_val = 0;
            data+=4'b0001;
          end
      end
    while ( !( data == 4'b0000 && data_val == 0 ) ); // Returned to initial test condition after overflow

    if ( test_passed )
      $display( "Tests: %d. Passed.", test_count );
    else
      $display( "Tests: %d. Fail: errors above", test_count );

  end

endmodule
