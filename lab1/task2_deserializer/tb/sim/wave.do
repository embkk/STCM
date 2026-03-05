onerror {resume}
quietly WaveActivateNextPane {} 0

add wave -noupdate -divider "=== SYSTEM ==="
add wave -noupdate -color "Yellow" /top_tb/clk
add wave -noupdate /top_tb/deserializer_bus/srst

add wave -noupdate -divider "=== INPUTS ==="
add wave -noupdate -expand -group "DUT_IN" /top_tb/deserializer_bus/data
add wave -noupdate -expand -group "DUT_IN" /top_tb/deserializer_bus/data_val

add wave -noupdate -divider "=== INTERNAL ==="
add wave -noupdate -expand -group "INTERNAL" -radix unsigned /top_tb/dut_inst/tr_counter

add wave -noupdate -divider "=== OUTPUTS ==="
add wave -noupdate -expand -group "DUT_OUT" -radix binary /top_tb/deserializer_bus/deser_data
add wave -noupdate -expand -group "DUT_OUT"               /top_tb/deserializer_bus/deser_data_val

TreeUpdate [SetDefaultTree]
configure wave -signalnamewidth 1
update