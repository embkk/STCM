class Sample;
  static int sample_id_inc;

  int sample_id;
  bit data_sampled[$];
  int val_count;

  function new();
    sample_id_inc++;
    this.sample_id = sample_id_inc;
  endfunction

  function void add(bit data_i);
    this.val_count++;
    this.data_sampled.push_back(data_i);
  endfunction

  function string to_string();
    string s;
    s = $sformatf("SAMPLE #%0t Len %0d ", sample_id, data_sampled.size());
    foreach (data_sampled[i])
    begin
      s = {s, $sformatf("%b", data_sampled[i])};
    end
    return s;
  endfunction
endclass
