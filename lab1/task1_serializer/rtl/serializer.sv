module serializer #()(
  input   logic         clk_i,
  input   logic         srst_i,
  input   logic[15..0]  data_i,
  input   logic[4..0]   data_mod_i,
  input   logic         data_vali_i
  output  logic         ser_data_o,
  output  logic         ser_data_val_o,
  output  logic         busy_o
);

endmodule