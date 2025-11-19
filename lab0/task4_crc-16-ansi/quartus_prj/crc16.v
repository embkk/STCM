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
// CREATED		"Wed Nov 19 08:22:17 2025"

module crc16(
	clk_i,
	rst_i,
	data_i,
	crc2_o,
	crc_o
);


input wire	clk_i;
input wire	rst_i;
input wire	data_i;
output wire	[15:0] crc2_o;
output wire	[15:0] crc_o;

reg	crc0;
reg	crc1;
reg	crc10;
reg	crc11;
reg	crc12;
reg	crc13;
reg	crc14;
reg	crc15;
reg	crc2;
wire	crc20;
wire	crc21;
wire	crc210;
wire	crc211;
wire	crc212;
wire	crc213;
wire	crc214;
wire	crc215;
wire	crc22;
wire	crc23;
wire	crc24;
wire	crc25;
wire	crc26;
wire	crc27;
wire	crc28;
wire	crc29;
reg	crc3;
reg	crc4;
reg	crc5;
reg	crc6;
reg	crc7;
reg	crc8;
reg	crc9;
wire	SYNTHESIZED_WIRE_21;
wire	SYNTHESIZED_WIRE_22;
wire	SYNTHESIZED_WIRE_4;
wire	SYNTHESIZED_WIRE_18;

wire	[15:0] GDFX_TEMP_SIGNAL_1;
wire	[15:0] GDFX_TEMP_SIGNAL_0;


assign	crc215 = GDFX_TEMP_SIGNAL_1[15];
assign	crc214 = GDFX_TEMP_SIGNAL_1[14];
assign	crc213 = GDFX_TEMP_SIGNAL_1[13];
assign	crc212 = GDFX_TEMP_SIGNAL_1[12];
assign	crc211 = GDFX_TEMP_SIGNAL_1[11];
assign	crc210 = GDFX_TEMP_SIGNAL_1[10];
assign	crc29 = GDFX_TEMP_SIGNAL_1[9];
assign	crc28 = GDFX_TEMP_SIGNAL_1[8];
assign	crc27 = GDFX_TEMP_SIGNAL_1[7];
assign	crc26 = GDFX_TEMP_SIGNAL_1[6];
assign	crc25 = GDFX_TEMP_SIGNAL_1[5];
assign	crc24 = GDFX_TEMP_SIGNAL_1[4];
assign	crc23 = GDFX_TEMP_SIGNAL_1[3];
assign	crc22 = GDFX_TEMP_SIGNAL_1[2];
assign	crc21 = GDFX_TEMP_SIGNAL_1[1];
assign	crc20 = GDFX_TEMP_SIGNAL_1[0];

assign	GDFX_TEMP_SIGNAL_0 = {crc15,crc14,crc13,crc12,crc11,crc10,crc9,crc8,crc7,crc6,crc5,crc4,crc3,crc2,crc1,crc0};

assign	SYNTHESIZED_WIRE_21 =  ~rst_i;


bit_reverse_16	b2v_inst1(
	.data_in(GDFX_TEMP_SIGNAL_0),
	.data_out(GDFX_TEMP_SIGNAL_1));


always@(posedge clk_i or negedge SYNTHESIZED_WIRE_21)
begin
if (!SYNTHESIZED_WIRE_21)
	begin
	crc15 <= 0;
	end
else
	begin
	crc15 <= SYNTHESIZED_WIRE_22;
	end
end


always@(posedge clk_i or negedge SYNTHESIZED_WIRE_21)
begin
if (!SYNTHESIZED_WIRE_21)
	begin
	crc14 <= 0;
	end
else
	begin
	crc14 <= crc15;
	end
end


always@(posedge clk_i or negedge SYNTHESIZED_WIRE_21)
begin
if (!SYNTHESIZED_WIRE_21)
	begin
	crc13 <= 0;
	end
else
	begin
	crc13 <= SYNTHESIZED_WIRE_4;
	end
end


always@(posedge clk_i or negedge SYNTHESIZED_WIRE_21)
begin
if (!SYNTHESIZED_WIRE_21)
	begin
	crc12 <= 0;
	end
else
	begin
	crc12 <= crc13;
	end
end


always@(posedge clk_i or negedge SYNTHESIZED_WIRE_21)
begin
if (!SYNTHESIZED_WIRE_21)
	begin
	crc11 <= 0;
	end
else
	begin
	crc11 <= crc12;
	end
end


always@(posedge clk_i or negedge SYNTHESIZED_WIRE_21)
begin
if (!SYNTHESIZED_WIRE_21)
	begin
	crc10 <= 0;
	end
else
	begin
	crc10 <= crc11;
	end
end


always@(posedge clk_i or negedge SYNTHESIZED_WIRE_21)
begin
if (!SYNTHESIZED_WIRE_21)
	begin
	crc9 <= 0;
	end
else
	begin
	crc9 <= crc10;
	end
end


always@(posedge clk_i or negedge SYNTHESIZED_WIRE_21)
begin
if (!SYNTHESIZED_WIRE_21)
	begin
	crc8 <= 0;
	end
else
	begin
	crc8 <= crc9;
	end
end


always@(posedge clk_i or negedge SYNTHESIZED_WIRE_21)
begin
if (!SYNTHESIZED_WIRE_21)
	begin
	crc7 <= 0;
	end
else
	begin
	crc7 <= crc8;
	end
end


always@(posedge clk_i or negedge SYNTHESIZED_WIRE_21)
begin
if (!SYNTHESIZED_WIRE_21)
	begin
	crc6 <= 0;
	end
else
	begin
	crc6 <= crc7;
	end
end


always@(posedge clk_i or negedge SYNTHESIZED_WIRE_21)
begin
if (!SYNTHESIZED_WIRE_21)
	begin
	crc5 <= 0;
	end
else
	begin
	crc5 <= crc6;
	end
end


always@(posedge clk_i or negedge SYNTHESIZED_WIRE_21)
begin
if (!SYNTHESIZED_WIRE_21)
	begin
	crc4 <= 0;
	end
else
	begin
	crc4 <= crc5;
	end
end


always@(posedge clk_i or negedge SYNTHESIZED_WIRE_21)
begin
if (!SYNTHESIZED_WIRE_21)
	begin
	crc3 <= 0;
	end
else
	begin
	crc3 <= crc4;
	end
end


always@(posedge clk_i or negedge SYNTHESIZED_WIRE_21)
begin
if (!SYNTHESIZED_WIRE_21)
	begin
	crc2 <= 0;
	end
else
	begin
	crc2 <= crc3;
	end
end


always@(posedge clk_i or negedge SYNTHESIZED_WIRE_21)
begin
if (!SYNTHESIZED_WIRE_21)
	begin
	crc1 <= 0;
	end
else
	begin
	crc1 <= crc2;
	end
end


always@(posedge clk_i or negedge SYNTHESIZED_WIRE_21)
begin
if (!SYNTHESIZED_WIRE_21)
	begin
	crc0 <= 0;
	end
else
	begin
	crc0 <= SYNTHESIZED_WIRE_18;
	end
end

assign	SYNTHESIZED_WIRE_22 = crc0 ^ data_i;

assign	SYNTHESIZED_WIRE_18 = SYNTHESIZED_WIRE_22 ^ crc1;

assign	SYNTHESIZED_WIRE_4 = SYNTHESIZED_WIRE_22 ^ crc14;

assign	crc2_o[15] = crc215;
assign	crc2_o[14] = crc214;
assign	crc2_o[13] = crc213;
assign	crc2_o[12] = crc212;
assign	crc2_o[11] = crc211;
assign	crc2_o[10] = crc210;
assign	crc2_o[9] = crc29;
assign	crc2_o[8] = crc28;
assign	crc2_o[7] = crc27;
assign	crc2_o[6] = crc26;
assign	crc2_o[5] = crc25;
assign	crc2_o[4] = crc24;
assign	crc2_o[3] = crc23;
assign	crc2_o[2] = crc22;
assign	crc2_o[1] = crc21;
assign	crc2_o[0] = crc20;
assign	crc_o[15] = crc15;
assign	crc_o[14] = crc14;
assign	crc_o[13] = crc13;
assign	crc_o[12] = crc12;
assign	crc_o[11] = crc11;
assign	crc_o[10] = crc10;
assign	crc_o[9] = crc9;
assign	crc_o[8] = crc8;
assign	crc_o[7] = crc7;
assign	crc_o[6] = crc6;
assign	crc_o[5] = crc5;
assign	crc_o[4] = crc4;
assign	crc_o[3] = crc3;
assign	crc_o[2] = crc2;
assign	crc_o[1] = crc1;
assign	crc_o[0] = crc0;

endmodule
