class Driver;
  
  virtual serializer_if.DRIVER vif;
  mailbox #(Transaction) gen2drv, drv2scb;
  function new(virtual serializer_if.DRIVER vif_i, mailbox #(Transaction) gen2drv, drv2scb);
    this.vif = vif_i;
    this.gen2drv = gen2drv;
    this.drv2scb = drv2scb;
  endfunction

  task run();
    Transaction tr;

    forever
      begin
        gen2drv.get(tr);
        @vif.cb;
        vif.send(tr.data, tr.len);
      end
  endtask
endclass