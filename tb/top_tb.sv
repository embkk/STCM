module top_tb;

logic [3:0] data;
logic         data_val;
logic         result_val;
logic [3:0] result_left;
logic [3:0] result_right;

logic [3:0] test_left;
logic [3:0] test_right;
bit            test_passed;

outer1bits outer1bits_inst (
  .data_val_i                ( data_val      ),
  .data_i                      ( data            ),
  .data_val_o               ( result_val    ),
  .data_left_o               ( result_left   ),
  .data_right_o             ( result_right )
);

initial
  begin
    data = 0;
    test_passed = 1;
    data_val = 1;

    do
      begin

        test_left = 0;
        test_right = 0;

        for(int i = 0; i<4; i++ )
          begin

            if( !test_right )
               test_right = 4'b0001 << i;

            if( !test_left && data[3-i] )
               test_left = 4'b1000 >> i;

          end
          
        if( test_left != result_left || test_right != result_right )
          begin
            $display("Error, %b == %b && %b == %b expected", test_left, result_left, test_right, result_right );
            test_passed = 0;
          end

        data+=4'b0001;

        #10;

      end
    while (data != 4'b0000);

  end

endmodule