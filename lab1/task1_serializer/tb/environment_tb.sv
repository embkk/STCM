class Environment #(
    type IF_T
);
  IF_T                   vif;

  Generator              gen;
  Driver                 drv;
  Monitor                mon;
  Scoreboard             scb;

  mailbox #(Transaction) gen2drv, drv2scb, mon2scb;

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

    $display("[ENV] Run..");

    vif.reset();

    fork
      gen.run();
      drv.run();
      mon.run();
      scb.run();
    join_none

  endtask
endclass



/*The Generator, Agent, Driver, Monitor, Checker, and Scoreboard are
all classes, modeled as transactors (described below). They are instantiated inside
the Environment class. For simplicity, the test is at the top of the hierarchy, as is the
program that instantiates the Environment class. The Functional coverage defini-
tions can be put inside or outside the Environment class. See Section 1.10 for a
description of the layered verification environment and its components.
A transactor is made of a simple loop that receives a transaction obje


what to randomize
Device configuration
Environment configuration
Primary input data
Encapsulated input data
Protocol exceptions
Delays
Transaction status
Errors and violations*/
