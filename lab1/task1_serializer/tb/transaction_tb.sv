class Transaction;
  static int id_inc;
  int        id;
  bit [15:0] data;
  bit [3:0]  data_mod;
  bit [4:0]  len;

  static int crand;

  function new();
    id = ++id_inc;
  endfunction



  function int randomize_free();
    this.data = $urandom();

    this.data_mod  = crand;
    crand++;

    case (data_mod)
      0       : this.len = 16;
      1, 2    : this.len = 0;
      default : this.len = data_mod;
    endcase

    return 1;

  endfunction

  function string to_string();
    return $sformatf("TRANSACTION #%0d %b data_mod %0d length %0d", this.id, this.data, this.data_mod, this.len);
  endfunction
endclass
