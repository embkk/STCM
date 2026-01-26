module top_tb;
import testbench_pkg::*;

parameter CLK_PERIOD = 5;

logic clk = 1'b0;

serializer_if serializer_bus(.clk(clk));

serializer dut_inst (
    .clk_i           (serializer_bus.clk),
    .srst_i          (serializer_bus.srst),
    .data_i          (serializer_bus.data),
    .data_mod_i      (serializer_bus.data_mod),
    .data_val_i      (serializer_bus.data_val),
    .ser_data_o      (serializer_bus.ser_data),
    .ser_data_val_o  (serializer_bus.ser_data_val),
    .busy_o          (serializer_bus.busy)
  );

typedef virtual serializer_if v_ser_if;

Environment #(.IF_T(v_ser_if)) env;

initial
  begin
    env = new(serializer_bus);
    env.run();
  end

always
  #CLK_PERIOD clk = ~clk;

final
  $display("Testbench finished.");

endmodule