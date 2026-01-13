import testbench_pkg::*;

module serializer (
  input   logic         clk_i,
  input   logic         srst_i,
  input   logic[0:15]   data_i,
  input   logic[3:0]    data_mod_i,
  input   logic         data_val_i,
  output  logic         ser_data_o,
  output  logic         ser_data_val_o,
  output  logic         busy_o
);

enum logic[2:0] {
  IDLE_S,
  WAIT_S,
  TRANSACTION_S
} state, next_state;

logic[3:0] transaction_remain_cnt = 4'b0000;

// #1 - change state block
always_ff @( posedge clk_i )
  begin
    if( srst_i )
      begin
        state <=  IDLE_S;
      end
    else
      begin
        state <= next_state;

        if( state != TRANSACTION_S && next_state == TRANSACTION_S )
          transaction_remain_cnt <= data_mod_i == 4'd0 ? 4'd15 : data_mod_i;
        else
          transaction_remain_cnt <= transaction_remain_cnt - 4'd1;
      end
  end

// #2 - next_state block
always_comb
  begin
    unique case( state )
      IDLE_S, WAIT_S:
        begin
          if( data_val_i && data_mod_i != 1 && data_mod_i != 2 )
            next_state = TRANSACTION_S;
          else
            next_state = WAIT_S;
        end
      TRANSACTION_S:
        begin
          if( transaction_remain_cnt == 0 )
            next_state = WAIT_S;
          else
            next_state = TRANSACTION_S;
        end
      default:
        begin
          next_state = IDLE_S;
        end
    endcase 
  end

// #3 - output values set
always_comb
  begin
    busy_o         = ( state == TRANSACTION_S );
    ser_data_val_o = ( state == TRANSACTION_S ) && ( transaction_remain_cnt > 0 || data_mod_i == 0 );
    ser_data_o     = data_i[ ( data_mod_i == 0 ? 15 : data_mod_i ) - transaction_remain_cnt ];
  end

endmodule