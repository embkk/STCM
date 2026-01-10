import testbench_pkg::*;

module serializer_tb #() (
  input  logic  clk_i,
  input  logic  rst_i
);

logic[15:0]  data;
logic        data_mod;
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

initial
  begin
    // Изначально ничего не шлем
    data     = '0;
    data_mod = '0;
    data_val = 1'b0;

    // Ждем, когда закончится сброс (ждем 0 на rst_i)
    wait(rst_i == 1'b0);
    // Ждем один такт для стабилизации
    @(posedge clk_i);

    // --- Посылка 1: 5 бит ---
    wait(!busy);                     // Ждем, если вдруг занято
    data     <= 16'hAAAA;            // 10101010...
    data_mod <= 4'd5;                // Валидны старшие 5 бит
    data_val <= 1'b1;                // Выставляем валидность
    
    @(posedge clk_i);                // Ждем такт захвата
    data_val <= 1'b0;                // Убираем валидность (по ТЗ держится 1 такт)

    // --- Посылка 2: Игнорируемая (mod = 2) ---
    wait(!busy);                     // Ждем окончания предыдущей передачи
    data     <= 16'hFFFF;
    data_mod <= 4'd2;                // Должно игнорироваться по ТЗ
    data_val <= 1'b1;
    
    @(posedge clk_i);
    data_val <= 1'b0;

    // --- Посылка 3: Все 16 бит (mod = 0) ---
    // Ждем пару тактов, чтобы убедиться, что mod=2 проигнорирован (busy остался 0)
    repeat(2) @(posedge clk_i);
    
    if (!busy) begin
        data     <= 16'h1234;
        data_mod <= 4'd0;            // Все 16 бит
        data_val <= 1'b1;
        @(posedge clk_i);
        data_val <= 1'b0;
    end

    // Ждем финала
    wait(!busy);
    repeat(10) @(posedge clk_i);
    testbench_pkg::finished = 1;
    $display("Simple test done.");
  end

endmodule