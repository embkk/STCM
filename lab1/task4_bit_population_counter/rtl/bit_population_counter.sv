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

localparam int STAGES_COUNT = $clog2(WIDTH/2);

logic [STAGES_COUNT:0] val_pipe;

always_ff @(posedge clk_i)
  if (srst_i)
    val_pipe <= '0;
  else
    val_pipe <= {val_pipe[STAGES_COUNT-1:0], data_val_i};

assign data_val_o = val_pipe[STAGES_COUNT];
assign data_o = stages[STAGES_COUNT-1].sums[0];

genvar step;
generate
    for (step = 0; step < $clog2(WIDTH/2); step++ )
    begin : stages

      localparam int MAX_VAL = (2 << step) * 2'b11;
      localparam int SUM_WIDTH = $clog2(MAX_VAL + 1);
      localparam int SUM_COUNT = (WIDTH/2) >> step;

      logic [SUM_WIDTH:0] sums [SUM_COUNT/2];

      initial
        $display("INIT STAGE: %0d | MAX_VAL: %0d | SUM_WIDTH: %0d", step, MAX_VAL, SUM_WIDTH);

      if( step == 0)
        always_ff @(posedge clk_i)
          begin
            $write("\n[STEP %0d] ", step);
            for (int j = 0; j < SUM_COUNT/2; j++)
              begin
                sums[j] <= (data_i[4*j+1] + data_i[4*j]) + (data_i[4*j+3] + data_i[4*j+2]);
                $write("%0d ", (data_i[4*j+1] + data_i[4*j]) + (data_i[4*j+3] + data_i[4*j+2])); 
              end
            $write("\t\t\tMAX_VAL=%0d SUM_WIDTH=%0d ", MAX_VAL, SUM_WIDTH);
            $display(" (data_i %b)", data_i);
          end
      else
        always_ff @(posedge clk_i)
          begin
            $write("[STEP %0d] ", step);
            for (int j = 0; j < SUM_COUNT/2; j++)
            begin
              // Тянем из предыдущего блока. Для step=1 это stages[0], всё законно
              sums[j] <= stages[step-1].sums[2*j] + stages[step-1].sums[2*j+1];
              $write("%0d ", (stages[step-1].sums[2*j] + stages[step-1].sums[2*j+1]));  
            end
            $write("\t\t\tMAX_VAL=%0d SUM_WIDTH=%0d ", MAX_VAL, SUM_WIDTH);
            $display("");
          end

      always_ff @(posedge clk_i)
        begin
        end
    end
endgenerate

/*always_ff @(posedge clk_i)
  begin
    for(int i = 0; i < STAGES_COUNT; i++)
      $display("Block stages[%0d]: VEC_W = %0d", i, 0);
      $display("\n\n");
  end*/


endmodule

