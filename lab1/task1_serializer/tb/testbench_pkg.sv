package testbench_pkg;
  `define DEBUG_PRINT 0
  `define PASSED_RESULT_PRINT 0

  `include "transaction_tb.sv"
  `include "sample_tb.sv"
  `include "driver_tb.sv"
  `include "monitor_tb.sv"
  `include "scoreboard_tb.sv"
  `include "generator_tb.sv"
  `include "environment_tb.sv"
endpackage
