`timescale 1ns/1ps

module mux4to1(selA,selB,inA,inB,inC,inD,out);
	input selA,selB;
	input inA,inB,inC,inD;
	output reg out;
	
	always @(*)
		begin
			case({selA,selB})
				2'b00:   out = inA;
				2'b01:   out = inB;
				2'b10:   out = inC;
				2'b11:   out = inD;
				default: out = 1;
			endcase
		end

endmodule