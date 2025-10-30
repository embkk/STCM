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
// CREATED		"Thu Oct 30 17:17:45 2025"

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

wire	gdfx_temp0;
wire	SYNTHESIZED_WIRE_17;
wire	SYNTHESIZED_WIRE_1;
wire	SYNTHESIZED_WIRE_18;
wire	SYNTHESIZED_WIRE_3;
wire	SYNTHESIZED_WIRE_19;
wire	SYNTHESIZED_WIRE_20;
wire	SYNTHESIZED_WIRE_6;
wire	SYNTHESIZED_WIRE_21;
wire	SYNTHESIZED_WIRE_8;
wire	SYNTHESIZED_WIRE_12;
wire	SYNTHESIZED_WIRE_14;
wire	SYNTHESIZED_WIRE_16;

assign	data_val_o = data_val_i;



assign	SYNTHESIZED_WIRE_19 = data_i[0] & data_val_i;

assign	gdfx_temp0 = data_i[3] & data_val_i;

assign	gdfx_temp0 =  ~gdfx_temp0;

assign	SYNTHESIZED_WIRE_17 = gdfx_temp0 & data_val_i & data_i[2];

assign	SYNTHESIZED_WIRE_1 =  ~SYNTHESIZED_WIRE_17;

assign	SYNTHESIZED_WIRE_18 = SYNTHESIZED_WIRE_1 & data_val_i & data_i[0];

assign	SYNTHESIZED_WIRE_3 =  ~SYNTHESIZED_WIRE_18;

assign	SYNTHESIZED_WIRE_8 = SYNTHESIZED_WIRE_3 & data_val_i & data_i[0];

assign	data_left_o = {SYNTHESIZED_WIRE_19,SYNTHESIZED_WIRE_19,SYNTHESIZED_WIRE_19,SYNTHESIZED_WIRE_19} | {SYNTHESIZED_WIRE_20,SYNTHESIZED_WIRE_20,SYNTHESIZED_WIRE_20,SYNTHESIZED_WIRE_20} | {SYNTHESIZED_WIRE_6,SYNTHESIZED_WIRE_6,SYNTHESIZED_WIRE_6,SYNTHESIZED_WIRE_6} | {SYNTHESIZED_WIRE_21,SYNTHESIZED_WIRE_21,SYNTHESIZED_WIRE_21,SYNTHESIZED_WIRE_21};

assign	data_right_o = {SYNTHESIZED_WIRE_8,SYNTHESIZED_WIRE_8,SYNTHESIZED_WIRE_8,SYNTHESIZED_WIRE_8} | {SYNTHESIZED_WIRE_17,SYNTHESIZED_WIRE_17,SYNTHESIZED_WIRE_17,SYNTHESIZED_WIRE_17} | {gdfx_temp0,gdfx_temp0,gdfx_temp0,gdfx_temp0} | {SYNTHESIZED_WIRE_18,SYNTHESIZED_WIRE_18,SYNTHESIZED_WIRE_18,SYNTHESIZED_WIRE_18};

assign	SYNTHESIZED_WIRE_12 =  ~SYNTHESIZED_WIRE_19;

assign	SYNTHESIZED_WIRE_21 = SYNTHESIZED_WIRE_12 & data_val_i & data_i[1];

assign	SYNTHESIZED_WIRE_14 =  ~SYNTHESIZED_WIRE_21;

assign	SYNTHESIZED_WIRE_20 = SYNTHESIZED_WIRE_14 & data_val_i & data_i[2];

assign	SYNTHESIZED_WIRE_16 =  ~SYNTHESIZED_WIRE_20;

assign	SYNTHESIZED_WIRE_6 = SYNTHESIZED_WIRE_16 & data_val_i & data_i[3];


endmodule
