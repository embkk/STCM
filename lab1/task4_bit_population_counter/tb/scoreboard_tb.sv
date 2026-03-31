class Scoreboard;

  static const string PASS         = "PASS";
  static const string ERR_LEN      = "ERROR_LENGTH";
  static const string ERR_DATA     = "ERROR_DATA_MISMATCH";
  static const string ERR_EMPTY    = "ERROR_QUEUE_EMPTY";

  mailbox #(t_tr_gen) drv2scb;
  mailbox #(t_tr_mon) mon2scb;

  t_tr_gen ref_queue[$];
  t_tr_gen drv_tr;
  t_tr_mon mon_tr;

  int tr_passed;
  int tr_total;

  extern function new(mailbox#(t_tr_gen) drv2scb, mailbox #(t_tr_mon) mon2scb);

  extern task run();

  extern function string compare_expected(t_tr_gen tr_ref, t_tr_mon tr_mon);

  function void print_result(t_tr_gen tr_ref, t_tr_mon tr_mon, string desc);
    string tr_str = ( tr_ref == null ) ? "Transaction empty" : tr_ref.to_string();
    string smp_str = ( tr_mon == null ) ? "Transaction empty" : tr_mon.to_string();
    $display("\n[Scoreboard] %s\n> %s\n> %s\n---\n", desc, tr_str, smp_str);
  endfunction

  function void print_report();
    $display("[Report] Transactions total %0d. Passed %0d.\n", tr_total, tr_passed);
  endfunction

  extern function void compare_next();

endclass

function Scoreboard::new(mailbox#(t_tr_gen) drv2scb, mailbox #(t_tr_mon) mon2scb);
  this.drv2scb = drv2scb;
  this.mon2scb = mon2scb;
endfunction

task Scoreboard::run();
  tr_passed = 0;
  tr_total = 0;
  fork
    forever
      begin
        drv2scb.get(drv_tr);
        ref_queue.push_back(drv_tr);
      end
    forever
      begin
        mon2scb.get(mon_tr);
        compare_next();
      end
  join
endtask

function void Scoreboard::compare_next();
  string res;

  if (ref_queue.size() == 0)
    begin
      print_result(null, mon_tr, ERR_EMPTY);
      $stop;
    end

  drv_tr = ref_queue.pop_front();

  res = compare_expected( drv_tr, mon_tr );
  
  if( `PRINT_PASSED || res != PASS )
    print_result(drv_tr, mon_tr, res);

  if( res == PASS )
    tr_passed++;
  else
    $stop;

  tr_total++;

  drv_tr = null;

endfunction

function string Scoreboard::compare_expected(t_tr_gen tr_ref, t_tr_mon tr_mon);
  int count_expected;
  
  if(tr_ref.WIDTH != tr_mon.WIDTH)
    return ERR_LEN;
  
  count_expected = $countones(tr_ref.data);

  if(`DEBUG_PRINT)
    $display("[Scoreboard] For tr %b\n%0d observerd\n%0d expected", tr_ref.data, tr_mon.data, count_expected);
  
  if( count_expected == tr_mon.data )
    return PASS;
  
  return ERR_DATA;

endfunction
