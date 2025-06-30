`timescale 1ns / 1ps

module Instr_DecodeTB;
	reg        clock, enable;
	reg  [15:0]instr;
	wire [2:0] readreg1, readreg2;
	wire [2:0] writereg;
	wire [4:0] aluopcode;
	wire [8:0] imme;
	wire       regen;
	
	Instruction_decode I1(clock,enable,instr,readreg1,readreg2,writereg,regen,aluopcode,imme);
	
	always #5 clock = ~clock;
	
	initial
		begin
			clock  <= 0;
			enable <= 0;
			instr  <= 0;
			
			#10 instr  <= 16'b01010111100010111;
			#10 enable <= 1;
			
			#40 enable <= 0;
			#10 instr  <= 16'b1010001110101101;
			#10 enable <= 1;
			
			#40 enable <= 0;
			
			#100 $finish;
		end
endmodule
