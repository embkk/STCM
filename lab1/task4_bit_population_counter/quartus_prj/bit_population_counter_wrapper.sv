module bit_population_counter_wrapper #(
  parameter TEST_DATA_WIDTH = 2048
)(
    input  logic                              clk_i,
    input  logic                              srst_i,
    input  logic [TEST_DATA_WIDTH-1:0]        data_i,
    input  logic                              data_val_i,
    output logic [$clog2(TEST_DATA_WIDTH):0]  data_o,
    output logic                              data_val_o
);

    logic                        srst_r;
    logic [TEST_DATA_WIDTH-1:0]  data_r;
    logic                        data_val_r;

    logic [$clog2(TEST_DATA_WIDTH):0] data_w;
    logic                             data_val_w;

    always_ff @(posedge clk_i)
      begin
        srst_r     <= srst_i;
        data_r     <= data_i;
        data_val_r <= data_val_i;
      end

    bit_population_counter #(.WIDTH(TEST_DATA_WIDTH)) dut_inst (
        .clk_i       (clk_i),
        .srst_i      (srst_r),
        .data_i      (data_r),
        .data_val_i  (data_val_r),
        .data_o      (data_w),
        .data_val_o  (data_val_w)
    );

    always_ff @(posedge clk_i)
      begin
        data_o       <= data_w;
        data_val_o   <= data_val_w;
      end

endmodule