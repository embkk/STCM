import testbench_pkg::*;

module test #(parameter int NUM_TRANSACTIONS ) (
    interface vif
);
  

  Environment #(.IF_T(t_vif)) env;

  initial
    begin
      env = new(vif);
      env.build();
      env.run(NUM_TRANSACTIONS);
      
      $stop;
    end
    
endmodule