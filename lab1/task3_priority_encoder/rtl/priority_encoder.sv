module priority_encoder #(
  parameter WIDTH = 64
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

always_ff @(posedge clk_i)
  for (int i = 0; i < WIDTH; i++)
    if (data_i[i])
      data_left_o = WIDTH'(1) << i;

always_ff @(posedge clk_i)
  for (int i = WIDTH-1; i >= 0; i--)
    if (data_i[i])
      data_right_o = WIDTH'(1) << i;

  always_ff @(posedge clk_i) begin
    if (srst_i) begin
      data_val_o <= '0;
    end else begin
      data_val_o <= data_val_i && (data_i != '0);
    end
  end

endmodule