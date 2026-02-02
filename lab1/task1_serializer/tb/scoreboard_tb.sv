class Scoreboard;
  mailbox #(Transaction) drv2scb;
  mailbox #(Sample) mon2scb;

  int passed_count;

  extern function new(mailbox#(Transaction) drv2scb, mailbox #(Sample) mon2scb);

  extern task run(int num_transactions);

  extern function bit compare_expected(Transaction tr, Sample smp);

  function print_result(Transaction tr, Sample smp, string desc);
    $display("\n[Scoreboard] %s\n%s\n%s\n---\n", desc, tr.to_string(), smp.to_string());
  endfunction

endclass

function Scoreboard::new(mailbox#(Transaction) drv2scb, mailbox #(Sample) mon2scb);
  this.drv2scb = drv2scb;
  this.mon2scb = mon2scb;
endfunction

task Scoreboard::run(int num_transactions);
  Transaction drv_tr;
  Sample mon_sample;

  repeat(num_transactions)
    begin

      fork
        drv2scb.get(drv_tr);
        mon2scb.get(mon_sample);
      join

      if( compare_expected( drv_tr, mon_sample ) )
        passed_count++;

    end

  $display("\nTests finished. passed_count %0d/%0d", passed_count, num_transactions);
  $stop;
endtask

function bit Scoreboard::compare_expected(Transaction tr, Sample smp);
  bit compare_result = 1;

  if(tr.len == smp.val_count)
    begin
      if(`PASSED_RESULT_PRINT)
        print_result(tr, smp, "OK");
    end
  else
    begin
      compare_result = 0;
      print_result(tr, smp, "Error - Unexpected length");
    end

  return compare_result;
endfunction
