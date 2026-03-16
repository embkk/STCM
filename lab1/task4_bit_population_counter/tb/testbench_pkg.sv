package testbench_pkg;
  `define DEBUG_PRINT 1
  `define PRINT_PASSED 0

  `include "transaction_tb.sv"
  `include "driver_tb.sv"
  `include "monitor_tb.sv"
  `include "scoreboard_tb.sv"
  `include "generator_tb.sv"
  `include "environment_tb.sv"
endpackage