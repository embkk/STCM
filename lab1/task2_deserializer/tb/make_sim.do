vlib work

vlog -sv ../if/deserializer_if.sv
vlog -sv ../rtl/deserializer.sv

vlog -sv testbench_pkg.sv

vlog -sv test.sv
vlog -sv top_tb.sv

vsim -novopt -sv_seed random top_tb

add log -r /*
add wave -r *
run -all