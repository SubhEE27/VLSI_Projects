`timescale 1ns / 1ps

module main_test;
	
	reg clk,rst;
	reg [15:0]data_in = 0;
	reg wenable = 0;
	
	wire [2:0] readreg1;
	wire [2:0] readreg2;
	wire [2:0] writereg;
	wire [4:0] aluopcode;
	wire [8:0] imme;
	wire [15:0]data_A;
	wire [15:0]data_B;
	wire [17:0]data_result;
	wire [15:0]data_out;
	wire [1:0] counter;
	wire [15:0]pc_out;
	wire enfetch,endecode,enregrd,enregwr,enalu,enmem;
	wire shldBranch;
	wire update;
	wire regen;
	
	Instruction_decode main_instr (clk,endecode,data_out,readreg1,readreg2,writereg,regen,aluopcode,imme);   //data read from memory acting as instruction to be decoded
	Control_Unit main_ctrl (clk, rst,enfetch,endecode,enregrd,update,enalu,enmem);
	ALU_OP main_alu (clk,enalu,aluopcode,imme,data_A,data_B,data_result,shldBranch);
	PC_unit main_PC (clk, counter, data_result, pc_out);
	Reg_File main_reg (clk,enregrd,enregwr,readreg1,readreg2, writereg, data_A, data_B, data_result);
	memory main_memory (clk, wenable, pc_out, data_in, data_out);                                     //address is from program counter output
	
	assign enregwr = regen & update ;
	assign counter = (rst) ? 2'b11 : ((shldBranch) ? 2'b10 : ((enalu) ? 2'b01 : 2'b00));      // if reset then 0 if branching should happen then jump to pc_in otherise if memory is high then update normally or else remains same
	
	always #5 clk = ~clk;
	
	initial
		begin
			clk = 0;
			rst = 1;
			
			#20 rst = 0;
			main_reg.registers[1] = 16'd5;
            main_reg.registers[2] = 16'd3;
			//#800 $finish;
		end
endmodule
