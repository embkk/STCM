module deserializer (
  input   logic         clk_i,
  input   logic         srst_i,
  input   logic         data_i,
  input   logic         data_val_i,
  output  logic         deser_data_o,
  output  logic         deser_data_val_o
);

logic [3:0]  tr_counter;

always_ff @( posedge clk_i )
  if ( data_val_i )
    deser_data_o <= ( deser_data_o << 1 ) & data_i;

always_ff @( posedge clk_i )
  if( data_val_i )
    tr_counter <= tr_counter + 1;

always_ff @( posedge clk_i )
  deser_data_val_o <= tr_counter == 4'd15 && data_val_i;


endmodule