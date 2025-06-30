`timescale 1ns / 1ps

module Control_Unit(clk, rst,enfetch,endecode,enregrd,enregwr,enalu,enmem);
	//Input and Output Declaration
	input clk,rst;
	output enfetch,endecode,enregrd,enregwr,enalu,enmem;
	
	reg [2:0] state;
	//State Declaration
	parameter FETCH  = 3'b000,
		      DECODE = 3'b001,
			  REGRD  = 3'b010,
			  ALU    = 3'b011,
			  REGWR  = 3'b100,
			  MEM    = 3'b101;
	initial 
		begin
			state <= FETCH;
		end
	always @(posedge clk)
		begin
			if (rst)
				state <= FETCH;
			else begin
				case(state)
					FETCH : state <= DECODE;
					DECODE: state <= REGRD;
					REGRD : state <= ALU;
					ALU   : state <= REGWR;
					REGWR : state <= MEM;
					MEM   : state <= FETCH;
				endcase
			end
		end
	
	assign enfetch  = (state == FETCH);
	assign endecode = (state == DECODE);
	assign enregrd  = (state == REGRD | state == REGWR);
	assign enregwr  = (state == REGWR);
	assign enalu    = (state == ALU);
	assign enmem    = (state == MEM);

endmodule
