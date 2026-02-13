class Transaction #(parameter TR_MAX_LENGTH = 16);
  static int id_inc;
  int        id;
  bit [15:0] data;

  int gap;

  static int crand = 0;

  extern function new();
  extern function bit randomize_free();

  function string to_string();
    return $sformatf("TRANSACTION #%0d %b data_mod %0d", this.id, this.data, this.data_mod);
  endfunction

endclass

function Transaction::new();
  id = ++id_inc;
endfunction

function bit Transaction::randomize_free();
  this.data = $urandom();

  this.data_mod  = crand;
  crand++;

  gap = this.data_mod inside {1,2} ? TR_MAX_LENGTH : 1;

  return 1;
endfunction
