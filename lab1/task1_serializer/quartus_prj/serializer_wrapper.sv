module serializer_wrapper (
  input   logic         clk_i,
  input   logic         srst_i,
  input   logic[15:0]   data_i,
  input   logic[3:0]    data_mod_i,
  input   logic         data_val_i,
  output  logic         ser_data_o,
  output  logic         ser_data_val_o,
  output  logic         busy_o
);

  // Input registers
  logic         srst_r;
  logic[15:0]   data_r;
  logic[3:0]    data_mod_r;
  logic         data_val_r;
  
  // Output registers
  logic         ser_data_w;
  logic         ser_data_val_w;
  logic         busy_w;

  // Input synchronization
  always_ff @(posedge clk_i) begin
    srst_r      <= srst_i;
    data_r      <= data_i;
    data_mod_r  <= data_mod_i;
    data_val_r  <= data_val_i;
  end

  // DUT instance
  serializer dut_inst (
    .clk_i         (clk_i),
    .srst_i        (srst_r),
    .data_i        (data_r),
    .data_mod_i    (data_mod_r),
    .data_val_i    (data_val_r),
    .ser_data_o    (ser_data_w),
    .ser_data_val_o(ser_data_val_w),
    .busy_o        (busy_w)
  );

  // Output registration
  always_ff @(posedge clk_i) begin
    ser_data_o     <= ser_data_w;
    ser_data_val_o <= ser_data_val_w;
    busy_o         <= busy_w;
  end

endmodule
