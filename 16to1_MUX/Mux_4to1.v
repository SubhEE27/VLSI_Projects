`timescale 1ns/1ps

module mux_4to1(a,b,c,d,sel1,sel0,out);
    input wire a,b,c,d,sel1,sel0;
    output wire out;
	wire wire1,wire2;
	
	mux_2to1 M1(a,b,sel0,wire1);
	mux_2to1 M2(c,d,sel0,wire2);
	mux_2to1 M3(wire1,wire2,sel1,out);
endmodule