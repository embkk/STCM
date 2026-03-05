class Driver #(parameter RANDOM_VALID_ENABLE = 1);

  virtual deserializer_if.DRIVER vif;
  mailbox #(Transaction) gen2drv, drv2scb;

  function new( virtual deserializer_if.DRIVER vif_i, mailbox#(Transaction) gen2drv, drv2scb);
    this.vif = vif_i;
    this.gen2drv = gen2drv;
    this.drv2scb = drv2scb;
  endfunction

  task run();
    Transaction tr;
    int send_count;

    vif.drv_cb.data_val <= 0;

    vif.drv_cb.srst <= 1'b1;
    repeat(2)
      @(vif.drv_cb);

    vif.drv_cb.srst <= 1'b0;
    @(vif.drv_cb);

    forever
      begin
        

        @(vif.drv_cb);

        gen2drv.get(tr);
        drv2scb.put(tr);

        if( `DEBUG_PRINT )
          $display("[Driver] %s", tr.to_string());

        repeat(tr.gap) @(vif.drv_cb);

        for( send_count = 0; send_count <16; send_count++ )
          begin
            if(RANDOM_VALID_ENABLE)
              repeat( $urandom_range(0, 3) )
                begin
                  vif.drv_cb.data_val <= 0;
                  @(vif.drv_cb);
                end

            vif.drv_cb.data <= tr.data[send_count];
            vif.drv_cb.data_val <= 1;

            @(vif.drv_cb);
            
          end

        @(vif.drv_cb);

        vif.drv_cb.data     <= 'x;
        vif.drv_cb.data_val <= '0;

        @(vif.drv_cb);

        tr = null;
      end
  endtask
endclass
