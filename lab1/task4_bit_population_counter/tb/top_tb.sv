import config_pkg::TEST_DATA_WIDTH;

module top_tb;

  parameter CLK_PERIOD = 10;

  logic clk = 1'b0;

  bit_population_counter_if #(
    .WIDTH(TEST_DATA_WIDTH)
  ) bit_population_counter_bus (
    .clk_i(clk)
  );

  bit_population_counter dut_inst (
      .clk_i            (bit_population_counter_bus.clk_i),
      .srst_i           (bit_population_counter_bus.srst_i),
      .data_i           (bit_population_counter_bus.data_i),
      .data_val_i       (bit_population_counter_bus.data_val_i),
      .data_o           (bit_population_counter_bus.data_o),
      .data_val_o       (bit_population_counter_bus.data_val_o)
  );


  test #(.NUM_TRANSACTIONS(30000)) test_inst (
    .vif(bit_population_counter_bus)
  );

  always #(CLK_PERIOD/2) clk = ~clk;

endmodule