`timescale 1ns/1ps

module full_adder(N1,N2,Cin,sum,Cout);
	input wire N1,N2;
	input wire Cin;
	output wire sum;
	output wire Cout;
	
	wire p;
	wire r,s;
	
	half_adder H1(N1,N2,p,r);
	half_adder H2(p,Cin,sum,s);
	assign Cout = s | r;
endmodule
