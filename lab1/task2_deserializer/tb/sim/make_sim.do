vlib work

set ROOT_DIR "../.."

vlog -sv $ROOT_DIR/if/deserializer_if.sv
vlog -sv $ROOT_DIR/rtl/deserializer.sv

vlog -sv $ROOT_DIR/tb/testbench_pkg.sv

vlog -sv $ROOT_DIR/tb/test.sv
vlog -sv $ROOT_DIR/tb/top_tb.sv

vsim -novopt -sv_seed random top_tb

add log -r /*
vsim -novopt -sv_seed random top_tb

view wave
delete wave *

add wave -noupdate -divider "=== SYSTEM ==="
add wave -noupdate -color "Yellow" /top_tb/clk
add wave -noupdate /top_tb/deserializer_bus/srst

add wave -noupdate -divider "=== INPUTS ==="
add wave -noupdate -group "DUT_IN" /top_tb/deserializer_bus/data
add wave -noupdate -group "DUT_IN" /top_tb/deserializer_bus/data_val

add wave -noupdate -divider "=== INTERNAL ==="
add wave -noupdate -group "INTERNAL" /top_tb/dut_inst/tr_counter

add wave -noupdate -divider "=== OUTPUTS ==="
# -hex чтобы не видеть бинарную помойку
add wave -noupdate -group "DUT_OUT" -hex /top_tb/deserializer_bus/deser_data
add wave -noupdate -group "DUT_OUT"      /top_tb/deserializer_bus/deser_data_val

configure wave -signalnamewidth 1
update

run -all