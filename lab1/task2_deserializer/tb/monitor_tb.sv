class Monitor;
  virtual serializer_if.MONITOR vif;
  mailbox #(Sample) mon2scb;

  event e_sample_sent;

  Sample smp;
  int sample_count = 1;

  extern function new(virtual serializer_if.MONITOR vif_i, mailbox#(Sample) mon2scb);

  extern task start_sample();

  extern task run();

endclass

function Monitor::new(virtual serializer_if.MONITOR vif_i, mailbox#(Sample) mon2scb);
  this.vif = vif_i;
  this.mon2scb = mon2scb;
endfunction

task Monitor::start_sample();

  if(smp != null)
    begin
      sample_count++;
      mon2scb.put(smp);
      
      -> e_sample_sent;
    end

  smp = new();

endtask

task Monitor::run();
  start_sample();

  forever
    begin
      @vif.mon_cb;

      if(vif.mon_cb.ser_data_val || vif.mon_cb.busy)
        smp.add(vif.mon_cb.ser_data_val, vif.mon_cb.ser_data, vif.mon_cb.busy);

      if( !vif.mon_cb.ser_data_val && smp.val_count > 0 )
        begin
          if( `DEBUG_PRINT )
            $display("[MON] %0d sample ready %s", sample_count, smp.to_string());

          start_sample();
        end
    end
endtask
