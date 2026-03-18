package testbench_pkg;
  `define DEBUG_PRINT 0
  `define PRINT_PASSED 0

  localparam int DATA_WIDTH = 64;

  `include "transaction_tb.sv"

  typedef TransactionGen #(DATA_WIDTH) t_tr_gen;
  typedef TransactionMon #(DATA_WIDTH) t_tr_mon;

  typedef virtual bit_population_counter_if #(DATA_WIDTH)         t_vif;
  typedef virtual bit_population_counter_if #(DATA_WIDTH).DRIVER  t_vif_drv;
  typedef virtual bit_population_counter_if #(DATA_WIDTH).MONITOR t_vif_mon;

  `include "driver_tb.sv"
  `include "monitor_tb.sv"
  `include "scoreboard_tb.sv"
  `include "generator_tb.sv"
  `include "environment_tb.sv"
endpackage