//`include "driver_tb.sv"
//`include "monitor_tb.sv"
//`include "scoreboard_tb.sv"

class Environment #(type IF_T);

  IF_T vif;
  
  Driver drv; 
  Monitor mon;
  Scoreboard scb;

  function new(IF_T vif_i);
    this.vif = vif_i;

    drv = new(vif); 
    mon = new(vif);
    scb = new();
  endfunction

  task run();
    assert (vif != null) else $fatal(1, "[ENV] Virtual interface (vif) is NULL!");
    
    $display("[ENV] Run..");
    
    vif.reset();

    fork
        drv.start();
        mon.start();
        scb.main();
    join_any
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