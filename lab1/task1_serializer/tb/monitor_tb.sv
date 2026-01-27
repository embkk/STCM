class Monitor #(int TIMEOUT = 2000);
  virtual serializer_if.MONITOR vif;
  mailbox #(Sample) mon2scb;

  function new(virtual serializer_if.MONITOR vif_i, mailbox#(Sample) mon2scb);
    this.vif = vif_i;
    this.mon2scb = mon2scb;
  endfunction

  Sample smp;
  int mon_count;
  int sample_count;
  int busy_count;

  function automatic void start_sample();
    smp = new();
    mon_count = 0;
    busy_count = 0;
  endfunction

  task run(int num_transactions);
    while(sample_count<num_transactions)
      begin
        if(smp == null)
          start_sample();

        @vif.mon_cb;

        if(vif.mon_cb.busy)
          busy_count++;

        mon_count++;

        if(vif.mon_cb.ser_data_val)
          smp.add(vif.mon_cb.ser_data);

        if(mon_count>TIMEOUT || (busy_count && !vif.mon_cb.busy) )
          begin
            sample_count++;
            mon2scb.put(smp);

            if( `DEBUG_PRINT )
              $display("[MON] %0d sample ready %s", sample_count, smp.to_string());

            smp = null;
          end
      end
  endtask
endclass
