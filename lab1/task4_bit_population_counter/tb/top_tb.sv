module top_tb;

  parameter CLK_PERIOD = 10;
  parameter DATA_WIDTH = 32;

  logic clk = 1'b0;

  bit_population_counter_if #(
    .WIDTH(DATA_WIDTH)
  ) bit_population_counter_bus (
    .clk_i(clk)
  );

  bit_population_counter dut_inst (
      .clk_i            (bit_population_counter_bus.clk_i),
      .srst_i           (bit_population_counter_bus.srst_i),
      .data_i           (bit_population_counter_bus.data_i),
      .data_val_i       (bit_population_counter_bus.data_val_i),
      .data_left_o      (bit_population_counter_bus.data_left_o),
      .data_right_o     (bit_population_counter_bus.data_right_o),
      .data_val_o       (bit_population_counter_bus.data_val_o)
  );


  test #(.NUM_TRANSACTIONS(10)) test_inst (
    .vif(bit_population_counter_bus)
  );

  always #(CLK_PERIOD/2) clk = ~clk;

endmodule