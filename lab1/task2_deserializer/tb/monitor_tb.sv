class Monitor;
  virtual deserializer_if.MONITOR vif;
  mailbox #(Transaction) mon2scb;

  Transaction tr;
  int tr_count = 1;

  extern function new(virtual deserializer_if.MONITOR vif_i, mailbox#(Transaction) mon2scb);

  extern task send_tr();

  extern task run();

endclass

function Monitor::new(virtual deserializer_if.MONITOR vif_i, mailbox#(Transaction) mon2scb);
  this.vif = vif_i;
  this.mon2scb = mon2scb;
endfunction

task Monitor::send_tr();
  begin
    tr_count++;
    mon2scb.put(tr);
    if(`DEBUG_PRINT)
      $display("[MON] Sent transaction %s", tr.to_string());
    
    tr = new();
  end
endtask

task Monitor::run();
  tr = new();

  forever
    begin
      @vif.mon_cb;

      if(vif.mon_cb.deser_data_val)
      begin
        tr.data = vif.mon_cb.deser_data;
        send_tr();
      end

    end
endtask