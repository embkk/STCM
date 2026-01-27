class Driver;

  virtual serializer_if.DRIVER vif;
  mailbox #(Transaction) gen2drv, drv2scb;
  function new(virtual serializer_if.DRIVER vif_i, mailbox#(Transaction) gen2drv, drv2scb);
    this.vif = vif_i;
    this.gen2drv = gen2drv;
    this.drv2scb = drv2scb;
  endfunction

  task run(input int num_transactions);
    Transaction tr;

    repeat(num_transactions)
      begin

        gen2drv.get(tr);
        drv2scb.put(tr);

        $display("[Driver] %s", tr.to_string());

        vif.cb.data     <= tr.data;
        vif.cb.data_mod <= tr.data_mod;

        vif.cb.data_val <= 1'b1;
        @(vif.cb);

        vif.cb.data_val <= 1'b0;
        @(vif.cb);

        wait(!vif.cb.busy);

        tr = null;
      end
  endtask
endclass
