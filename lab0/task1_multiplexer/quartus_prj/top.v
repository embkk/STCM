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
// CREATED		"Thu Oct 23 13:27:21 2025"

module top(
	signal0,
	signal1,
	signal2,
	signal3,
	signal_direction,
	result
);


input wire	[1:0] signal0;
input wire	[1:0] signal1;
input wire	[1:0] signal2;
input wire	[1:0] signal3;
input wire	[1:0] signal_direction;
output wire	[1:0] result;






mux4	b2v_mux4_inst(
	.data0_i(signal0),
	.data1_i(signal1),
	.data2_i(signal2),
	.data3_i(signal3),
	.dir_i(signal_direction),
	.data_o(result));


endmodule
