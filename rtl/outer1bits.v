// Copyright (C) 2018  Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions 
// and other software and tools, and its AMPP partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License 
// Subscription Agreement, the Intel Quartus Prime License Agreement,
// the Intel FPGA IP License Agreement, or other applicable license
// agreement, including, without limitation, that your use is for
// the sole purpose of programming logic devices manufactured by
// Intel and sold by Intel or its authorized distributors.  Please
// refer to the applicable agreement for further details.

// PROGRAM		"Quartus Prime"
// VERSION		"Version 18.1.0 Build 625 09/12/2018 SJ Lite Edition"
// CREATED		"Thu Nov  6 09:48:29 2025"

module outer1bits(
	data_val_i,
	data_i,
	data_val_o,
	data_left_o,
	data_right_o
);


input wire	data_val_i;
input wire	[3:0] data_i;
output wire	data_val_o;
output wire	[3:0] data_left_o;
output wire	[3:0] data_right_o;

wire	[3:0] data_left_o_ALTERA_SYNTHESIZED;
wire	[3:0] data_right_o_ALTERA_SYNTHESIZED;
wire	SYNTHESIZED_WIRE_0;
wire	SYNTHESIZED_WIRE_16;
wire	SYNTHESIZED_WIRE_2;
wire	SYNTHESIZED_WIRE_3;
wire	SYNTHESIZED_WIRE_4;
wire	SYNTHESIZED_WIRE_17;
wire	SYNTHESIZED_WIRE_6;
wire	SYNTHESIZED_WIRE_7;
wire	SYNTHESIZED_WIRE_8;
wire	SYNTHESIZED_WIRE_10;
wire	SYNTHESIZED_WIRE_11;
wire	SYNTHESIZED_WIRE_12;
wire	SYNTHESIZED_WIRE_13;
wire	SYNTHESIZED_WIRE_15;

assign	data_val_o = data_val_i;



assign	data_right_o_ALTERA_SYNTHESIZED[1] = SYNTHESIZED_WIRE_0 & data_i[1];

assign	SYNTHESIZED_WIRE_2 =  ~SYNTHESIZED_WIRE_16;

assign	SYNTHESIZED_WIRE_11 = SYNTHESIZED_WIRE_2 & data_i[0];

assign	SYNTHESIZED_WIRE_15 =  ~data_left_o_ALTERA_SYNTHESIZED[2];

assign	SYNTHESIZED_WIRE_17 = SYNTHESIZED_WIRE_3 & data_i[2];

assign	SYNTHESIZED_WIRE_4 = ~(data_i[0] | data_right_o_ALTERA_SYNTHESIZED[1]);

assign	data_right_o_ALTERA_SYNTHESIZED[2] = SYNTHESIZED_WIRE_4 & SYNTHESIZED_WIRE_17;

assign	SYNTHESIZED_WIRE_6 = ~(data_right_o_ALTERA_SYNTHESIZED[2] | data_right_o_ALTERA_SYNTHESIZED[1] | data_i[0]);

assign	data_right_o_ALTERA_SYNTHESIZED[3] = SYNTHESIZED_WIRE_6 & SYNTHESIZED_WIRE_7;

assign	SYNTHESIZED_WIRE_8 = ~(data_i[3] | data_left_o_ALTERA_SYNTHESIZED[2]);

assign	SYNTHESIZED_WIRE_0 =  ~data_i[0];

assign	data_left_o_ALTERA_SYNTHESIZED[1] = SYNTHESIZED_WIRE_8 & SYNTHESIZED_WIRE_16;

assign	SYNTHESIZED_WIRE_10 = ~(data_left_o_ALTERA_SYNTHESIZED[1] | data_left_o_ALTERA_SYNTHESIZED[2] | data_i[3]);

assign	data_left_o_ALTERA_SYNTHESIZED[0] = SYNTHESIZED_WIRE_10 & SYNTHESIZED_WIRE_11;

assign	SYNTHESIZED_WIRE_13 =  ~data_i[3];

assign	SYNTHESIZED_WIRE_7 = SYNTHESIZED_WIRE_12 & data_i[3];

assign	data_left_o_ALTERA_SYNTHESIZED[2] = SYNTHESIZED_WIRE_13 & data_i[2];

assign	SYNTHESIZED_WIRE_3 =  ~data_right_o_ALTERA_SYNTHESIZED[1];

assign	SYNTHESIZED_WIRE_12 =  ~SYNTHESIZED_WIRE_17;

assign	SYNTHESIZED_WIRE_16 = SYNTHESIZED_WIRE_15 & data_i[1];

assign	data_left_o = data_left_o_ALTERA_SYNTHESIZED;
assign	data_right_o = data_right_o_ALTERA_SYNTHESIZED;

endmodule
