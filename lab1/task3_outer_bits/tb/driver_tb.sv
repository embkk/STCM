class Driver;

  virtual priority_encoder_if.DRIVER vif;
  mailbox #(TransactionGen) gen2drv;
  mailbox #(Transaction)    drv2scb;

  function new( virtual priority_encoder_if.DRIVER vif_i, mailbox#(TransactionGen) gen2drv, mailbox#(Transaction) drv2scb);
    this.vif = vif_i;
    this.gen2drv = gen2drv;
    this.drv2scb = drv2scb;
  endfunction

  task run();
    TransactionGen tr;
    int send_count;

    vif.drv_cb.data_val <= 0;

    vif.drv_cb.srst <= 1'b1;

    repeat(2)
      @(vif.drv_cb);

    vif.drv_cb.srst <= 1'b0;
    @(vif.drv_cb);

    forever
      begin
        
        gen2drv.get(tr);
        drv2scb.put(tr);

        if( `DEBUG_PRINT )
          $display("[Driver] %s", tr.to_string());

        if(tr.gap) 
          begin
            vif.drv_cb.data     <= 'x;
            vif.drv_cb.data_val <= '0;
            
            repeat(tr.gap) 
              @(vif.drv_cb);
          end

        // transaction

        tr = null;
      end
  endtask
endclass
