class Monitor;
  virtual deserializer_if.MONITOR vif;
  mailbox #(Sample) mon2scb;

  Sample smp;
  int sample_count = 1;

  extern function new(virtual deserializer_if.MONITOR vif_i, mailbox#(Sample) mon2scb);

  extern task start_sample();

  extern task run();

endclass

function Monitor::new(virtual deserializer_if.MONITOR vif_i, mailbox#(Sample) mon2scb);
  this.vif = vif_i;
  this.mon2scb = mon2scb;
endfunction

task Monitor::start_sample();

  if(smp != null)
    begin
      sample_count++;
      mon2scb.put(smp);
      if(`DEBUG_PRINT)
        $display("[MON] Sent transaction %s", smp.to_string());
    end

  smp = new();

endtask

task Monitor::run();
  start_sample();

  forever
    begin
      @vif.mon_cb;

      if(vif.mon_cb.deser_data_val)
      begin
        smp.data = vif.mon_cb.deser_data;
        start_sample();
      end

    end
endtask