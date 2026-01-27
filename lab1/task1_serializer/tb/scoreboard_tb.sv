class Scoreboard;
  mailbox #(Transaction) drv2scb;
  mailbox #(Sample) mon2scb;

  int passed;

  function new(mailbox#(Transaction) drv2scb, mailbox #(Sample) mon2scb);
    this.drv2scb = drv2scb;
    this.mon2scb = mon2scb;
  endfunction

  task run(int num_transactions);
    Transaction tr_expected;
    Sample tr_sample;

    repeat(num_transactions)
      begin

        fork
          drv2scb.get(tr_expected);
          mon2scb.get(tr_sample);
        join


        if(tr_expected.len == tr_sample.val_count)
          begin
            passed++;
            if(testbench_pkg::PASSED_RESULT_PRINT)
              $display("+ [Scoreboard] Passed sample len %0d expexted tr data_mod %0d | data %b", tr_sample.val_count, tr_expected.data_mod, tr_expected.data);
          end
        else
          begin
            $display("\n[Scoreboard] Failed - sample len %0d expexted tr data_mod %0d", tr_sample.val_count, tr_expected.data_mod);
            $display("%s\n%s\n", tr_expected.to_string(), tr_sample.to_string());
          end
      end

    $display("\nTests finished. Passed %0d/%0d", passed, num_transactions);
    $stop;
  endtask

endclass
