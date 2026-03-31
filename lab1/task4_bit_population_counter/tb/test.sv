import testbench_pkg::*;

module test #(parameter int NUM_TRANSACTIONS) (
    interface vif
);
  localparam W = vif.WIDTH;
  typedef TestConfig #(W) config_t;

  Environment #(.IF_T(t_vif)) env;

  initial
    begin
      config_t test_queue[$];

      env = new(vif);
      env.build();

      while (test_queue.size() > 0)
        env.run(test_queue.pop_front());

      $stop;
    end
    
endmodule