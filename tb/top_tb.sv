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
    test_left = 0;
    test_right = 0;

    do
      begin

        $display("\n%b => %b | %b", data, result_left, result_right);

/*        for(int i = 0; i<4; i++ )
          begin

             if( !test_right )
               test_right = data[i] << i;

             if( !test_left )
               test_left = data[3-i] >> i;

             $display("#%d = %b ", i, data[i] );
          end
             $display("Test %b | %b ", test_left, test_right );*/

        data+=4'b0001;

        #10;

      end
    while (data != 4'b0000);

  end

endmodule