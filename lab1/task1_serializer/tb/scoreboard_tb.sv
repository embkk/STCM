class Scoreboard;
  mailbox #(Transaction) drv2scb;
  mailbox #(Sample) mon2scb;

  int match, mismatch, ignored;

  function new(mailbox#(Transaction) drv2scb, mailbox #(Sample) mon2scb);
    this.drv2scb = drv2scb;
    this.mon2scb = mon2scb;
  endfunction

  task run(int num_transactions);
    Transaction tr_expected;
    Sample tr_sample;

    repeat(num_transactions)
      begin
        bit passed;

        fork
          drv2scb.get(tr_expected);
          mon2scb.get(tr_sample);
        join


        passed = tr_expected.len == tr_sample.val_count;

        if(!passed)
          $error("\n[Scoreboard] Failed compare\n%s\n%s\n", tr_expected.to_string(), tr_sample.to_string());
        else
          $display("+ [Scoreboard] Passed %0d bits as expected %b", tr_sample.val_count, tr_expected.data);
      end

    $stop;
  endtask

endclass
