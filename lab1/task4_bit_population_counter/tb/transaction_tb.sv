class Transaction #( parameter WIDTH = 32 );
  int             id;
    
  function string to_string();
    return $sformatf("{Transaction #%0d}", id);
  endfunction
endclass

class TransactionGen extends Transaction;
  static int id_inc;

  logic [WIDTH:0] data;
  int             gap;

  function new();
    super.new();
    id_inc++;
    this.id = id_inc;
  endfunction

  virtual function string to_string();
    return $sformatf("{Transaction #%0d: %b, Gap: %0d}", id, data, gap);
  endfunction
endclass

class TransactionMon extends Transaction;
  
  logic [$clog2(WIDTH):0] data;

  function new();
    super.new();
  endfunction

  virtual function string to_string();
    return $sformatf("{Transaction mon %b}", data);
  endfunction
endclass