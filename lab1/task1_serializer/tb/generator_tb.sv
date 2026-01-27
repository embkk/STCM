class Generator;
  mailbox #(Transaction) gen2drv;

  function new(input mailbox#(Transaction) gen2drv);
    this.gen2drv = gen2drv;
  endfunction

  task run(input int num_tr = 3);
    repeat (num_tr) begin
      Transaction tr;
      tr = new();
      //if (!tr.randomize_free()) $fatal("Randomize failed");
      gen2drv.put(tr);
      $display("[Generator] put %s", tr.to_string());
    end
  endtask

endclass
