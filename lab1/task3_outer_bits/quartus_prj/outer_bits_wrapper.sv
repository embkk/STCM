module deserializer_wrapper (
  input   logic         clk_i,
  input   logic         srst_i,
  input   logic         data_i,
  input   logic         data_val_i,
  output  logic [15:0]  deser_data_o,
  output  logic         deser_data_val_o
);

  // Input registers
  logic         srst_r;
  logic         data_r;
  logic         data_val_r;

  // Internal wires for DUT outputs
  logic [15:0]  deser_data_w;
  logic         deser_data_val_w;

  // Input synchronization (1 cycle delay)
  always_ff @(posedge clk_i) begin
    srst_r     <= srst_i;
    data_r     <= data_i;
    data_val_r <= data_val_i;
  end

  // DUT instance
  deserializer dut_inst (
    .clk_i           (clk_i),
    .srst_i          (srst_r),
    .data_i          (data_r),
    .data_val_i      (data_val_r),
    .deser_data_o    (deser_data_w),
    .deser_data_val_o(deser_data_val_w)
  );

  // Output registration (1 cycle delay)
  always_ff @(posedge clk_i) begin
    deser_data_o     <= deser_data_w;
    deser_data_val_o <= deser_data_val_w;
  end

endmodule
