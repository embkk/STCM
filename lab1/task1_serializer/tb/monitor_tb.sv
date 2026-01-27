class Monitor;
  virtual serializer_if.MONITOR vif;
  mailbox #(Transaction) mon2scb;

  function new(virtual serializer_if.MONITOR vif_i, mailbox#(Transaction) mon2scb);
    this.vif = vif_i;
    this.mon2scb = mon2scb;
  endfunction



  task run();
    Transaction tr;
    logic d, v;
    automatic bit tr_started;

    forever begin
      @vif.cb;

      if(vif.cb.ser_data_val)
        begin
          if(tr == null) tr = new();
          tr_started = '1;
          tr.data[15-tr.len] = vif.cb.ser_data;
          tr.len++;
          $display("[Monitor] valid bit=%b data=%b", vif.cb.ser_data, tr.data);
        end
      else if(tr_started)
        begin
          tr.data_mod = tr.len == 5'd16 ? 0 : tr.len;
          $display("[Monitor] Received trans %s", tr.to_string());
          mon2scb.put(tr);
          //$display("[Monitor] put to scb %s", tr.to_string());
          tr = null;
          tr_started = 0;
        end
    end
  endtask
endclass
