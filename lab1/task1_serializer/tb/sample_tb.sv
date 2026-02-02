class Sample;
  static int id_inc;

  int id;
  bit data[$];
  int val_count;

  function new();
    id_inc++;
    this.id = id_inc;
  endfunction

  function void add(bit data_i);
    this.val_count++;
    this.data.push_back(data_i);
  endfunction

  function string to_string();
    string s;
    s = $sformatf("SAMPLE #%0t Len %0d ", id, data.size());
    foreach (data[i])
    begin
      s = {s, $sformatf("%b", data[i])};
    end
    return s;
  endfunction
endclass
