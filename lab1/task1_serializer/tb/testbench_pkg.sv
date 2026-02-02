package testbench_pkg;
  `define DEBUG_PRINT 1
  `define PASSED_RESULT_PRINT 1
  `define DRIVER_SYNC_DELAY 3
  `define NUM_TRANSACTIONS 10

  `include "transaction_tb.sv"
  `include "sample_tb.sv"
  `include "driver_tb.sv"
  `include "monitor_tb.sv"
  `include "scoreboard_tb.sv"
  `include "generator_tb.sv"
  `include "environment_tb.sv"
endpackage
