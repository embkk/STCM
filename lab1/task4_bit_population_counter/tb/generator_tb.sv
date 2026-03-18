class Generator;
  
  mailbox #(t_tr_gen) gen2drv;

  function new(input mailbox #(t_tr_gen) gen2drv);
    this.gen2drv = gen2drv;
  endfunction

  task run(int num_transactions);
    int fd;

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
              default: tr.data = $urandom();
            endcase

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
