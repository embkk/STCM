vlib work

vlog -sv ../if/serializer_if.sv
vlog -sv ../rtl/serializer.sv

vlog -sv testbench_pkg.sv

vlog -sv top_tb.sv

vsim -novopt -sv_seed random top_tb

add log -r /*
add wave -r *
run -all
