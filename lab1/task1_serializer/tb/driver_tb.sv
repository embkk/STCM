class Driver;

  virtual serializer_if.DRIVER vif;
  mailbox #(Transaction) gen2drv, drv2scb;
  function new(virtual serializer_if.DRIVER vif_i, mailbox#(Transaction) gen2drv, drv2scb);
    this.vif = vif_i;
    this.gen2drv = gen2drv;
    this.drv2scb = drv2scb;
  endfunction

  task run();
    Transaction tr;

    forever begin
      gen2drv.get(tr);
      drv2scb.put(tr);
      $display("[Driver] get from gen %s", tr.to_string());
      $display("[Driver] put to scb %s", tr.to_string());
      while (vif.cb.busy === 1'b1) @(vif.cb);
      vif.cb.data     <= tr.data;
      vif.cb.data_mod <= tr.data_mod;
      vif.cb.data_val <= 1'b1;
      @(vif.cb);
      vif.cb.data_val <= 1'b0;
    end
  endtask
endclass
