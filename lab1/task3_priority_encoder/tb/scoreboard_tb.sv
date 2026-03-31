class Scoreboard;

  static const string PASS         = "PASS";
  static const string SKIP         = "SKIPPED";
  static const string ERR_LEN      = "ERROR_LENGTH";
  static const string ERR_DATA     = "ERROR_DATA_MISMATCH";
  static const string ERR_EMPTY    = "ERROR_QUEUE_EMPTY";

  mailbox #(TransactionGen) drv2scb;
  mailbox #(TransactionMon) mon2scb;

  Transaction    ref_queue[$];
  TransactionGen drv_tr;
  TransactionMon mon_tr;

  int tr_passed;
  int tr_total;
  int tr_skipped;

  extern function new(mailbox#(TransactionGen) drv2scb, mailbox #(TransactionMon) mon2scb);

  extern task run();

  extern function string compare_expected(TransactionGen tr_ref, TransactionMon tr_mon);

  function void print_result(TransactionGen tr_ref, TransactionMon tr_mon, string desc);
    string tr_str = ( tr_ref == null ) ? "Transaction empty" : tr_ref.to_string();
    string smp_str = ( tr_mon == null ) ? "Transaction empty" : tr_mon.to_string();
    $display("\n[Scoreboard] %s\n> %s\n> %s\n---\n", desc, tr_str, smp_str);
  endfunction

  function void print_report();
    $display("[Scoreboard] Report. Requests %0d. Passed %0d. Skipped %0d.", tr_total, tr_passed, tr_skipped);
  endfunction

  extern function void compare_next();

endclass

function Scoreboard::new(mailbox#(TransactionGen) drv2scb, mailbox #(TransactionMon) mon2scb);
  this.drv2scb = drv2scb;
  this.mon2scb = mon2scb;
endfunction

task Scoreboard::run();

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

function string Scoreboard::compare_expected(TransactionGen tr_ref, TransactionMon tr_mon);
  logic [tr_ref.WIDTH:0] data_expected_right = |tr_ref.data ? 'X : '0;
  logic [tr_ref.WIDTH:0] data_expected_left  = |tr_ref.data ? 'X : '0;

  if(tr_ref.WIDTH != tr_mon.WIDTH)
    return ERR_LEN;

  for(int i=0; i<tr_ref.WIDTH; i++)
    begin
      if( tr_ref.data[i] == 1'b1 )
      begin
        data_expected_left = (tr_ref.WIDTH'(1) << i);
        if(data_expected_right === 'X)
          data_expected_right = (tr_ref.WIDTH'(1) << i);
      end
    end
  

  if(`DEBUG_PRINT)
  begin
    $display("[Scoreboard] Expected for %b\n%b expected left\n%b expected right", tr_ref.data, data_expected_left, data_expected_right);
    //$display("[Scoreboard] %b expected from %b reference Transaction #%0d", {<<{tr_ref.data}}, tr_ref.data, tr_ref.id);
    //$display("[Scoreboard] %b observed Transaction #%0d", tr_mon.data, tr_mon.id);
  end
  
  
  if( data_expected_left == tr_mon.data_left && data_expected_right == tr_mon.data_right )
    return PASS;
  
  return ERR_DATA;

endfunction