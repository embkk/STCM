module mux16to1 (
    input  wire [15:0] in,   // 16 однобитных входов
    input  wire [3:0]  sel,  // 4-битный селектор
    output wire        out   // выбранный бит
);
    assign out = in[sel];
endmodule
