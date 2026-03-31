import testbench_pkg::*;

module test #(parameter int NUM_TRANSACTIONS) (
    interface vif
);

  Environment #(.IF_T(t_vif)) env;

  initial
    begin
      config_t test_configs[3];

      env = new(vif);
      env.build();

      test_configs[0] = new(.m(LIST_DATA), .pred('{ '0, '1 }));
      test_configs[1] = new(.m(RAND_NO_GAP), .n(NUM_TRANSACTIONS));
      test_configs[2] = new(.m(RAND_WITH_GAP), .n(NUM_TRANSACTIONS));

      foreach (test_configs[i])
      begin
        $display("[Test] Run %s", test_configs[i].to_string());
        env.run(test_configs[i]);
      end

      $display("[Test] All tests end.");

      $stop;
    end
    
endmodule