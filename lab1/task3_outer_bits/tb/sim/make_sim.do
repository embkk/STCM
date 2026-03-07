vlib work

set ROOT_DIR "../.."

# Compilation
vlog -sv $ROOT_DIR/if/deserializer_if.sv
vlog -sv $ROOT_DIR/rtl/deserializer.sv
vlog -sv $ROOT_DIR/tb/testbench_pkg.sv
vlog -sv $ROOT_DIR/tb/test.sv
vlog -sv $ROOT_DIR/tb/top_tb.sv

# Simulation start
vsim -novopt -sv_seed random top_tb

# Logging
add log -r /*

# Просто открываем окно и чистим старые сигналы
view wave
delete wave *

# Загружаем конфиг из файла
do wave.do

# Run
run -all