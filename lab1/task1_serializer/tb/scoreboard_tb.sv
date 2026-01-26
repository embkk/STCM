class Scoreboard;
  mailbox #(Transaction) drv2scb;
  mailbox #(logic) mon2scb;

  int match, mismatch, ignored;

  function new(mailbox #(Transaction) drv2scb, mailbox #(logic) mon2scb);
    this.drv2scb = drv2scb;
    this.mon2scb = mon2scb;
  endfunction

  task run();
    Transaction tr;
    forever begin
      drv2scb.get(tr);
      check_transaction(tr);
    end
  endtask

  task check_transaction(Transaction tr);
    logic bit_out;
    int bits_to_check;

    // Если 1 или 2 — проверяем, что монитор молчит
    if (tr.len == 4'd1 || tr.len == 4'd2) begin
      #10; // Ждем реакции такта
      if (mon2scb.num() == 0) begin
        ignored++;
        $display("[SCB] Success: Transaction with len %0d ignored", tr.len);
      end else begin
        mismatch++;
        $error("[SCB] Fail: DUT produced data for ignored len %0d", tr.len);
      end
    end
    else begin
      // Если 0 - все 16 бит, иначе только старшие len бит
      bits_to_check = (tr.len == 0) ? 16 : tr.len;

      for (int i = 0; i < bits_to_check; i++) begin
        mon2scb.get(bit_out);
        if (tr.data[15-i] === bit_out) match++; // Первый бит - самый старший
        else begin
          $error("[SCB] Bit mismatch! Exp: %b Act: %b", tr.data[15-i], bit_out);
          mismatch++;
        end
      end
    end
  endtask

endclass
