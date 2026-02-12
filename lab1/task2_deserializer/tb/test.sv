module test #(parameter int NUM_TRANSACTIONS = 100) (
    deserializer_if vif
);
  import testbench_pkg::*;

  typedef virtual deserializer_if v_ser_if;

  Environment #(.IF_T(v_ser_if)) env;

  initial
    begin
      env = new(vif);
      env.build();
      env.run(NUM_TRANSACTIONS);
      
      $stop;
    end
    
endmodule