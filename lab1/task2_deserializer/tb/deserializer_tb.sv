module deserializer_tb #(
  parameter int NUM_TESTS = 20,
  parameter int NUM_ITERATIONS = 20
) (
  input  logic  clk_i,
  input  logic  rst_i
);

// testing data
logic        srst;

logic        data;
logic        data_val;

logic[15:0]        ser_data;
logic        ser_data_val;

// testing module
deserializer serializer_inst(
  .clk_i              (clk_i),
  .srst_i             (srst),

  .data_i             (data),
  .data_val_i         (data_val),

  .deser_data_o       (ser_data),
  .deser_data_val_o   (ser_data_val)
);

// sync reset function
task sync_reset();
  @(posedge clk_i);
  srst <= 1;
  @(posedge clk_i);
  srst      <= 1'b0;
endtask

initial
  begin
    // wait for sim init
    @( posedge rst_i );

    sync_reset();

    for( int t = 0; t < NUM_TESTS; t++ )
      begin
        automatic int                         test_data_length = t % 16;        // test all possible length
        automatic int                         test_delay       = t % 5;         // test different intervals
        automatic logic[15:0]                 test_data        = { $urandom };

        automatic int valid_pulse_cnt   = 0;
        automatic bit expected_bit      = 0;
        automatic bit test_unit_passed  = 1;
        $display("Start test %b", test_data);
        
        // 50% chance to sync reset between transactions
        if( t % 2 == 0 )
          sync_reset(); 

        // Start test 
        data      <= test_data;
        //data_mod  <= test_data_length;
        
        //@(posedge clk_i );
        //data_val  <= 1'b0;

        for(int j=0; j<20;j++) 
          begin
            //$display("Send %0d", test_data[j]);
            data = test_data[j];
            data_val  <= j<16;
            if(ser_data_val)
              begin
                $display("Valid output %b", ser_data);
                $display("Expected %b", ser_data==test_data);
              end

            testbench_pkg::test_itr_num++;
            @( posedge clk_i );
          end

        testbench_pkg::test_complete( test_unit_passed );
      end

    @( posedge clk_i) ;

    testbench_pkg::testbench_all_finished = 1;
  end

endmodule