class Driver;

  virtual serializer_if.DRIVER vif;
  mailbox #(Transaction) gen2drv, drv2scb;

  event e_tr_sent;

  function new( virtual serializer_if.DRIVER vif_i, mailbox#(Transaction) gen2drv, drv2scb);
    this.vif = vif_i;
    this.gen2drv = gen2drv;
    this.drv2scb = drv2scb;
  endfunction

  task run();
    Transaction tr;

    forever
      begin

        //drv_sem.get(1);

        while(vif.drv_cb.busy)
            @(vif.drv_cb);

        gen2drv.get(tr);
        drv2scb.put(tr);

        if( `DEBUG_PRINT )
          $display("[Driver] %s", tr.to_string());

        vif.drv_cb.data     <= tr.data;
        vif.drv_cb.data_mod <= tr.data_mod;

        vif.drv_cb.data_val <= 1'b1;

        -> e_tr_sent;
        
        @(vif.drv_cb);

        vif.drv_cb.data_val <= 1'b0;
        vif.drv_cb.data     <= 'x;
        vif.drv_cb.data_mod <= 'x;

        @(vif.drv_cb);

        repeat(tr.gap) @(vif.drv_cb);

        tr = null;
      end
  endtask
endclass
