module priority_encoder_wrapper #(
    parameter int WIDTH = 32
)(
    input  logic              clk_i,
    input  logic              srst_i,
    input  logic [WIDTH-1:0]  data_i,
    input  logic              data_val_i,
    output logic [WIDTH-1:0]  data_left_o,
    output logic [WIDTH-1:0]  data_right_o,
    output logic              data_val_o
);

    logic              srst_r;
    logic [WIDTH-1:0]  data_r;
    logic              data_val_r;

    logic [WIDTH-1:0]  data_left_w;
    logic [WIDTH-1:0]  data_right_w;
    logic              data_val_w;

    always_ff @(posedge clk_i) begin
        srst_r     <= srst_i;
        data_r     <= data_i;
        data_val_r <= data_val_i;
    end

    priority_encoder #(.WIDTH(WIDTH)) dut_inst (
        .clk_i      (clk_i),
        .srst_i     (srst_r),
        .data_i     (data_r),
        .data_val_i (data_val_r),
        .data_left_o (data_left_w),
        .data_right_o(data_right_w),
        .data_val_o  (data_val_w)
    );

    always_ff @(posedge clk_i) begin
        data_left_o  <= data_left_w;
        data_right_o <= data_right_w;
        data_val_o   <= data_val_w;
    end

endmodule