vlib work

vlog ../rtl/crc16.v
vlog top_tb.sv

vsim -novopt -sv_lib ./crc16_ref top_tb


add log -r /*
add wave -r *
run -all
