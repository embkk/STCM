class Monitor;
  virtual serializer_if.MONITOR vif;
  mailbox #(logic) mon2scb;

  function new(virtual serializer_if.MONITOR vif_i, mailbox #(logic) mon2scb);
    this.vif = vif_i;
  endfunction

  task run();
    logic d, v;
    forever begin
      vif.receive(d, v);
      if (v) begin
        $display("[%0t] Mon: bit=%b", $time, d);
      end
    end
  endtask
endclass
