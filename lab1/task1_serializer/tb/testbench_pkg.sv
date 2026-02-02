package testbench_pkg;
  `define DEBUG_PRINT 0
  `define PRINT_PASSED_RESULTS 0
  `define SYNC_TIMEOUT_DELAY 16
  `define NUM_TRANSACTIONS 36

  `include "transaction_tb.sv"
  `include "sample_tb.sv"
  `include "driver_tb.sv"
  `include "monitor_tb.sv"
  `include "scoreboard_tb.sv"
  `include "generator_tb.sv"
  `include "environment_tb.sv"
endpackage
