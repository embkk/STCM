class Scoreboard #(parameter MAX_BUSY_COUNT = 16, MAX_VALID_COUNT = 16);
  mailbox #(Transaction) drv2scb;
  mailbox #(Sample) mon2scb;

  int passed_count;
  int tr_count;

  extern function new(mailbox#(Transaction) drv2scb, mailbox #(Sample) mon2scb);

  extern task run();

  extern function bit compare_expected(Transaction tr, Sample smp);

  function void print_result(Transaction tr, Sample smp, string desc);
    $display("\n[Scoreboard] %s\n%s\n%s\n---\n", desc, tr.to_string(), smp.to_string());
  endfunction

  function void print_report();
    $display("\n[Scoreboard] Report. TR passed: %0d, TR total: %0d", passed_count, tr_count);
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

      fork
        drv2scb.get(drv_tr);
        mon2scb.get(mon_sample);
      join

      tr_count++;

      if( compare_expected( drv_tr, mon_sample ) )
        passed_count++;
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
