vlib work

vlog -sv testbench_pkg.sv
vlog -sv ../rtl/deserializer.sv
vlog -sv deserializer_tb.sv
vlog -sv top_tb.sv

vsim -novopt -sv_seed random top_tb

add log -r /*
add wave -r *
run -all
