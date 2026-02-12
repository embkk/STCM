class Scoreboard #(parameter MAX_BUSY_COUNT = 16, MAX_VALID_COUNT = 16);
  mailbox #(Transaction) drv2scb;
  mailbox #(Sample) mon2scb;

  int tr_passed;
  int tr_total;
  int tr_skipped;

  extern function new(mailbox#(Transaction) drv2scb, mailbox #(Sample) mon2scb);

  extern task run();

  extern function bit compare_expected(Transaction tr, Sample smp);

  function void print_result(Transaction tr, Sample smp, string desc);
    $display("\n[Scoreboard] %s\n%s\n%s\n---\n", desc, tr.to_string(), smp.to_string());
  endfunction

  function void print_report();
    $display("[Scoreboard] Report. Transactions %0d. Passed %0d. Skipped %0d.", tr_total, tr_passed, tr_skipped);
  endfunction

endclass

function Scoreboard::new(mailbox#(Transaction) drv2scb, mailbox #(Sample) mon2scb);
  this.drv2scb = drv2scb;
  this.mon2scb = mon2scb;
endfunction

task Scoreboard::run();
  Transaction drv_tr;
  Sample mon_sample;

  forever
    begin

      drv2scb.get(drv_tr);

      if(drv_tr.data_mod inside {1,2})
        begin
          tr_skipped++;
          tr_total++;
          continue;
        end

      mon2scb.get(mon_sample);

      if( compare_expected( drv_tr, mon_sample ) )
        begin
          tr_passed++;
          tr_total++;
        end
      else
        $stop;

    end
endtask

function bit Scoreboard::compare_expected(Transaction tr, Sample smp);
  
  int tr_len;

  case (tr.data_mod)
    0       : tr_len = 16;
    1, 2    : tr_len = 0;
    default : tr_len = tr.data_mod;
  endcase

  if( smp.val_count > MAX_VALID_COUNT )
  begin
    print_result(tr, smp, "Error - valid count limit");
    return 0;
  end

  if( smp.busy_count > MAX_BUSY_COUNT )
  begin
    print_result(tr, smp, "Error - busy count limit");
    return 0;
  end

  if(tr_len == smp.val_count)
    begin
      bit unexpected = 0;
      for(int i=0; i<tr_len; i++)
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
