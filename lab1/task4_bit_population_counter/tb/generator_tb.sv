class Generator;
  
  mailbox #(t_tr_gen) gen2drv;

  function new(input mailbox #(t_tr_gen) gen2drv);
    this.gen2drv = gen2drv;
  endfunction

  task run(config_t test_config);
    int fd;
    int num_transactions = test_config.num_transactions;

    fork
      begin
        fd = $fopen("../log/gen_transactions.log", "w");

        if (fd == 0)
          $warning("Could not open transactions.log for writing");
      end
      begin
        repeat (num_transactions)
          begin
            t_tr_gen tr;

            tr = new();

            case (tr.id)
              1:       tr.data = '1;          // sum overflow test
              2:       tr.data = '0;          
              default: begin
                tr.data = '0; 
                for (int i = 0; i < (tr.WIDTH + 31) / 32; i++)
                  tr.data[i*32 +: 32] = $urandom();
              end
            endcase

            //$display("%b", tr.data);

            // Test workability with gap 
            tr.gap = tr.id > (num_transactions - 1);

            if( fd != 0 )
              $fdisplay(fd, "%s", tr.to_string());

            gen2drv.put(tr);
          end
      end
    join
  endtask
endclass
