interface serializer_if (
    input logic clk
);
  logic [15:0] data;
  logic [3:0]  data_mod;
  logic        data_val;
  logic        ser_data;
  logic        ser_data_val;
  logic        busy;
  logic        srst;

  default clocking drv_cb @(posedge clk);
    output data, data_mod, data_val, srst;
    input  busy;
  endclocking

  clocking mon_cb @(posedge clk);
    input ser_data, ser_data_val, data_val, busy;
  endclocking

  modport DUT (
    input  data, data_mod, data_val, srst, clk,
    output ser_data, ser_data_val, busy
  );

  modport DRIVER(clocking drv_cb);

  modport MONITOR(clocking mon_cb);

  task reset();
    drv_cb.srst <= 1'b1;
    ##2;
    drv_cb.srst <= 1'b0;
    ##1;
    $display("[RESET] Done");
  endtask

endinterface
