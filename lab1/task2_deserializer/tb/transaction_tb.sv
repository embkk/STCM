class Transaction #(parameter TR_MAX_LENGTH = 16);
  static int id_inc;
  int        id;
  int        data;
  int        data_val;

  int gap;

  static int crand = 0;

  extern function new();
  extern function bit randomize_free();

  function string to_string();
    return $sformatf("TRANSACTION #%0d data %b valid %b", this.id, this.data, this.data_val);
  endfunction

endclass

function Transaction::new();
  id = ++id_inc;
endfunction

function bit Transaction::randomize_free();
  
  this.data = $urandom();

  // only 16 valid signals in 32 pulses
  for (int i = 0; i < 16; )
    begin
      int idx = $urandom_range(0, 31);
      if (data_val[idx] == 0)
      begin
        data_val[idx] = 1'b1;
        i++;
      end
    end

  return 1;
endfunction
