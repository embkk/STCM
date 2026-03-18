class Monitor;
  t_vif_mon vif;
  mailbox #(t_tr_mon) mon2scb;

  t_tr_mon tr;
  int            tr_count;

  extern function new(t_vif_mon vif_i, mailbox#(t_tr_mon) mon2scb);

  extern task send_tr(t_tr_mon tr);

  extern task run();

endclass

function Monitor::new(t_vif_mon vif_i, mailbox#(t_tr_mon) mon2scb);
  this.vif = vif_i;
  this.mon2scb = mon2scb;
endfunction

task Monitor::send_tr(t_tr_mon tr);
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
        t_tr_mon tr;
        
        tr = new();
        tr.data  = vif.mon_cb.data_o;

        send_tr(tr);
      end

    end
endtask