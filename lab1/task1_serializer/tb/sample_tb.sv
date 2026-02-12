class Sample;
  static int id_inc;

  int id;
  bit data[$];
  int val_count;
  int busy_count;

  function new();
    id_inc++;
    this.id = id_inc;
  endfunction

  function void add(bit data_val_i, data_i, busy_i);
    
    if(data_val_i)
      begin
         this.val_count++;
         this.data.push_back(data_i);
      end

    if(busy_i)
      this.busy_count++;
    
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
