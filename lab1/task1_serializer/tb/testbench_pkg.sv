package testbench_pkg;
  int test_completed_num = 0;
  int test_error_num = 0;
  bit testbench_all_finished = 0;

  // TESTBENCH CONTROL
  function void test_complete(bit passed = 0);
    test_completed_num++;
    if (!passed) test_error_num++;
  endfunction

  function void testbench_print_stats();
    $display("\n=======================================");
    $display(testbench_all_finished ? "All tests finished" : "In progress...");
    if (test_error_num == 0 && test_completed_num > 0) begin
      $display("  [PASSED]");
      $display("  Tests run: %0d", test_completed_num);
    end else begin
      $display("  [FAILED]");
      $display("  Tests run:  %0d", test_completed_num);
      $display("  Errors:     %0d", test_error_num);
    end
    $display("=======================================\n");
  endfunction

endpackage