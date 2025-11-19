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
// CREATED		"Wed Nov 19 09:31:18 2025"

module crc16(
	clk_i,
	rst_i,
	data_i,
	crc_o
);


input wire	clk_i;
input wire	rst_i;
input wire	data_i;
output wire	[15:0] crc_o;

reg	[15:0] crc;
wire	SYNTHESIZED_WIRE_21;
wire	SYNTHESIZED_WIRE_22;
wire	SYNTHESIZED_WIRE_4;
wire	SYNTHESIZED_WIRE_18;




assign	SYNTHESIZED_WIRE_21 =  ~rst_i;


always@(posedge clk_i or negedge SYNTHESIZED_WIRE_21)
begin
if (!SYNTHESIZED_WIRE_21)
	begin
	crc[0] <= 0;
	end
else
	begin
	crc[0] <= SYNTHESIZED_WIRE_22;
	end
end


always@(posedge clk_i or negedge SYNTHESIZED_WIRE_21)
begin
if (!SYNTHESIZED_WIRE_21)
	begin
	crc[1] <= 0;
	end
else
	begin
	crc[1] <= crc[0];
	end
end


always@(posedge clk_i or negedge SYNTHESIZED_WIRE_21)
begin
if (!SYNTHESIZED_WIRE_21)
	begin
	crc[2] <= 0;
	end
else
	begin
	crc[2] <= SYNTHESIZED_WIRE_4;
	end
end


always@(posedge clk_i or negedge SYNTHESIZED_WIRE_21)
begin
if (!SYNTHESIZED_WIRE_21)
	begin
	crc[3] <= 0;
	end
else
	begin
	crc[3] <= crc[2];
	end
end


always@(posedge clk_i or negedge SYNTHESIZED_WIRE_21)
begin
if (!SYNTHESIZED_WIRE_21)
	begin
	crc[4] <= 0;
	end
else
	begin
	crc[4] <= crc[3];
	end
end


always@(posedge clk_i or negedge SYNTHESIZED_WIRE_21)
begin
if (!SYNTHESIZED_WIRE_21)
	begin
	crc[5] <= 0;
	end
else
	begin
	crc[5] <= crc[4];
	end
end


always@(posedge clk_i or negedge SYNTHESIZED_WIRE_21)
begin
if (!SYNTHESIZED_WIRE_21)
	begin
	crc[6] <= 0;
	end
else
	begin
	crc[6] <= crc[5];
	end
end


always@(posedge clk_i or negedge SYNTHESIZED_WIRE_21)
begin
if (!SYNTHESIZED_WIRE_21)
	begin
	crc[7] <= 0;
	end
else
	begin
	crc[7] <= crc[6];
	end
end


always@(posedge clk_i or negedge SYNTHESIZED_WIRE_21)
begin
if (!SYNTHESIZED_WIRE_21)
	begin
	crc[8] <= 0;
	end
else
	begin
	crc[8] <= crc[7];
	end
end


always@(posedge clk_i or negedge SYNTHESIZED_WIRE_21)
begin
if (!SYNTHESIZED_WIRE_21)
	begin
	crc[9] <= 0;
	end
else
	begin
	crc[9] <= crc[8];
	end
end


always@(posedge clk_i or negedge SYNTHESIZED_WIRE_21)
begin
if (!SYNTHESIZED_WIRE_21)
	begin
	crc[10] <= 0;
	end
else
	begin
	crc[10] <= crc[9];
	end
end


always@(posedge clk_i or negedge SYNTHESIZED_WIRE_21)
begin
if (!SYNTHESIZED_WIRE_21)
	begin
	crc[11] <= 0;
	end
else
	begin
	crc[11] <= crc[10];
	end
end


always@(posedge clk_i or negedge SYNTHESIZED_WIRE_21)
begin
if (!SYNTHESIZED_WIRE_21)
	begin
	crc[12] <= 0;
	end
else
	begin
	crc[12] <= crc[11];
	end
end


always@(posedge clk_i or negedge SYNTHESIZED_WIRE_21)
begin
if (!SYNTHESIZED_WIRE_21)
	begin
	crc[13] <= 0;
	end
else
	begin
	crc[13] <= crc[12];
	end
end


always@(posedge clk_i or negedge SYNTHESIZED_WIRE_21)
begin
if (!SYNTHESIZED_WIRE_21)
	begin
	crc[14] <= 0;
	end
else
	begin
	crc[14] <= crc[13];
	end
end


always@(posedge clk_i or negedge SYNTHESIZED_WIRE_21)
begin
if (!SYNTHESIZED_WIRE_21)
	begin
	crc[15] <= 0;
	end
else
	begin
	crc[15] <= SYNTHESIZED_WIRE_18;
	end
end

assign	SYNTHESIZED_WIRE_22 = crc[15] ^ data_i;

assign	SYNTHESIZED_WIRE_18 = SYNTHESIZED_WIRE_22 ^ crc[14];

assign	SYNTHESIZED_WIRE_4 = SYNTHESIZED_WIRE_22 ^ crc[1];

assign	crc_o = crc;

endmodule
