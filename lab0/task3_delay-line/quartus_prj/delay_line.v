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
// CREATED		"Mon Nov 10 12:11:38 2025"

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

reg	DFF_inst0;
reg	DFF_inst9;
reg	DFF_inst10;
reg	DFF_inst11;
reg	DFF_inst12;
reg	DFF_inst13;
reg	DFF_inst14;
reg	DFF_inst1;
reg	DFF_inst2;
reg	DFF_inst3;
reg	DFF_inst4;
reg	DFF_inst5;
reg	DFF_inst6;
reg	DFF_inst7;
reg	DFF_inst8;





always@(posedge clk_i or negedge rst_i)
begin
if (!rst_i)
	begin
	DFF_inst0 <= 0;
	end
else
	begin
	DFF_inst0 <= data_i;
	end
end


always@(posedge clk_i or negedge rst_i)
begin
if (!rst_i)
	begin
	DFF_inst1 <= 0;
	end
else
	begin
	DFF_inst1 <= DFF_inst0;
	end
end


always@(posedge clk_i or negedge rst_i)
begin
if (!rst_i)
	begin
	DFF_inst10 <= 0;
	end
else
	begin
	DFF_inst10 <= DFF_inst9;
	end
end


always@(posedge clk_i or negedge rst_i)
begin
if (!rst_i)
	begin
	DFF_inst11 <= 0;
	end
else
	begin
	DFF_inst11 <= DFF_inst10;
	end
end


always@(posedge clk_i or negedge rst_i)
begin
if (!rst_i)
	begin
	DFF_inst12 <= 0;
	end
else
	begin
	DFF_inst12 <= DFF_inst11;
	end
end


always@(posedge clk_i or negedge rst_i)
begin
if (!rst_i)
	begin
	DFF_inst13 <= 0;
	end
else
	begin
	DFF_inst13 <= DFF_inst12;
	end
end


always@(posedge clk_i or negedge rst_i)
begin
if (!rst_i)
	begin
	DFF_inst14 <= 0;
	end
else
	begin
	DFF_inst14 <= DFF_inst13;
	end
end


always@(posedge clk_i or negedge rst_i)
begin
if (!rst_i)
	begin
	data_o <= 0;
	end
else
	begin
	data_o <= DFF_inst14;
	end
end


always@(posedge clk_i or negedge rst_i)
begin
if (!rst_i)
	begin
	DFF_inst2 <= 0;
	end
else
	begin
	DFF_inst2 <= DFF_inst1;
	end
end


always@(posedge clk_i or negedge rst_i)
begin
if (!rst_i)
	begin
	DFF_inst3 <= 0;
	end
else
	begin
	DFF_inst3 <= DFF_inst2;
	end
end


always@(posedge clk_i or negedge rst_i)
begin
if (!rst_i)
	begin
	DFF_inst4 <= 0;
	end
else
	begin
	DFF_inst4 <= DFF_inst3;
	end
end


always@(posedge clk_i or negedge rst_i)
begin
if (!rst_i)
	begin
	DFF_inst5 <= 0;
	end
else
	begin
	DFF_inst5 <= DFF_inst4;
	end
end


always@(posedge clk_i or negedge rst_i)
begin
if (!rst_i)
	begin
	DFF_inst6 <= 0;
	end
else
	begin
	DFF_inst6 <= DFF_inst5;
	end
end


always@(posedge clk_i or negedge rst_i)
begin
if (!rst_i)
	begin
	DFF_inst7 <= 0;
	end
else
	begin
	DFF_inst7 <= DFF_inst6;
	end
end


always@(posedge clk_i or negedge rst_i)
begin
if (!rst_i)
	begin
	DFF_inst8 <= 0;
	end
else
	begin
	DFF_inst8 <= DFF_inst7;
	end
end


always@(posedge clk_i or negedge rst_i)
begin
if (!rst_i)
	begin
	DFF_inst9 <= 0;
	end
else
	begin
	DFF_inst9 <= DFF_inst8;
	end
end


endmodule
