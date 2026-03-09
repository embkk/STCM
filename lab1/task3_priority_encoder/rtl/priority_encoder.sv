module priority_encoder #(
  parameter WIDTH = 32
)
(
  input  logic             clk_i,
  input  logic             srst_i,
  input  logic [WIDTH-1:0] data_i,
  input  logic             data_val_i,

  output logic [WIDTH-1:0] data_left_o,
  output logic [WIDTH-1:0] data_right_o,
  output logic             data_val_o
);

logic [WIDTH-1:0] data_buffer;
logic             right_val;
logic             left_val;

logic             busy;

assign right_val  = (data_right_o & data_buffer) != '0;
assign left_val   = (data_left_o & data_buffer) != '0;
assign data_val_o = right_val && left_val && busy;

always_ff @(posedge clk_i)
  begin
    if ( srst_i)
      busy <= '0;
    else if ( data_val_i && !busy && data_i != '0 )
      busy <= '1;
    else if ( data_val_o )
      busy <= '0;
  end

always_ff @(posedge clk_i)
  if ( data_val_i && !busy )
    data_buffer <= data_i;


always_ff @(posedge clk_i)
  begin
    if (srst_i || (data_val_i && !busy))
      data_left_o <= 'b1 << (WIDTH - 1);
    else if( !(left_val) )
      data_left_o <= (data_left_o >> 1);
  end
  
always_ff @(posedge clk_i)
  begin
    if (srst_i || (data_val_i && !busy))
      data_right_o <= 'b1;
    else if( !(right_val) )
      data_right_o <= (data_right_o << 1);
  end

endmodule