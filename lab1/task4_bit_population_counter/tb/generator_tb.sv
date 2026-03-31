class Generator;
  
  mailbox #(t_tr_gen) gen2drv;

  function new(input mailbox #(t_tr_gen) gen2drv);
    this.gen2drv = gen2drv;
  endfunction

  task run(config_t test_config);
    t_tr_gen tr;

    fork
      for (int i = 0; i < test_config.num_transactions; i++)
        begin
          case (test_config.mode)
            LIST_DATA:    begin
                            tr = new();
                            tr.data = test_config.predefined[i];
                          end
            RAND_NO_GAP:   tr = generate_random_transaction(0);
            RAND_WITH_GAP: tr = generate_random_transaction(1);
            default:       $error("Undefined TestConfig mode");
          endcase

          gen2drv.put(tr);
        end
    join
  endtask

  function t_tr_gen generate_random_transaction(bit randomize_gap = 0);
    t_tr_gen tr;
    tr = new();

    // Твой алгоритм заполнения
    tr.data = '0; 
    for (int i = 0; i < (tr.WIDTH + 31) / 32; i++)
      tr.data[i*32 +: 32] = $urandom();

    if(randomize_gap)
      tr.gap = $urandom_range(0,3);

    return tr;
  endfunction


endclass

