module serializer (
  input   logic         clk_i,
  input   logic         srst_i,
  input   logic[15:0]   data_i,
  input   logic[3:0]    data_mod_i,
  input   logic         data_val_i,
  output  logic         ser_data_o,
  output  logic         ser_data_val_o,
  output  logic         busy_o
);

logic[4:0]   tr_itr    = '0;
logic[4:0]   tr_len    = '0;

logic[15:0]  data_buffered;


always_ff @( posedge clk_i )
  begin
    if( srst_i )
      begin
        tr_itr            <= 5'b0000;
        data_buffered     <= 16'd0;
        tr_len            <= 5'd0;

      end
    else
      begin
        if(tr_itr < tr_len)
          begin
            tr_itr   <= tr_itr + 5'd1;

          end
        else if( data_val_i && data_mod_i != 1 && data_mod_i != 2 )
          begin
            for (int i = 0; i < 16; i++)
            begin
              data_buffered[i] <= data_i[15-i];
            end
            tr_len       <=  data_mod_i == 5'd0 ? 5'd16 : data_mod_i;
            tr_itr       <=  5'd0;
            $display("DUT start tr %0d", (data_mod_i == 5'd0 ? 5'd16 : data_mod_i));
          end
        else
          begin
            tr_itr            <= 5'd0;
            tr_len            <= 5'd0;
            data_buffered     <= 16'd0;
          end
      end
  end

  assign busy_o         = tr_itr < tr_len || data_val_i;
  assign ser_data_val_o = tr_itr < tr_len || (tr_itr == 5'd15 && tr_len == 5'd16);
  assign ser_data_o     = data_buffered[ tr_itr ];

always_ff @( posedge clk_i )
begin
  if(ser_data_val_o)
  begin
    $display("DUT output %b", ser_data_o);
  end
  else
    $display("X");
end

endmodule
