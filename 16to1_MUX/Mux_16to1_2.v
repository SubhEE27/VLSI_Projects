`timescale 1ns/1ps

module mux_16to1_4(a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,sel3,sel2,sel1,sel0,out);
    input wire a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,sel3,sel2,sel1,sel0;
    output wire out;
	wire wire1,wire2,wire3,wire4;
	
	mux_4to1 M1(a,b,c,d,sel1,sel0,wire1);
	mux_4to1 M2(e,f,g,h,sel1,sel0,wire2);
	mux_4to1 M3(i,j,k,l,sel1,sel0,wire3);
	mux_4to1 M4(m,n,o,p,sel1,sel0,wire4);
	mux_4to1 M5(wire1,wire2,wire3,wire4,sel3,sel2,out);
endmodule