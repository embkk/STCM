class Transaction #(parameter TR_MAX_LENGTH = 16);
  static int id_inc;
  int        id;
  int        gap;

  bit [31:0] data;
  bit [31:0] data_val;

  extern function new();
  extern function bit randomize_free();

  function string to_string();
    return $sformatf("TRANSACTION #%0d data %b valid %b", this.id, this.data, this.data_val);
  endfunction

endclass

function Transaction::new();
  id = ++id_inc;
endfunction

// Transaction contains
// Total pulses: 32
// Valid pulses: 16
function bit Transaction::randomize_free();
  int i, j;
  bit temp_bit;

  this.data = $urandom();

  this.data_val = 32'hFFFF0000;

  for (i = 31; i > 0; i--)
  begin
    j = $urandom_range(0, i);
    
    temp_bit = this.data_val[i];
    this.data_val[i] = this.data_val[j];
    this.data_val[j] = temp_bit;
  end

  return 1;
endfunction
