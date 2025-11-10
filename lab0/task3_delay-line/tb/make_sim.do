vlib work

vlog -sv ../rtl/delay_line.v
vlog -sv ../rtl/mux4.v
vlog -sv top_tb.sv

vsim -novopt top_tb

add log -r /*
add wave -r *
run -all
