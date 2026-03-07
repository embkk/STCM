module top_tb;

  parameter CLK_PERIOD = 10;
  parameter DATA_WIDTH = 32;

  logic clk = 1'b0;

  priority_encoder_if #(
    .WIDTH(DATA_WIDTH)
  ) priority_encoder_bus (
    .clk_i(clk)
  );

  priority_encoder dut_inst (
      .clk_i            (priority_encoder_bus.clk_i),
      .srst_i           (priority_encoder_bus.srst_i),
      .data_i           (priority_encoder_bus.data_i),
      .data_left_o      (priority_encoder_bus.data_left_o),
      .data_right_o     (priority_encoder_bus.data_right_o),
      .data_val_o       (priority_encoder_bus.data_val_o)
  );


  test #(.NUM_TRANSACTIONS(20)) test_inst (
    .vif(priority_encoder_bus)
  );

  always #(CLK_PERIOD/2) clk = ~clk;

endmodule