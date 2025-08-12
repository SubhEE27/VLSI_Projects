`timescale 1ns/1ps

module half_adder(A,B,sum,carry);
	input wire A,B;
	output reg sum;
	output reg carry;
	
	always @(*)
		begin
			sum   = A^B;
			carry = A&B;
		end
endmodule
