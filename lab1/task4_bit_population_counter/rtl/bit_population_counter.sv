module bit_population_counter #(
  parameter WIDTH = 32
)
(
  input  logic                   clk_i,
  input  logic                   srst_i,
  input  logic [WIDTH-1:0]       data_i,
  input  logic                   data_val_i,

  output logic [$clog2(WIDTH):0] data_o,
  output logic                   data_val_o
);

localparam int CNT_WIDTH = $clog2(WIDTH/2 + 1);

logic [WIDTH-1:0]     data_buffer;
logic [WIDTH-1:0]     data_mask;
logic                 tr_start;
logic                 busy;

always_ff @(posedge clk_i)
  if (srst_i)
    busy <= 1'b0;
  else if (tr_start)
    busy <= 1'b1;
  else if (data_val_o)
    busy <= 1'b0;

always_ff @(posedge clk_i)
  if(srst_i)
    data_buffer <= '0;
  else if (data_val_i)
    data_buffer <= data_i;
  else
    data_buffer <= data_buffer >> 2;

always_ff @(posedge clk_i)
  if(srst_i)
    data_mask <= '1;
  else if (tr_start)
    data_mask <= '1;
  else
    data_mask <= data_mask >> 2;

assign data_val_o = !data_mask[0] && busy;
assign tr_start   = data_val_i && !busy;

always_ff @(posedge clk_i)
  if( srst_i || tr_start )
    data_o <= '0;
  else if ( busy )
    data_o <= data_o + data_buffer[0] + data_buffer[1];


endmodule

