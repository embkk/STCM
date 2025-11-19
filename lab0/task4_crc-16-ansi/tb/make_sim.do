vlib work

vlog -sv ../rtl/crc16.v
vlog -sv top_tb.sv

vsim -novopt top_tb

add log -r /*
add wave -r *
run -all
