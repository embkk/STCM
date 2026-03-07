onerror {resume}
quietly WaveActivateNextPane {} 0

add wave -noupdate -divider "=== SYSTEM ==="
add wave -noupdate -color "Yellow" /top_tb/clk_i
add wave -noupdate /top_tb/priority_encoder_bus/srst_i

add wave -noupdate -divider "=== INPUTS ==="
add wave -noupdate -expand -group "DUT_IN" /top_tb/priority_encoder_bus/data_i
add wave -noupdate -expand -group "DUT_IN" /top_tb/priority_encoder_bus/data_val_i

add wave -noupdate -divider "=== INTERNAL ==="

add wave -noupdate -divider "=== OUTPUTS ==="
add wave -noupdate -expand -group "DUT_OUT" /top_tb/priority_encoder_bus/data_left_o
add wave -noupdate -expand -group "DUT_OUT" /top_tb/priority_encoder_bus/data_right_o
add wave -noupdate -expand -group "DUT_OUT" /top_tb/priority_encoder_bus/data_val_o

TreeUpdate [SetDefaultTree]
configure wave -signalnamewidth 1
update