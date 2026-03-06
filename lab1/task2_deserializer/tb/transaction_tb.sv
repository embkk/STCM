class Transaction;
  int          id;
  logic [15:0] data;
    
  function string to_string();
    return $sformatf("{Transaction #%0d %b}", id, data);
  endfunction
endclass

class TransactionGen extends Transaction;
  static int id_inc;
  int        gap;
  bit        en_rnd_valid;

  function new();
    super.new();
    id_inc++;
    this.id = id_inc;
  endfunction

  virtual function string to_string();
    return $sformatf("{Transaction #%0d: %b, Gap: %0d}", id, data, gap);
  endfunction
endclass