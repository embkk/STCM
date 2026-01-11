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

enum logic {
  WAIT,
  TRANSACTION
} state;

logic[3:0] transaction_itr;

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
        state           <=  WAIT;
      end
    else
      begin
        ser_data_val_o <= state == TRANSACTION;
        busy_o         <= state == TRANSACTION;

        case (state)
          WAIT:
            begin
              if (data_val_i && !(data_mod_i inside {1,2}))
                begin
                  $display("Change state: TRANSACTION");
                  transaction_itr <= 4'd0;
                  state           <= TRANSACTION;
                end
            end

          TRANSACTION:
            begin
              ser_data_o        <=  data_i[transaction_itr];

              if (transaction_itr >= data_mod_i && transaction_itr!=15 )
                begin
                  transaction_itr <= transaction_itr + 1'b1;
                end
              else
                begin
                  $display("Change state: WAIT");
                  state <= WAIT;
                end
            end

          default: state <= WAIT;
        endcase
      end

      if(state == TRANSACTION)
      begin
        $display("Output %0d, tr_itr %0d tr_flag %0d", ser_data_o, transaction_itr, state.name);
      end
      //else
      //  $display("Output invalid");
  end

function void send_data();

endfunction

endmodule