class Environment #(
    type IF_T
);

  const int num_transactions = 560;

  IF_T                   vif;

  Generator              gen;
  Driver                 drv;
  Monitor                mon;
  Scoreboard             scb;

  mailbox #(Transaction) gen2drv, drv2scb;
  mailbox #(Sample) mon2scb;

  function new(IF_T vif_i);
    this.vif = vif_i;
    gen2drv = new(1);
    drv2scb = new(1);
    mon2scb = new(1);
  endfunction

  function void build();

    gen = new(.gen2drv(gen2drv));

    drv = new(.vif_i(vif),
              .gen2drv(gen2drv),
              .drv2scb(drv2scb));

    mon = new(.vif_i(vif),
              .mon2scb(mon2scb));

    scb = new(.drv2scb(drv2scb),
              .mon2scb(mon2scb));
  endfunction

  task run();
    assert (vif != null)
    else $fatal(1, "[ENV] Virtual interface (vif) is NULL!");

    $display("[ENV] Run %0d transactions", num_transactions);

    vif.reset();

    fork
      gen.run(num_transactions);
      drv.run(num_transactions);
      mon.run(num_transactions);
      scb.run(num_transactions);

      forever begin
        @(drv.e_tr_sent);
        mon.force_timeout();
      end
    join_none

  endtask
endclass
