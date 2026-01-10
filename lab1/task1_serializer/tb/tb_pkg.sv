package testbench_pkg
  int test_num = 0;
  int errors = 0;
  bit finished = 0;

  function void testbench_completed(bit failed = 0);
    test_num++;
    if (failed) errors++;
  endfunction

  function void print_result();
    $display("\n=======================================");
    if (errors == 0 && test_num > 0) begin
      $display("  [PASSED]");
      $display("  Tests run: %0d", test_num);
    end else begin
      $display("  [FAILED]");
      $display("  Tests run:  %0d", test_num);
      $display("  Errors:     %0d", errors);
    end
    $display("=======================================\n");
  endfunction

endpackage