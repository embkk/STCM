module deserializer_tb #(
  parameter int NUM_TESTS = 32,
  parameter int NUM_ITERATIONS = 20
) (
  input  logic  clk_i,
  input  logic  rst_i
);

// testing data
logic        srst;

logic[15:0]  data;
logic[3:0]   data_mod; 
logic        data_val;

logic        ser_data;
logic        ser_data_val;
logic        busy;

// testing module
deserializer serializer_inst(
  .clk_i            (clk_i),
  .srst_i           (srst),

  .data_i           (data),
  .data_mod_i       (data_mod),
  .data_val_i       (data_val),

  .ser_data_o       (ser_data),
  .ser_data_val_o   (ser_data_val),
  .busy_o           (busy)
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

        // 50% chance to sync reset between transactions
        if( t % 2 == 0 )
          sync_reset(); 

        // Start test 
        data      <= test_data;
        data_mod  <= test_data_length;
        data_val  <= 1'b1;
        @(posedge clk_i );
        data_val  <= 1'b0;

        for(int j=0; j<NUM_ITERATIONS;j++) 
          begin
            if(ser_data_val)
              begin
                // SPECIAL TEST - sync reset in a half of first transaction
                if(t==0)
                  begin
                    if( j == 3 )
                      srst <= 1;
                    else if( j == 4 )
                      srst <= 0;
                  end

                // check expected length
                if( ( valid_pulse_cnt > test_data_length ) && ( test_data_length > 0          ) ||
                    ( valid_pulse_cnt > 15               ) || ( test_data_length == 1         ) || 
                    ( test_data_length == 2              ) )
                  begin
                    test_unit_passed = 0;
                    $error("Wrong length");
                  end

                // check expected data
                expected_bit = test_data[15 - valid_pulse_cnt];
                if( expected_bit != ser_data )
                  test_unit_passed = 0;

                valid_pulse_cnt++;
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