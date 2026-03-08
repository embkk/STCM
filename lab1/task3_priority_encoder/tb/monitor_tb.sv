class Monitor;
  virtual priority_encoder_if.MONITOR vif;
  mailbox #(TransactionMon) mon2scb;

  TransactionMon tr;
  int tr_count = 1;

  extern function new(virtual priority_encoder_if.MONITOR vif_i, mailbox#(TransactionMon) mon2scb);

  extern task send_tr();

  extern task run();

endclass

function Monitor::new(virtual priority_encoder_if.MONITOR vif_i, mailbox#(TransactionMon) mon2scb);
  this.vif = vif_i;
  this.mon2scb = mon2scb;
endfunction

task Monitor::send_tr();
  begin
    tr_count++;
    mon2scb.put(tr);
    if(`DEBUG_PRINT)
      $display("[MON] Obeserved %s", tr.to_string());
    
    tr = new();
  end
endtask

task Monitor::run();
  tr = new();

  forever
    begin
      @vif.mon_cb;

      if(vif.mon_cb.data_val_o)
      begin
        tr.data_left  = vif.mon_cb.data_left_o;
        tr.data_right = vif.mon_cb.data_right_o;
        send_tr();
      end

    end
endtask