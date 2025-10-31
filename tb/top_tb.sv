module top_tb;

logic [3:0] test_data;
logic         test_data_val;
logic         test_result_val;
logic [3:0] test_result_left;
logic [3:0] test_result_right;

bit test_passed = 1;

outer1bits outer1bits_inst (
  .data_val_i                ( test_data_val      ),
  .data_i                      ( test_data            ),
  .data_val_o               ( test_result_val    ),
  .data_left_o               ( test_result_left   ),
  .data_right_o             ( test_result_right )
);

initial
  begin
    test_data = 0;
    test_data_val = 1;

    do
      begin
        #10;
        $display("%b => %b | %b", test_data, test_result_left, test_result_right);
//        $display("%b  %b %b %b", debug_pin0, debug_pin1, debug_pin2, debug_pin3);
	test_data+=4'b0001;
      end
    while (test_data != 4'b0000);

  end

endmodule