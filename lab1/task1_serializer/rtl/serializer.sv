import testbench_pkg::*;

module serializer #()(
  input   logic         clk_i,
  input   logic         srst_i,
  input   logic[15:0]   data_i,
  input   logic[4:0]    data_mod_i,
  input   logic         data_val_i,

  output  logic         ser_data_o,
  output  logic         ser_data_val_o,
  output  logic         busy_o
);

logic make_output;
logic itr;

always_ff @(posedge clk_i or posedge srst_i)
  begin
    if( srst_i )
      begin
        ser_data_val_o  <=  1'b0;
        ser_data_o      <=  1'b0;
        busy_o          <=  1'b0;
      end
    else if( clk_i )
      begin
        if( data_mod_i == 1 && data_mod_i == 2 )
          begin
            // input data invalid
            // but we can still send bits
            
            //ser_data_val_o <= 0;
          end

        if( data_val_i && itr < data_mod_i )
          begin
            itr             <=  itr + 1;
            ser_data_o      <=  data_i;
            busy_o          <=  1'b1;
            ser_data_val_o  <=  1'b1;
          end
      end
  end

function void send_data();

endfunction

endmodule