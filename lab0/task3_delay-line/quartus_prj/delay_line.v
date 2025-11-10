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
// CREATED		"Mon Nov 10 13:29:11 2025"

module delay_line(
	clk_i,
	rst_i,
	data_i,
	data_o
);


input wire	clk_i;
input wire	rst_i;
input wire	data_i;
output reg	data_o;

wire	SYNTHESIZED_WIRE_16;
reg	DFF_inst01;
reg	DFF_inst02;
reg	DFF_inst03;
reg	DFF_inst04;
reg	DFF_inst05;
reg	DFF_inst06;
reg	DFF_inst07;
reg	DFF_inst08;
reg	DFF_inst09;
reg	DFF_inst10;
reg	DFF_inst11;
reg	DFF_inst12;
reg	DFF_inst13;
reg	DFF_inst14;
reg	DFF_inst15;




assign	SYNTHESIZED_WIRE_16 =  ~rst_i;


always@(posedge clk_i or negedge SYNTHESIZED_WIRE_16)
begin
if (!SYNTHESIZED_WIRE_16)
	begin
	DFF_inst01 <= 0;
	end
else
	begin
	DFF_inst01 <= data_i;
	end
end


always@(posedge clk_i or negedge SYNTHESIZED_WIRE_16)
begin
if (!SYNTHESIZED_WIRE_16)
	begin
	DFF_inst02 <= 0;
	end
else
	begin
	DFF_inst02 <= DFF_inst01;
	end
end


always@(posedge clk_i or negedge SYNTHESIZED_WIRE_16)
begin
if (!SYNTHESIZED_WIRE_16)
	begin
	DFF_inst03 <= 0;
	end
else
	begin
	DFF_inst03 <= DFF_inst02;
	end
end


always@(posedge clk_i or negedge SYNTHESIZED_WIRE_16)
begin
if (!SYNTHESIZED_WIRE_16)
	begin
	DFF_inst04 <= 0;
	end
else
	begin
	DFF_inst04 <= DFF_inst03;
	end
end


always@(posedge clk_i or negedge SYNTHESIZED_WIRE_16)
begin
if (!SYNTHESIZED_WIRE_16)
	begin
	DFF_inst05 <= 0;
	end
else
	begin
	DFF_inst05 <= DFF_inst04;
	end
end


always@(posedge clk_i or negedge SYNTHESIZED_WIRE_16)
begin
if (!SYNTHESIZED_WIRE_16)
	begin
	DFF_inst06 <= 0;
	end
else
	begin
	DFF_inst06 <= DFF_inst05;
	end
end


always@(posedge clk_i or negedge SYNTHESIZED_WIRE_16)
begin
if (!SYNTHESIZED_WIRE_16)
	begin
	DFF_inst07 <= 0;
	end
else
	begin
	DFF_inst07 <= DFF_inst06;
	end
end


always@(posedge clk_i or negedge SYNTHESIZED_WIRE_16)
begin
if (!SYNTHESIZED_WIRE_16)
	begin
	DFF_inst08 <= 0;
	end
else
	begin
	DFF_inst08 <= DFF_inst07;
	end
end


always@(posedge clk_i or negedge SYNTHESIZED_WIRE_16)
begin
if (!SYNTHESIZED_WIRE_16)
	begin
	DFF_inst09 <= 0;
	end
else
	begin
	DFF_inst09 <= DFF_inst08;
	end
end


always@(posedge clk_i or negedge SYNTHESIZED_WIRE_16)
begin
if (!SYNTHESIZED_WIRE_16)
	begin
	DFF_inst10 <= 0;
	end
else
	begin
	DFF_inst10 <= DFF_inst09;
	end
end


always@(posedge clk_i or negedge SYNTHESIZED_WIRE_16)
begin
if (!SYNTHESIZED_WIRE_16)
	begin
	DFF_inst11 <= 0;
	end
else
	begin
	DFF_inst11 <= DFF_inst10;
	end
end


always@(posedge clk_i or negedge SYNTHESIZED_WIRE_16)
begin
if (!SYNTHESIZED_WIRE_16)
	begin
	DFF_inst12 <= 0;
	end
else
	begin
	DFF_inst12 <= DFF_inst11;
	end
end


always@(posedge clk_i or negedge SYNTHESIZED_WIRE_16)
begin
if (!SYNTHESIZED_WIRE_16)
	begin
	DFF_inst13 <= 0;
	end
else
	begin
	DFF_inst13 <= DFF_inst12;
	end
end


always@(posedge clk_i or negedge SYNTHESIZED_WIRE_16)
begin
if (!SYNTHESIZED_WIRE_16)
	begin
	DFF_inst14 <= 0;
	end
else
	begin
	DFF_inst14 <= DFF_inst13;
	end
end


always@(posedge clk_i or negedge SYNTHESIZED_WIRE_16)
begin
if (!SYNTHESIZED_WIRE_16)
	begin
	DFF_inst15 <= 0;
	end
else
	begin
	DFF_inst15 <= DFF_inst14;
	end
end


always@(posedge clk_i or negedge SYNTHESIZED_WIRE_16)
begin
if (!SYNTHESIZED_WIRE_16)
	begin
	data_o <= 0;
	end
else
	begin
	data_o <= DFF_inst15;
	end
end


endmodule
