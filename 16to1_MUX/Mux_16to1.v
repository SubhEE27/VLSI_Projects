`timescale 1ns/1ps

module mux_16to1_8(a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,sel3,sel2,sel1,sel0,out);
    input wire a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,sel3,sel2,sel1,sel0;
    output wire out;
	wire wire1,wire2;
	
	mux_8to1 M1(a,b,c,d,e,f,g,h,sel2,sel1,sel0,wire1);
	mux_8to1 M2(i,j,k,l,m,n,o,p,sel2,sel1,sel0,wire2);
	mux_2to1 M3(wire1,wire2,sel3,out);
endmodule