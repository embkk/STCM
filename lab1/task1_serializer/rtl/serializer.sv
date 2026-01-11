import testbench_pkg::*;

module serializer #()(
  input   logic         clk_i,
  input   logic         srst_i,
  input   logic[0:15]   data_i,
  input   logic[3:0]    data_mod_i,
  input   logic         data_val_i,
  output  logic         ser_data_o,
  output  logic         ser_data_val_o,
  output  logic         busy_o
);

logic[3:0]  transaction_itr;
logic       transaction_flag;

always_ff @(posedge clk_i)
  begin
    //$display("IN: %0b M:%02d V:%b | rst:%b", data_i, data_mod_i, data_val_i, srst_i);
    if( srst_i )
      begin
        $display("Reset event");
        transaction_itr <=  4'b0000;
        ser_data_val_o  <=  1'b0;
        ser_data_o      <=  1'b0;
        busy_o          <=  1'b0;
      end
    else
      begin
        if( data_val_i )
          begin
            // driver-module checked for BUSY
            // start new serialization
            $display("START transaction %0d", data_mod_i);
            transaction_itr   <= 0;
            transaction_flag  <= 1;
            
          end

        if( data_mod_i == 1 ||  data_mod_i == 2 || (transaction_itr > data_mod_i && transaction_flag) )
          begin
            // stop any transaction
            $display("STOP transaction at itr %0d / %0d", transaction_itr, data_mod_i);
            ser_data_val_o   <= 0;
            busy_o           <= 0;
            transaction_flag <= 0;
          end
        else if (transaction_flag)
          begin
            //$display("DO transaction at itr %0d / %0d", transaction_itr, data_mod_i);
            ser_data_o        <=  data_i[transaction_itr];
            transaction_itr   <=  transaction_itr + 1;
            ser_data_val_o    <=  1'b1;
            busy_o            <=  1'b1;
          end
      end

      if(ser_data_val_o || transaction_flag)
      begin
        //$display("Output %0d, tr_itr %0d tr_flag %0d", ser_data_o, transaction_itr, transaction_flag);
      end
      //else
      //  $display("Output invalid");
  end

function void send_data();

endfunction

endmodule