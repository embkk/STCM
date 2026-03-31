class TestConfig #(int WIDTH );
  
  
  test_mode_t       mode;
  int               num_transactions;
  logic [WIDTH-1:0] predefined[];

  

  function new(test_mode_t m = RAND_NO_GAP, logic [WIDTH-1:0] pred[] = '{}, int n = 1 );
    this.mode = m;
    this.predefined = pred;

    this.num_transactions = mode == LIST_DATA ? pred.size() : n;
  endfunction

  function string to_string();
    return $sformatf("%s test (%0d transcations)", mode, num_transactions);
  endfunction

endclass