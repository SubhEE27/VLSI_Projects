`timescale 1ns / 1ps

module Reg_File(clk,en,regen,readreg1,readreg2, writereg, data_A, data_B, data_result);
	input            clk,en,regen;
	input      [2:0] readreg1,readreg2,writereg;
	input      [15:0] data_result;
	output reg [15:0]data_A, data_B;
	
	reg [15:0] registers [7:0];
	integer i;                     // 8 registers each with storing capacity of 16 bits
	
	initial
		begin
			data_A      = 0;
			data_B      = 0;
			for (i=0; i<8; i=i+1)
				registers[i] <= 0;                  // initially all register values are set to zero
		end
	always @(negedge clk) 
		begin
			if(en) begin
				data_A <= registers[readreg1];            //read the value of register with address of readreg1 and store in data_A
				data_B <= registers[readreg2];            //read the value of register with address of readreg2 and store in data_B
				if(regen)
					registers[writereg] <= data_result;   //write the value of the variable data_result into register with address writereg
			end
		end
endmodule
