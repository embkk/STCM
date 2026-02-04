class Scoreboard;
  mailbox #(Transaction) drv2scb;
  mailbox #(Sample) mon2scb;
  semaphore drv_sem;

  int passed_count;
  int tr_count;

  extern function new(mailbox#(Transaction) drv2scb, mailbox #(Sample) mon2scb, semaphore drv_sem);

  extern task run();

  extern function bit compare_expected(Transaction tr, Sample smp);

  function void print_result(Transaction tr, Sample smp, string desc);
    $display("\n[Scoreboard] %s\n%s\n%s\n---\n", desc, tr.to_string(), smp.to_string());
  endfunction

endclass

function Scoreboard::new(mailbox#(Transaction) drv2scb, mailbox #(Sample) mon2scb, semaphore drv_sem);
  this.drv2scb = drv2scb;
  this.mon2scb = mon2scb;
  this.drv_sem = drv_sem;
endfunction

task Scoreboard::run();
  Transaction drv_tr;
  Sample mon_sample;

  forever
    begin

      fork
        drv2scb.get(drv_tr);
        mon2scb.get(mon_sample);
      join

      drv_sem.put(1);
      tr_count++;

      if( compare_expected( drv_tr, mon_sample ) )
        passed_count++;

      if(tr_count == `NUM_TRANSACTIONS)
        begin
          $display("\nTests finished. passed_count %0d/%0d", passed_count, tr_count);
          $stop;
        end
    end
endtask

function bit Scoreboard::compare_expected(Transaction tr, Sample smp);

  if(tr.len == smp.val_count)
    begin
      bit unexpected = 0;
      for(int i=0; i<tr.len; i++)
        if(tr.data[15-i] != smp.data[i])
          begin
            print_result(tr, smp, "Error - unexpected content");
            return 0;
          end

      if(`PRINT_PASSED_RESULTS)
        print_result(tr, smp, "OK");
    end
  else
    begin
      print_result(tr, smp, "Error - Unexpected length");
      return 0;
    end

  return 1;

endfunction
