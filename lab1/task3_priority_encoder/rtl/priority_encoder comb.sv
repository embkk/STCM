/* rude test for quartus timing


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

always_comb
  begin
    data_left_o = '0;
    data_right_o = '0;
    for(int idx=0; idx<WIDTH; idx++)
      begin
        if( data_i[idx] == 1'b1 )
          data_left_o = WIDTH'(1) << idx;
      end

    for(int idx=WIDTH-1; idx>=0; idx--)
      begin
        if( data_i[idx] == 1'b1 )
          data_right_o = WIDTH'(1) << idx;
      end
  end

always_comb
begin
  data_val_o = data_val_i;
end

endmodule*/