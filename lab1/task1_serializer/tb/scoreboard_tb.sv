class Scoreboard;
  mailbox #(Transaction) drv2scb, mon2scb;

  int match, mismatch, ignored;

  function new(mailbox#(Transaction) drv2scb, mon2scb);
    this.drv2scb = drv2scb;
    this.mon2scb = mon2scb;
  endfunction

  task run();
    Transaction tr_expected;
    Transaction tr;

    forever begin
      $display("Scoreboard run..");
      fork
        drv2scb.get(tr_expected);
        mon2scb.get(tr);
      join
      $display("Get compare %0d with %0d", tr_expected.ID, tr.ID);
    end
  endtask

endclass
