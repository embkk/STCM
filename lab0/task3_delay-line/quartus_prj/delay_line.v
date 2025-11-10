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
// CREATED		"Mon Nov 10 18:06:10 2025"

module delay_line(
	clk_i,
	rst_i,
	data_i,
	data_delay_i,
	data_o
);


input wire	clk_i;
input wire	rst_i;
input wire	data_i;
input wire	[3:0] data_delay_i;
output wire	data_o;

reg	[15:0] data;
wire	SYNTHESIZED_WIRE_16;




assign	SYNTHESIZED_WIRE_16 =  ~rst_i;


always@(posedge clk_i or negedge SYNTHESIZED_WIRE_16)
begin
if (!SYNTHESIZED_WIRE_16)
	begin
	data[0] <= 0;
	end
else
	begin
	data[0] <= data_i;
	end
end


always@(posedge clk_i or negedge SYNTHESIZED_WIRE_16)
begin
if (!SYNTHESIZED_WIRE_16)
	begin
	data[1] <= 0;
	end
else
	begin
	data[1] <= data[0];
	end
end


always@(posedge clk_i or negedge SYNTHESIZED_WIRE_16)
begin
if (!SYNTHESIZED_WIRE_16)
	begin
	data[2] <= 0;
	end
else
	begin
	data[2] <= data[1];
	end
end


always@(posedge clk_i or negedge SYNTHESIZED_WIRE_16)
begin
if (!SYNTHESIZED_WIRE_16)
	begin
	data[3] <= 0;
	end
else
	begin
	data[3] <= data[2];
	end
end


always@(posedge clk_i or negedge SYNTHESIZED_WIRE_16)
begin
if (!SYNTHESIZED_WIRE_16)
	begin
	data[4] <= 0;
	end
else
	begin
	data[4] <= data[3];
	end
end


always@(posedge clk_i or negedge SYNTHESIZED_WIRE_16)
begin
if (!SYNTHESIZED_WIRE_16)
	begin
	data[5] <= 0;
	end
else
	begin
	data[5] <= data[4];
	end
end


always@(posedge clk_i or negedge SYNTHESIZED_WIRE_16)
begin
if (!SYNTHESIZED_WIRE_16)
	begin
	data[6] <= 0;
	end
else
	begin
	data[6] <= data[5];
	end
end


always@(posedge clk_i or negedge SYNTHESIZED_WIRE_16)
begin
if (!SYNTHESIZED_WIRE_16)
	begin
	data[7] <= 0;
	end
else
	begin
	data[7] <= data[6];
	end
end


always@(posedge clk_i or negedge SYNTHESIZED_WIRE_16)
begin
if (!SYNTHESIZED_WIRE_16)
	begin
	data[8] <= 0;
	end
else
	begin
	data[8] <= data[7];
	end
end


always@(posedge clk_i or negedge SYNTHESIZED_WIRE_16)
begin
if (!SYNTHESIZED_WIRE_16)
	begin
	data[9] <= 0;
	end
else
	begin
	data[9] <= data[8];
	end
end


always@(posedge clk_i or negedge SYNTHESIZED_WIRE_16)
begin
if (!SYNTHESIZED_WIRE_16)
	begin
	data[10] <= 0;
	end
else
	begin
	data[10] <= data[9];
	end
end


always@(posedge clk_i or negedge SYNTHESIZED_WIRE_16)
begin
if (!SYNTHESIZED_WIRE_16)
	begin
	data[11] <= 0;
	end
else
	begin
	data[11] <= data[10];
	end
end


always@(posedge clk_i or negedge SYNTHESIZED_WIRE_16)
begin
if (!SYNTHESIZED_WIRE_16)
	begin
	data[12] <= 0;
	end
else
	begin
	data[12] <= data[11];
	end
end


always@(posedge clk_i or negedge SYNTHESIZED_WIRE_16)
begin
if (!SYNTHESIZED_WIRE_16)
	begin
	data[13] <= 0;
	end
else
	begin
	data[13] <= data[12];
	end
end


always@(posedge clk_i or negedge SYNTHESIZED_WIRE_16)
begin
if (!SYNTHESIZED_WIRE_16)
	begin
	data[14] <= 0;
	end
else
	begin
	data[14] <= data[13];
	end
end


always@(posedge clk_i or negedge SYNTHESIZED_WIRE_16)
begin
if (!SYNTHESIZED_WIRE_16)
	begin
	data[15] <= 0;
	end
else
	begin
	data[15] <= data[14];
	end
end


mux_0	b2v_mux16(
	.data(data),
	.sel(data_delay_i),
	.result(data_o));


endmodule

module mux_0(data,sel,result);
/* synthesis black_box */

input [15:0] data;
input [3:0] sel;
output result;

endmodule
