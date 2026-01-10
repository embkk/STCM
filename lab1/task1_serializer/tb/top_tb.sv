module top_tb;

import testbench_pkg::*;

parameter CLK_PERIOD = 5;

// init before simulation without any sim event
logic clk = 1'b0;
logic rst = 1'b1;

initial
  begin
    repeat(2) @(posedge clk);
    rst <= 1'b0;
    
    wait(testbench_pkg::finished);

    testbench_pkg::print_result();
    
    $stop;
  end

always #CLK_PERIOD clk = ~clk;

// -- Testbench modules --
serializer_tb serializer_tb_inst (
  .clk_i          ( clk ),
  .rst_i          ( rst )
);

  
endmodule