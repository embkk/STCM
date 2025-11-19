module bit_reverse_16 (
    input  logic [15:0] data_in,
    output logic [15:0] data_out
);

    // Прямое побитовое обращение через конкатенацию
    assign data_out = { data_in[0],  data_in[1],  data_in[2],  data_in[3],
                        data_in[4],  data_in[5],  data_in[6],  data_in[7],
                        data_in[8],  data_in[9],  data_in[10], data_in[11],
                        data_in[12], data_in[13], data_in[14], data_in[15] };

    // Альтернативный вариант через generate (более масштабируемый)
    /*
    genvar i;
    generate
        for (i = 0; i < 16; i = i + 1) begin : rev
            assign data_out[i] = data_in[15-i];
        end
    endgenerate
    */

endmodule
