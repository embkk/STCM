class Driver;

  t_vif_drv vif;
  mailbox #(t_tr_gen) gen2drv;
  mailbox #(t_tr_gen) drv2scb;

  function new( t_vif_drv vif_i, mailbox#(t_tr_gen) gen2drv, drv2scb);
    this.vif = vif_i;
    this.gen2drv = gen2drv;
    this.drv2scb = drv2scb;
  endfunction

  task run();
    t_tr_gen tr;
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

        tr = null;
      end
  endtask
endclass
