`timescale 1ns / 1ps

module PC_unit(clk, counter, pc_in, pc_out);
	input             clk;
	input      [1:0]  counter;
	input      [15:0] pc_in;
	output reg [15:0] pc_out;
	
	initial
		pc_out <= 0;
	
	always@(posedge clk)
		begin
			case(counter)
				2'b00 : pc_out <= pc_out;
				2'b01 : pc_out <= pc_out + 1;    //Normal Operation
				2'b10 : pc_out <= pc_in;         //Jump to a Specific location or specific set of instructions depending on the input may be a register value or immediate 
				2'b11 : pc_out <= 0;
			endcase
		end
endmodule
