`timescale 1ns/1ps

module adder_test;
	reg a,b,cin;
	wire sum,cout;
	
	full_adder F1(a,b,cin,sum,cout);
	
	initial begin
		a   = 0;
		b   = 0;
		cin = 0;
		
		#10;
		a   = 0;
		b   = 0;
		cin = 1;
		
		#10;
		a   = 0;
		b   = 1;
		cin = 0;
		
		#10;
		a   = 0;
		b   = 1;
		cin = 1;
		
		#10;
		a   = 1;
		b   = 0;
		cin = 0;
		
		#10;
		a   = 1;
		b   = 0;
		cin = 1;
		
		#10;
		a   = 1;
		b   = 1;
		cin = 0;
		
		#10;
		a   = 1;
		b   = 1;
		cin = 1;
	end
endmodule
