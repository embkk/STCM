package testbench_pkg;
  const bit DEBUG_PRINT = 0;
  const bit PASSED_RESULT_PRINT = 0;

  `include "transaction_tb.sv"
  `include "sample_tb.sv"
  `include "driver_tb.sv"
  `include "monitor_tb.sv"
  `include "scoreboard_tb.sv"
  `include "generator_tb.sv"
  `include "environment_tb.sv"
endpackage
