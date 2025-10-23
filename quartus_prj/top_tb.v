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
// CREATED		"Thu Oct 23 13:03:54 2025"

module top_tb(
	data0_i,
	data1_i,
	data2_i,
	data3_i,
	dir_i,
	data_o
);


input wire	[1:0] data0_i;
input wire	[1:0] data1_i;
input wire	[1:0] data2_i;
input wire	[1:0] data3_i;
input wire	[1:0] dir_i;
output wire	[1:0] data_o;

wire	[1:0] data_o_ALTERA_SYNTHESIZED;
wire	SYNTHESIZED_WIRE_22;
wire	SYNTHESIZED_WIRE_2;
wire	SYNTHESIZED_WIRE_3;
wire	SYNTHESIZED_WIRE_6;
wire	SYNTHESIZED_WIRE_23;
wire	SYNTHESIZED_WIRE_8;
wire	SYNTHESIZED_WIRE_10;
wire	SYNTHESIZED_WIRE_11;
wire	SYNTHESIZED_WIRE_12;
wire	SYNTHESIZED_WIRE_13;
wire	SYNTHESIZED_WIRE_14;
wire	SYNTHESIZED_WIRE_15;
wire	SYNTHESIZED_WIRE_16;
wire	SYNTHESIZED_WIRE_17;
wire	SYNTHESIZED_WIRE_18;
wire	SYNTHESIZED_WIRE_19;
wire	SYNTHESIZED_WIRE_20;
wire	SYNTHESIZED_WIRE_21;




assign	SYNTHESIZED_WIRE_11 = data0_i[0] & SYNTHESIZED_WIRE_22;

assign	SYNTHESIZED_WIRE_13 = data0_i[1] & SYNTHESIZED_WIRE_22;

assign	SYNTHESIZED_WIRE_21 = SYNTHESIZED_WIRE_2 & dir_i[1];

assign	SYNTHESIZED_WIRE_20 = SYNTHESIZED_WIRE_3 & dir_i[1];

assign	SYNTHESIZED_WIRE_10 = data1_i[0] & dir_i[0];

assign	SYNTHESIZED_WIRE_12 = data1_i[1] & dir_i[0];

assign	SYNTHESIZED_WIRE_15 = data2_i[0] & SYNTHESIZED_WIRE_22;

assign	SYNTHESIZED_WIRE_17 = data2_i[1] & SYNTHESIZED_WIRE_22;

assign	SYNTHESIZED_WIRE_14 = data3_i[0] & dir_i[0];

assign	SYNTHESIZED_WIRE_16 = data3_i[1] & dir_i[0];

assign	SYNTHESIZED_WIRE_19 = SYNTHESIZED_WIRE_6 & SYNTHESIZED_WIRE_23;

assign	SYNTHESIZED_WIRE_18 = SYNTHESIZED_WIRE_8 & SYNTHESIZED_WIRE_23;

assign	SYNTHESIZED_WIRE_22 =  ~dir_i[0];

assign	SYNTHESIZED_WIRE_23 =  ~dir_i[1];

assign	SYNTHESIZED_WIRE_6 = SYNTHESIZED_WIRE_10 | SYNTHESIZED_WIRE_11;

assign	SYNTHESIZED_WIRE_8 = SYNTHESIZED_WIRE_12 | SYNTHESIZED_WIRE_13;

assign	SYNTHESIZED_WIRE_2 = SYNTHESIZED_WIRE_14 | SYNTHESIZED_WIRE_15;

assign	SYNTHESIZED_WIRE_3 = SYNTHESIZED_WIRE_16 | SYNTHESIZED_WIRE_17;

assign	data_o_ALTERA_SYNTHESIZED[0] = SYNTHESIZED_WIRE_18 | SYNTHESIZED_WIRE_19;

assign	data_o_ALTERA_SYNTHESIZED[1] = SYNTHESIZED_WIRE_20 | SYNTHESIZED_WIRE_21;

assign	data_o = data_o_ALTERA_SYNTHESIZED;

endmodule
