interface serializer_if (
    input logic clk
);
  logic [15:0] data;
  logic [ 3:0] data_mod;
  logic        data_val;
  logic        ser_data;
  logic        ser_data_val;
  logic        busy;
  logic        srst;

  default clocking cb @(posedge clk);
    //default input #1ns output #1ns;
    output data, data_mod, data_val, srst;
    input ser_data, ser_data_val, busy;
  endclocking

  modport DUT(input data, data_mod, data_val, srst, clk, output ser_data, ser_data_val, busy);

  modport DRIVER(clocking cb,
      import task reset(),
      import task send(input logic [15:0] d, input logic [3:0] m)
  );

  modport MONITOR(clocking cb, import task receive(output logic d_ser, output logic v_ser));

  task reset();
    cb.srst <= 1'b1;
    ##2;
    cb.srst <= 1'b0;
    ##1;
    $display("[RESET] Done");
  endtask

endinterface
