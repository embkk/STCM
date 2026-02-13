class Sample;
  static int id_inc;

  int          id;
  logic [15:0] data;

  function new();
    id_inc++;
    this.id = id_inc;
  endfunction
    
  function string to_string();
    return $sformatf("SAMPLE #%0d %b", id, data);
  endfunction
endclass