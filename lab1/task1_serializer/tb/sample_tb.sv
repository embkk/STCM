class Sample;
  longint timestamp;
  bit data_sampled[$];
  int val_count;

  function new();
    this.timestamp = $time;
  endfunction

  function void add(bit data_i);
    this.val_count++;
    this.data_sampled.push_back(data_i);
  endfunction

  function string to_string();
    string s;
    s = $sformatf("SAMPLE #%0t Len %0d ", timestamp, data_sampled.size());
    foreach (data_sampled[i])
    begin
      s = {s, $sformatf("%b", data_sampled[i])};
    end
    return s;
  endfunction
endclass
