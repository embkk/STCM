module serializer (
  input   logic         clk_i,
  input   logic         srst_i,
  input   logic[15:0]   data_i,
  input   logic[3:0]    data_mod_i,
  input   logic         data_val_i,
  output  logic         ser_data_o,
  output  logic         ser_data_val_o,
  output  logic         busy_o
);

logic[4:0]   tr_itr;
logic[4:0]   tr_len;
logic[15:0]  data_buffered;

always_ff @( posedge clk_i )
  if( srst_i )
    tr_itr <= '0;
  else if( data_val_i )
    tr_itr <= '0;
  else if( tr_itr < tr_len )
  begin
    tr_itr <= tr_itr + 5'd1;
  end


always_ff @( posedge clk_i )
  if ( srst_i )
    tr_len <= '0;
  else if( data_mod_i == 1 || data_mod_i == 2)
    tr_len <= '0;
  else if( data_val_i )
    tr_len <= (data_mod_i == '0) ? 5'd16 : data_mod_i;

always_ff @( posedge clk_i )
  if( srst_i )
    data_buffered <= '1;
  else if ( data_val_i )
    data_buffered <= reverse_bits(data_i);


assign busy_o         = tr_itr < tr_len;
assign ser_data_val_o = tr_itr < tr_len;
assign ser_data_o     = data_buffered[ tr_itr ];

function logic[15:0] reverse_bits(logic[15:0] data_in);
  for (int i = 0; i < 16; i++)
    reverse_bits[i] = data_in[15-i];
endfunction

endmodule
