`timescale 1ns / 1ps

module Instruction_decode(clk,en,instr,readreg1,readreg2,writereg,regen,aluopcode,imme);
	// Input Declaration
	input en,clk;
	input      [15:0]instr;
	// Output Declaration
	output reg [2:0]readreg1, readreg2;
	output reg [2:0]writereg;
	output reg [4:0]aluopcode;
	output reg [8:0] imme;
	output reg regen;
	
	initial
		begin
			readreg1 <= 0;
			readreg2 <= 0;
			writereg <= 0;
			regen    <= 0;
			imme     <= 0;
			aluopcode<= 0;
		end
	always @(negedge clk)
		begin
			if(en) begin
				readreg1 <= instr[4:2];
				readreg2 <= instr[7:5];
				aluopcode<= instr[15:11];
				imme     <= instr[7:0];
				writereg <= instr[10:8];
				
				case(instr[15:12])           //these opcodes are not availalble in the chart so they are disabled if encountered also they cannot write anything to reg
					4'b0111: regen <= 0;
					4'b1100: regen <= 0;
					4'b1101: regen <= 0;
					default: regen <= 1;
				endcase
			end
		end
endmodule
