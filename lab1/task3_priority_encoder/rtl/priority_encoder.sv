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

logic [WIDTH-1:0] data_buf_left;
logic [WIDTH-1:0] data_buf_right;
logic [WIDTH-1:0] data_buf_left_2compl;
logic [WIDTH-1:0] data_buf_right_2compl;

logic       busy;
logic       tr_start;
logic [1:0] tr_started_count;

assign tr_start   = data_val_i && !busy;
assign data_val_o = tr_started_count == 2;

always_ff @(posedge clk_i)
  if ( srst_i || tr_start )
    tr_started_count <= '0;
  else if ( busy )
    tr_started_count <= tr_started_count + 1;

always_ff @(posedge clk_i)
  if ( srst_i || data_val_o)
    busy <= '0;
  else if ( data_val_i && !busy && data_i != '0 )
    busy <= '1;


// Stage #0 - buffer

always_ff @(posedge clk_i)
  if ( tr_start )
    data_buf_right <= data_i;

always_ff @(posedge clk_i)
  if ( tr_start )
    data_buf_left <= reverse(data_i);


// Stage #1 - calc two compl 

always_ff @(posedge clk_i)
  data_buf_right_2compl <= ~data_buf_right + 'b1;

always_ff @(posedge clk_i)
  data_buf_left_2compl <= ~data_buf_left + 'b1;


// Stage #2 - calc output

always_ff @(posedge clk_i)
  data_right_o <= data_buf_right & data_buf_right_2compl;

always_ff @(posedge clk_i)
  data_left_o <= reverse(data_buf_left & data_buf_left_2compl);

function automatic [WIDTH-1:0] reverse (input [WIDTH-1:0] d);
  int i;
  for (i = 0; i < WIDTH; i = i + 1)
    reverse[i] = d[(WIDTH-1)-i];
endfunction

endmodule

