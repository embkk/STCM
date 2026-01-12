package testbench_pkg;
  int test_completed_num = 0;
  int test_itr_num = 0;
  int test_error_num = 0;
  bit testbench_all_finished = 0;

  // TESTBENCH CONTROL
  function void test_complete(bit passed = 0);
    test_completed_num++;
    if (!passed) test_error_num++;
  endfunction

  function void testbench_print_stats();
    $display("\n=======================================");

    if(testbench_all_finished)
      $display("All tests finished");
    
    if (test_error_num == 0 && test_completed_num > 0)
      $display("  [PASSED]");
    else
      $display("  [FAILED]\n  Errors:     %0d", test_error_num);
    
    $display("  Tests: %0d", test_completed_num);
    $display("  Test iterations: %0d", test_itr_num);
    $display("=======================================\n");
  endfunction

endpackage