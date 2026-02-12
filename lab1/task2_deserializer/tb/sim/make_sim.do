vlib work

set ROOT_DIR "../.."

vlog -sv $ROOT_DIR/if/deserializer_if.sv
vlog -sv $ROOT_DIR/rtl/deserializer.sv

vlog -sv $ROOT_DIR/tb/testbench_pkg.sv

vlog -sv $ROOT_DIR/tb/test.sv
vlog -sv $ROOT_DIR/tb/top_tb.sv

vsim -novopt -sv_seed random top_tb

add log -r /*
add wave -r *
run -all
