class Driver;

  virtual deserializer_if.DRIVER vif;
  mailbox #(Transaction) gen2drv, drv2scb;

  function new( virtual deserializer_if.DRIVER vif_i, mailbox#(Transaction) gen2drv, drv2scb);
    this.vif = vif_i;
    this.gen2drv = gen2drv;
    this.drv2scb = drv2scb;
  endfunction

  task run();
    Transaction tr;

    forever
      begin
        int j;
        @(vif.drv_cb);

        gen2drv.get(tr);
        drv2scb.put(tr);

        if( `DEBUG_PRINT )
          $display("[Driver] %s", tr.to_string());

        for( int i = 0; i<32; i++ )
          begin
            vif.drv_cb.data     <= tr.data[i];
            vif.drv_cb.data_val <= tr.data_val[i];
            
            @(vif.drv_cb);
          end
        
        @(vif.drv_cb);

        vif.drv_cb.data     <= 'x;
        vif.drv_cb.data_val <= 'x;

        @(vif.drv_cb);

        repeat(tr.gap) @(vif.drv_cb);

        tr = null;
      end
  endtask
endclass
