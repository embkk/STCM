module top_tb;

  parameter CLK_PERIOD = 5;

  logic clk = 1'b0;

  deserializer_if deserializer_bus (.clk(clk));

  deserializer dut_inst (
      .clk_i            (deserializer_bus.clk),
      .srst_i           (deserializer_bus.srst),
      .data_i           (deserializer_bus.data),
      .data_val_i       (deserializer_bus.data_val),
      .deser_data_o     (deserializer_bus.deser_data),
      .deser_data_val_o (deserializer_bus.deser_data_val)
  );


  test #(.NUM_TRANSACTIONS(12)) test_inst (
    .vif(deserializer_bus)
  );

  always #CLK_PERIOD clk = ~clk;

endmodule
