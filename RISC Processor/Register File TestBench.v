`timescale 1ns / 1ps

module Reg_FileTb;
	
	/*1)Read r0 and r1, Write 0xFFFF to r0
	  2)Ensure 0xFFFF appears on data out line, Write 0x2222 to r2
	  3)Write 0x3333 to r2 ,Testing multiple write to same location
	  4)Set up as the writing 0xFEED to r0 but don't enable regenable
	  5)Write 0x4444 to r4, Ensure 0xFEED was not written to r0
	  6)After waiting multiple clock cycles, Read r4 on both output A and B */
	
	reg        clock,enable,regenable;
	reg  [2:0] readreg1,readreg2,writereg;
	reg  [15:0]data_result;
	wire [15:0]data_A, data_B;
	
	Reg_File R1(clock,enable,regenable,readreg1,readreg2, writereg, data_A, data_B, data_result);
	
	always #5 clock = ~clock;
	
	initial
		begin
			clock       <= 0;
			enable      <= 0;
			regenable   <= 0;
			readreg1    <= 0;
			readreg2    <= 0;
			writereg    <= 0;
			data_result <= 0;
			
	    //Step1		
			#7;                                                     //As This module is operating in Negative Edge
			enable      <= 1;
			readreg1    <= 3'b000;                                  //Each register file address is 3 bit long as decided from the instruction set
			readreg2    <= 3'b001;
			data_result <= 16'hFFFF;
			writereg    <= 3'b000;
			regenable   <= 1;
			
		//Step2
			#10;
			regenable   <= 0;
			data_result <= 16'h2222;
			writereg    <= 3'b010;
			
		//Step2
			#10;
			regenable <= 1;
			
		//Step3
			#10;
			data_result <= 16'h3333;
			writereg    <= 3'b010;
			
		//Step4
			#10;
			regenable   <= 0;
			data_result <= 16'hFEED;
			writereg    <= 3'b000;
			
		//Step5
			#10;
			data_result <= 16'h4444;
			writereg    <= 3'b100;
			#10;
			regenable   <= 1;
		
		//Step6
			#50;
			regenable <= 0;
			readreg1  <= 3'b100;
			readreg2  <= 3'b100;
			
			#130 $finish;
		end
endmodule
