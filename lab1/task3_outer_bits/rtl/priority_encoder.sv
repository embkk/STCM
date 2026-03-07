module deserializer (
  input  logic             clk_i,
  input  logic             srst_i;
  input  logic [WIDTH-1:0] data_i;
  input  logic             data_val_i;

  output logic [WIDTH-1:0] data_left_o;
  output logic [WIDTH-1:0] data_right_o;
  output logic             data_val_o;
);


always_ff @( posedge clk_i )
  if ( data_val_i )
    data_i <= '1;

always_ff @( posedge clk_i )
  if( srst_i )
    data_val_o <= '0;

endmodule