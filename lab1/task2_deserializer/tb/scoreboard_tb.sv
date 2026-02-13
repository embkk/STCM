class Scoreboard #(parameter MAX_BUSY_COUNT = 16, MAX_VALID_COUNT = 16);

  static const string PASS         = "PASS";
  static const string SKIP         = "SKIPPED";
  static const string ERR_LEN      = "ERROR_LENGTH";
  static const string ERR_DATA     = "ERROR_DATA_MISMATCH";
  static const string ERR_EMPTY    = "ERROR_QUEUE_EMPTY";

  mailbox #(Request) drv2scb;
  mailbox #(Transaction) mon2scb;

  Request ref_queue[$];

  int tr_passed;
  int tr_total;
  int tr_skipped;

  extern function new(mailbox#(Request) drv2scb, mailbox #(Transaction) mon2scb);

  extern task run();

  extern function string compare_expected(Request tr, Transaction smp);

  function void print_result(Request tr, Transaction smp, string desc);
    string tr_str = tr == null ? "Request empty" : tr.to_string();
    string smp_str = smp == null ? "Transaction empty" : smp.to_string();
    $display("\n[Scoreboard] %s\n> %s\n> %s\n---\n", desc, tr_str, smp_str);
  endfunction

  function void print_report();
    $display("[Scoreboard] Report. Requests %0d. Passed %0d. Skipped %0d.", tr_total, tr_passed, tr_skipped);
  endfunction

endclass

function Scoreboard::new(mailbox#(Request) drv2scb, mailbox #(Transaction) mon2scb);
  this.drv2scb = drv2scb;
  this.mon2scb = mon2scb;
endfunction

task Scoreboard::run();
  Request drv_tr;
  Transaction mon_sample;
  string res;

  fork
    forever
      begin
        
        drv2scb.get(drv_tr);
        ref_queue.push_back(drv_tr);

      end
    forever
      begin

        mon2scb.get(mon_sample);

        if (ref_queue.size() == 0)
          begin
            print_result(null, mon_sample, ERR_EMPTY);
            $stop;
          end

        drv_tr = ref_queue.pop_front();

        res = compare_expected( drv_tr, mon_sample );
        print_result(drv_tr, mon_sample, res);

        if( res == PASS )
          tr_passed++;
        else if ( res == SKIP )
          tr_skipped++;
        else
          $stop;

        tr_total++;

        drv_tr = null;

      end
  join
endtask

function string Scoreboard::compare_expected(Request tr, Transaction smp);
  logic [15:0] expected;
  int          valid_count;

  for (int i = 0; i < 32; i++)
    begin
      if (tr.data_val[i])
        begin
          expected[15-valid_count] = tr.data[i];
          valid_count++;
        end
    end

  if(valid_count!=16)
    return ERR_LEN;
    
  $display("[Scoreboard] %b expected transaction #%0d", expected, tr.id);
  $display("[Scoreboard] %b sampled transaction #%0d", smp.data, smp.id);

  if( smp.data == expected )
    return PASS;
  
  return ERR_DATA;

endfunction
