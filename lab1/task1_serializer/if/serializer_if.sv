interface serializer_if(input logic clk);
  logic [15:0] data;
  logic [3:0]  data_mod;
  logic        data_val;
  logic        ser_data;
  logic        ser_data_val;
  logic        busy;
  logic        srst;

  default clocking cb @(posedge clk);
    default input #1ns output #1ns;
    output data, data_mod, data_val, srst; // Добавил srst сюда
    input  ser_data, ser_data_val, busy;
  endclocking

  modport DRIVER (
    clocking cb,
    import task reset_t(), // Task тоже надо импортить, если юзаешь через интерфейс
    import task send(input logic [15:0] d, input logic [3:0] m)
  );

  modport MONITOR (
    clocking cb,
    import task receive(output logic d_ser, output logic v_ser)
  );

  modport DUT (
    input  data, data_mod, data_val, srst, clk,
    output ser_data, ser_data_val, busy
  );

  task reset();
    cb.srst <= 1'b1;
    ##2;
    cb.srst <= 1'b0;
    ##1;
  endtask

  task send(input logic [15:0] d, input logic [3:0] m);
    while(cb.busy === 1'b1) @(cb); // Ждем по клокблоку
    cb.data     <= d;
    cb.data_mod <= m;
    cb.data_val <= 1'b1;
    @(cb);
    cb.data_val <= 1'b0;
  endtask

  task receive(output logic d_ser, output logic v_ser);
    @(cb);
    d_ser = cb.ser_data;
    v_ser = cb.ser_data_val;
  endtask
endinterface