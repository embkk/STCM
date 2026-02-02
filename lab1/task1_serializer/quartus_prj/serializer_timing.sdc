# Create clock constraint - 150 MHz (6.667 ns period)
create_clock -name clk_i -period 6.667 [get_ports {clk_i}]

# Derive PLL clocks automatically
derive_pll_clocks

# Derive clock uncertainty
derive_clock_uncertainty

# Set input delay constraints (assume 50% of clock period)
set_input_delay -clock clk_i -max 3.333 [get_ports {srst_i data_i[*] data_mod_i[*] data_val_i}]
set_input_delay -clock clk_i -min 0.5 [get_ports {srst_i data_i[*] data_mod_i[*] data_val_i}]

# Set output delay constraints (assume 50% of clock period)
set_output_delay -clock clk_i -max 3.333 [get_ports {ser_data_o ser_data_val_o busy_o}]
set_output_delay -clock clk_i -min 0.5 [get_ports {ser_data_o ser_data_val_o busy_o}]

# Set false paths for asynchronous reset if needed
# set_false_path -from [get_ports {srst_i}] -to [all_registers]
