import testbench_pkg::*;

module serializer_tb #() (
  input  logic  clk_i,
  input  logic  rst_i
);

logic[15:0]  data;
logic[3:0]   data_mod; 
logic        data_val;
logic        ser_data;
logic        ser_data_val;
logic        busy;

serializer serializer_inst(
  .clk_i            (clk_i),
  .srst_i           (rst_i),
  .data_i           (data),
  .data_mod_i       (data_mod),
  .data_val_i       (data_val),
  .ser_data_o       (ser_data),
  .ser_data_val_o   (ser_data_val),
  .busy_o           (busy)
);

// --- Исправленная задача проверки ---
task check_step(input logic exp_data, input logic exp_val, input string msg = "");
  // Проверяем результат ПЕРЕД выводом, чтобы видеть актуальное состояние
  if (ser_data !== exp_data || ser_data_val !== exp_val) begin
    $display("ERROR: %s | Time: %0t", msg, $time);
    $display("  EXP: data=%b, vld=%b | GOT: data=%b, vld=%b", exp_data, exp_val, ser_data, ser_data_val);
    $display("  STATE: data_in=%h, busy=%b, vld_in=%b", data, busy, data_val);
    single_test_completed(1);
  end else begin
    $display("[%0t] OK: %s | Out: %b", $time, msg, ser_data);
  end
endtask : check_step

initial
  begin
    logic [15:0] expected_sr;
    int bits;

    // Сброс входов
    data = '0; data_mod = '0; data_val = 1'b0;

    // Ждем окончания сброса
    wait(rst_i == 1'b0);
    repeat(2) @(posedge clk_i); 

    // --- ТЕСТ 1: 5 БИТ ---
    wait(!busy);
    data     = 16'hAAAA; // Используем блокирующее для надежности в TB
    data_mod = 4'd5;
    data_val = 1'b1;
    expected_sr = 16'hAAAA;
    bits = 5;

    @(posedge clk_i); // Модуль должен увидеть data_val здесь
    #1;               // Маленькая задержка, чтобы busy успел обновиться для лога
    data_val = 1'b0;

    repeat(bits) begin
      @(posedge clk_i);
      check_step(expected_sr[15], 1'b1, "Bit test");
      expected_sr = expected_sr << 1;
    end
    single_test_completed(0);

    // --- ТЕСТ 2: 16 БИТ ---
    wait(!busy);
    data     = 16'h1234;
    data_mod = 4'd0;
    data_val = 1'b1;
    expected_sr = 16'h1234;
    bits = 16;

    @(posedge clk_i);
    #1;
    data_val = 1'b0;

    repeat(bits) begin
      @(posedge clk_i);
      check_step(expected_sr[15], 1'b1, "16-bit test");
      expected_sr = expected_sr << 1;
    end
    single_test_completed(0);

    repeat(10) @(posedge clk_i);
    finished = 1;
  end

endmodule