class Environment #(
    type IF_T
);

  IF_T                   vif;

  Generator              gen;
  Driver                 drv;
  Monitor                mon;
  Scoreboard             scb;

  mailbox #(Transaction) gen2drv, drv2scb;
  mailbox #(Sample) mon2scb;

  semaphore drv_sem;

  function new(IF_T vif_i);
    this.vif = vif_i;

    drv_sem = new(1);

    gen2drv = new(1);
    drv2scb = new(1);
    mon2scb = new(1);
  endfunction

  function void build();

    gen = new(.gen2drv(gen2drv));

    drv = new(.vif_i(vif),
              .gen2drv(gen2drv),
              .drv2scb(drv2scb),
              .drv_sem(drv_sem));

    mon = new(.vif_i(vif),
              .mon2scb(mon2scb));

    scb = new(.drv2scb(drv2scb),
              .mon2scb(mon2scb),
              .drv_sem(drv_sem));
  endfunction

  task run();
    assert (vif != null)
    else $fatal(1, "[ENV] Virtual interface (vif) is NULL!");

    $display("[ENV] Run %0d transactions", `NUM_TRANSACTIONS);

    vif.reset();

    fork
      gen.run(`NUM_TRANSACTIONS);
      drv.run();
      mon.run();
      scb.run();
    join_none

  endtask
endclass
