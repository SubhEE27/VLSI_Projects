`timescale 1ns/1ps

module mux_2to1(a,b,sel,out);
	input wire a,b,sel;
	output wire out;
	
	assign out = sel?b:a;
endmodule
