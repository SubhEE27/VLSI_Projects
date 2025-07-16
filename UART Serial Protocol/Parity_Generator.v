`timescale 1ns/1ps

module parity_bit(clk,rst,data_in,load,parity,signal);
	input [7:0] data_in;
	input load,signal,clk;
	
	output reg parity;
	
	reg[7:0] store;
	
	always @(posedge clk or posedge rst)
		begin
			if (rst) begin
				store  <= 0;
				parity <= 0;
			end
			else begin
				if(load == 1 && signal == 0) begin
					store  <= data_in;
					parity <= 0;
				end
				else if(load == 0 && signal == 1) begin       //even parity if odd ones output is 1 otherwise if even ones output is 0
					parity <= ^store;
				end
				else if(load == 0 && signal == 0) begin
					parity <= 0;
					store  <= 0;
				end
			end
		end

endmodule