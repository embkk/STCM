interface bit_population_counter_if #( parameter int WIDTH = 32 )
(
    input logic clk_i
);
  logic             srst_i;
  logic [WIDTH-1:0] data_i;
  logic             data_val_i;

  logic [WIDTH-1:0] data_left_o;
  logic [WIDTH-1:0] data_right_o;
  logic             data_val_o;

  default clocking drv_cb @(posedge clk_i);
    output srst_i, data_i, data_val_i;
    input  data_left_o, data_right_o, data_val_o;
  endclocking

  clocking mon_cb @(posedge clk_i);
    input  data_left_o, data_right_o, data_val_o;
  endclocking

  modport DUT (
    input   data_i, data_val_i,
    output  srst_i, data_left_o, data_right_o, data_val_o
  );

  modport DRIVER(clocking drv_cb);

  modport MONITOR(clocking mon_cb);

endinterface