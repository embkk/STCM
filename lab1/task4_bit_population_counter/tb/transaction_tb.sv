class TransactionGen #( parameter WIDTH );
  static int id_inc;
  
  logic [WIDTH-1:0] data;
  int               gap;
  int               id;

  function new();
    id_inc++;
    this.id = id_inc;
  endfunction

  virtual function string to_string();
    return $sformatf("{Transaction #%0d: %b, Gap: %0d}", id, data, gap);
  endfunction
endclass

class TransactionMon #( parameter WIDTH );
  
  logic [$clog2(WIDTH):0] data;
  int                     id;

  function new();
  endfunction

  virtual function string to_string();
    return $sformatf("{Transaction mon %b}", data);
  endfunction
endclass