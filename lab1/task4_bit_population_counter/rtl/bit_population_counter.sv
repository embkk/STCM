module bit_population_counter #(
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

typedef enum logic {
    LEFT = 1'b0,
    RIGHT = 1'b1
} e_side;


typedef enum logic {
    CURR = 1'b0,
    PREV = 1'b1
} e_data;
  
localparam int STAGES = 2;
logic [STAGES:0] valid;

logic [WIDTH-1:0] stage0 [RIGHT:LEFT];
logic [WIDTH-1:0] stage1 [RIGHT:LEFT][PREV:CURR];

assign data_val_o = valid[STAGES];

always_ff @(posedge clk_i)
  if (srst_i)
    valid <= '0;
  else
    valid <= {valid[STAGES-1:0], ( data_val_i && data_i != '0 )};


// Stage #0 - buffer

always_ff @(posedge clk_i)
    stage0[RIGHT] <= data_i;

always_ff @(posedge clk_i)
    stage0[LEFT] <= reverse(data_i);


// Stage #1 - calc two compl 

always_ff @(posedge clk_i)
  stage1[RIGHT][CURR] <= ~stage0[RIGHT] + 'b1;

always_ff @(posedge clk_i)
  stage1[RIGHT][PREV] <= stage0[RIGHT];

always_ff @(posedge clk_i)
  stage1[LEFT][CURR] <= ~stage0[LEFT] + 'b1;

always_ff @(posedge clk_i)
  stage1[LEFT][PREV] <= stage0[LEFT];


// Stage #2 - calc output

always_ff @(posedge clk_i)
  data_right_o <= stage1[RIGHT][CURR] & stage1[RIGHT][PREV];

always_ff @(posedge clk_i)
  data_left_o <= reverse(stage1[LEFT][CURR] & stage1[LEFT][PREV]);


// Reverse

function automatic [WIDTH-1:0] reverse (input [WIDTH-1:0] d);
  int i;
  for (i = 0; i < WIDTH; i = i + 1)
    reverse[i] = d[(WIDTH-1)-i];
endfunction

endmodule

