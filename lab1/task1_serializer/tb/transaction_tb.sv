class Transaction;
  static int ID_inc;
  int        ID;
  bit [15:0] data;
  bit [3:0]  data_mod;
  bit [4:0]  len;

  function new();
    ID = ++ID_inc;

    this.data = $urandom();
    this.data_mod  = $urandom();

    case (data_mod)
      0       : this.len = 16;
      1, 2    : this.len = 0;
      default : this.len = data_mod;
    endcase
  endfunction

  function string to_string();
    return $sformatf("#%0d tr %b data_mod %0d length %0d", this.ID, this.data, this.data_mod, this.len);
  endfunction
endclass
