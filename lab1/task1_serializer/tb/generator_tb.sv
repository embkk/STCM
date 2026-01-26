class Generator;
  mailbox #(Transaction) gen2drv;

  function new(input mailbox #(Transaction) gen2drv);
    this.gen2drv = gen2drv;
  endfunction

  task run(input int num_tr = 10);
    repeat(num_tr)
      begin
        Transaction tr;
        tr = new();
        if (!tr.randomize()) $fatal("Randomize failed");
        gen2drv.put(tr);
      end
  endtask

endclass
