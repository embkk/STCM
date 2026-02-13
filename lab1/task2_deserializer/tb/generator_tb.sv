class Generator;
  mailbox #(Request) gen2drv;

  function new(input mailbox#(Request) gen2drv);
    this.gen2drv = gen2drv;
  endfunction

  task run(int num_transactions);
    repeat (num_transactions)
      begin
        Request tr;
        tr = new();
        if (!tr.randomize_free()) $fatal("Randomize failed");
        gen2drv.put(tr);
      end
  endtask

endclass
