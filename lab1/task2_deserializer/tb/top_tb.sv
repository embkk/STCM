module top_tb;

parameter CLK_PERIOD = 5;

// init before simulation without any sim event
logic clk = 1'b0;
logic rst = 1'b0;

initial
  begin

    // reset
    repeat(2) @(posedge clk);
    rst <= 1'b1;

    // idle
    repeat(2) @(posedge clk);
    rst <= 1'b0;
    
    // wait for test end
    wait(testbench_pkg::testbench_all_finished);

    testbench_pkg::testbench_print_stats();
    
    $stop;
  end

always #CLK_PERIOD clk = ~clk;

// -- Testbench modules --
deserializer_tb serializer_tb_inst (
  .clk_i          ( clk ),
  .rst_i          ( rst )
);
  
endmodule