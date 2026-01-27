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

logic[3:0]   transaction_itr    = 4'b0000;

logic[15:0]  data_buffered;
logic[3:0]   data_mod_buffered  = 0;

// #1 - change state block
always_ff @( posedge clk_i )
  begin
    if( srst_i )
      begin
        transaction_itr   <= 4'b0000;
        data_buffered     <= 16'd0;
        data_mod_buffered <= 4'd0;

      end
    else
      begin
        if(transaction_itr < data_mod_buffered)
          begin
            transaction_itr   <= transaction_itr + 4'd1;

            //$display("V%b tstate remain %0d from %0d", ser_data_val_o, transaction_itr, data_mod_buffered);
          end
        else if( data_val_i && data_mod_i != 1 && data_mod_i != 2 )
          begin
            data_buffered           <=  {<<{data_i}};
            data_mod_buffered       <=  data_mod_i == 4'd0 ? 4'd15 : data_mod_i ;
            transaction_itr         <=  4'd0;
            $display("[DUT] Start %b with length", data_i, (data_mod_i == 4'd0 ? 4'd15 : data_mod_i));
          end
        else
          begin
              transaction_itr   <= 4'd0;
            data_mod_buffered <= 4'd0;
            data_buffered     <= 16'd0;
            //$display("No transaction");
          end
      end
  end

always_comb
  begin
    busy_o         = transaction_itr < data_mod_buffered;
    ser_data_val_o = transaction_itr < data_mod_buffered;
    ser_data_o     = data_buffered[ transaction_itr ];

    //if(busy_o)
    //$display("busy...");
    //if(ser_data_val_o)
    //$display("[DUT] Valid output data[%0d]=%b length %0d", transaction_itr, ser_data_o, data_mod_buffered);
    /*else
    $display("[DUT] Invalid ouput");*/
  end

endmodule
