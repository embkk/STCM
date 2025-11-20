vlib work

vlog ../rtl/crc16.v
vlog top_tb.sv

vsim -novopt top_tb

add log -r /*
add wave -r *
run -all
