class Monitor;
  virtual serializer_if vif;

  function new(virtual serializer_if vif_i);
    this.vif = vif_i;
  endfunction

  task start();
    // Логика прослушки шины
  endtask
endclass