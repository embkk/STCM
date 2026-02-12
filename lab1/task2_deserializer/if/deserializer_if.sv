interface serializer_if (
    input logic clk
);
  logic        srst;
  logic        data;
  logic        data_val;
  logic        deser_data;
  logic        deser_data_val;

  default clocking drv_cb @(posedge clk);
    output data, data_val, srst;
    input  deser_data, deser_data_val;
  endclocking

  clocking mon_cb @(posedge clk);
    input deser_data, deser_data_val, srst;
  endclocking

  modport DUT (
    input  data, data_val, srst, clk,
    output deser_data, deser_data_val
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
