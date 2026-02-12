module serializer (
  input   logic         clk_i,
  input   logic         srst_i,
  input   logic         data_i,
  input   logic         data_val_i,
  output  logic         deser_data_o,
  output  logic         deser_data_val_o
);

logic[15:0]  tr_mask;
logic[15:0]  data_buffered;
logic        tr_act;

/*always_ff @(posedge clk_i)
  if (srst_i)
    tr_mask <= '0;
  else if (data_val_i)
    begin
      if (data_mod_i == 4'd1 || data_mod_i == 4'd2)
        tr_mask <= '0;
      else if (data_mod_i == 4'd0)
        tr_mask <= '1;
      else
        tr_mask <= 16'hFFFF << (16 - data_mod_i);
    end
  else if (tr_act)
    tr_mask <= tr_mask << 1;

always_ff @( posedge clk_i )
  if ( data_val_i )  
    data_buffered <= data_i;
  else
    data_buffered <= data_buffered << 1;

assign tr_act = tr_mask[15];

assign ser_data_o = data_buffered[15];

assign ser_data_val_o = tr_act;
 
assign busy_o = tr_act;*/

endmodule