vlib work

vlog -sv ../quartus_prj/mux4.v
vlog -sv top_tb.sv

vsim -novopt top_tb

add log -r /*
add wave -r *
run -all
