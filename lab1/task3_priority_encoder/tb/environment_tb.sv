class Environment #(
    type IF_T
);

  IF_T                   vif;

  Generator              gen;
  Driver                 drv;
  Monitor                mon;
  Scoreboard             scb;

  mailbox #(TransactionGen) gen2drv;
  mailbox #(Transaction) drv2scb, mon2scb;

  semaphore drv_sem;

  function new(IF_T vif_i);
    this.vif = vif_i;

    drv_sem = new(1);

    gen2drv = new(1);
    drv2scb = new(1);
    mon2scb = new(1);
  endfunction

  function void build();
    assert (vif != null)
    else $fatal(1, "[ENV] Virtual interface (vif) is NULL!");

    gen = new(.gen2drv(gen2drv));

    drv = new(.vif_i(vif),
              .gen2drv(gen2drv),
              .drv2scb(drv2scb));

    mon = new(.vif_i(vif),
              .mon2scb(mon2scb));

    scb = new(.drv2scb(drv2scb),
              .mon2scb(mon2scb));
  endfunction

  task run(int num_transactions);
    $display("[ENV] Run %0d transactions", num_transactions);

    fork
      gen.run(num_transactions);
      drv.run();
      mon.run();
      scb.run();
    join_any


    fork
      begin
        wait(scb.tr_total == num_transactions);
        $display("[ENV] All transactions processed.");
      end
      begin
        repeat(1000) @(posedge vif.clk_i);
        $error("[ENV] Simulation stopped by timeout");
      end
    join_any

    disable fork;

    scb.print_report();

  endtask
endclass
