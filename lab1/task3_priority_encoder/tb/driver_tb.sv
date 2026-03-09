class Driver;

  virtual priority_encoder_if.DRIVER vif;
  mailbox #(TransactionGen) gen2drv;
  mailbox #(TransactionGen) drv2scb;

  function new( virtual priority_encoder_if.DRIVER vif_i, mailbox#(TransactionGen) gen2drv, drv2scb);
    this.vif = vif_i;
    this.gen2drv = gen2drv;
    this.drv2scb = drv2scb;
  endfunction

  task run();
    TransactionGen tr;
    int send_count;

    vif.drv_cb.data_val_i <= 0;

    vif.drv_cb.srst_i <= 1'b1;

    repeat(2)
      @(vif.drv_cb);

    vif.drv_cb.srst_i <= 1'b0;
    @(vif.drv_cb);

    forever
      begin
        
        gen2drv.get(tr);


        if(tr.gap) 
          begin
            vif.drv_cb.data_i     <= 'x;
            vif.drv_cb.data_val_i <= '0;
            
            repeat(tr.gap) 
              @(vif.drv_cb);
          end

        vif.drv_cb.data_i <= tr.data;
        vif.drv_cb.data_val_i <= '1;
        
        @(vif.drv_cb);

        drv2scb.put(tr);
        
        if( `DEBUG_PRINT )
          $display("[Driver] %s", tr.to_string());
        
        vif.drv_cb.data_val_i <= '0;

        repeat(tr.WIDTH)
          @(vif.drv_cb);
        
        tr = null;
      end
  endtask
endclass
