class Monitor;
  virtual bit_population_counter_if.MONITOR vif;
  mailbox #(TransactionMon) mon2scb;

  TransactionMon tr;
  int            tr_count;

  extern function new(virtual bit_population_counter_if.MONITOR vif_i, mailbox#(TransactionMon) mon2scb);

  extern task send_tr(TransactionMon tr);

  extern task run();

endclass

function Monitor::new(virtual bit_population_counter_if.MONITOR vif_i, mailbox#(TransactionMon) mon2scb);
  this.vif = vif_i;
  this.mon2scb = mon2scb;
endfunction

task Monitor::send_tr(TransactionMon tr);
  begin
    tr_count++;
    mon2scb.put(tr);
    if(`DEBUG_PRINT)
      $display("[MON] Obeserved #%0d %s", tr_count, tr.to_string());
  end
endtask

task Monitor::run();

  forever
    begin
      @vif.mon_cb;

      if(vif.mon_cb.data_val_o)
      begin
        TransactionMon tr;
        
        tr = new();
        tr.data  = vif.mon_cb.data_o;

        send_tr(tr);
      end

    end
endtask