module serializer_tb #(
  parameter int NUM_TESTS = 1,
  parameter int NUM_ITERATIONS = 20
) (
  input  logic  clk_i,
  input  logic  rst_i
);

logic        srst;
logic[15:0]  data;
logic[3:0]   data_mod; 
logic        data_val;
logic        ser_data;
logic        ser_data_val;
logic        busy;

serializer serializer_inst(
  .clk_i            (clk_i),
  .srst_i           (srst),
  .data_i           (data),
  .data_mod_i       (data_mod),
  .data_val_i       (data_val),
  .ser_data_o       (ser_data),
  .ser_data_val_o   (ser_data_val),
  .busy_o           (busy)
);

initial
  begin

    // wait for sim init
    @( posedge rst_i );

    for(int i=0; i<NUM_TESTS; i++)
      begin
        
        // Generate test data
        automatic logic [15:0] test_data        = {$urandom};
        automatic int          test_data_length = $urandom_range(0,15);
        automatic int          test_delay       = $urandom_range(0,15);

        @(posedge clk_i);
        srst = 1;

        $display("Start test #%0d. Send %0d bits from %0b then wait %0d", i, test_data_length, test_data, test_delay);

        data = test_data;
        data_mod = test_data_length;

        for(int j=0; j<NUM_ITERATIONS;j++) 
        begin
          data_val = (j == 0); // first pulse only
          $display("#%02d> %b (V:%b) | %0b (L: %0d V: %0d) | BUSY:%b", 
          j, ser_data, ser_data_val, data, data_mod, data_val, busy);
        end

        testbench_pkg::test_complete(1);
      end

    repeat(10) @(posedge clk_i);
    testbench_pkg::testbench_all_finished = 1;
  end

/*  // --- Задача проверки: че че ожидали, че получили + порты в след. строке ---
task check_step(input logic exp_data, input logic exp_val, input string msg = "");
  if (ser_data !== exp_data || ser_data_val !== exp_val) begin
    $display("ERROR: %s | Time: %0t", msg, $time);
    $display("  EXP: data=%b, vld=%b | GOT: data=%b, vld=%b", exp_data, exp_val, ser_data, ser_data_val);
    // Состояние всех портов в следующую строку
    $display("  STATE: data_in=%h, mod=%0d, busy=%b, vld_in=%b, rst=%b, ser_vld=%b, ser_d=%b", 
              data, data_mod, busy, data_val, rst_i, ser_data_val, ser_data);
    single_test_completed(1);
  end else begin
    $display("[%0t] OK: %s | Out: %b", $time, msg, ser_data);
  end
endtask : check_step
*/

endmodule