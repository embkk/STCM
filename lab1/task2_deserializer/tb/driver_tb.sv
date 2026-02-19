class Driver;

  virtual deserializer_if.DRIVER vif;
  mailbox #(Request) gen2drv, drv2scb;

  function new( virtual deserializer_if.DRIVER vif_i, mailbox#(Request) gen2drv, drv2scb);
    this.vif = vif_i;
    this.gen2drv = gen2drv;
    this.drv2scb = drv2scb;
  endfunction

  task run();
    Request req;

    forever
      begin
        int j;
        @(vif.drv_cb);

        gen2drv.get(req);
        drv2scb.put(req);

        if( `DEBUG_PRINT )
          $display("[Driver] %s", req.to_string());

        repeat(req.gap) @(vif.drv_cb);

        for( int i = 0; i<32; i++ )
          begin
            vif.drv_cb.data     <= req.data[i];
            vif.drv_cb.data_val <= req.data_val[i];
            
            @(vif.drv_cb);
          end
        
        @(vif.drv_cb);

        vif.drv_cb.data     <= 'x;
        vif.drv_cb.data_val <= '0;

        @(vif.drv_cb);

        req = null;
      end
  endtask
endclass
