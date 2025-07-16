`timescale 1ps/1ns

module PISO(clk,rst,load,shift,data_in,data_out,count);
	input load,shift,clk;
	input [7:0]data_in;
	output reg data_out;
	output reg [3:0] count;
	
	reg [7:0] store;
	
	always @(posedge clk)
		begin
			if(rst) begin
				store   <= data_in;
				data_out<= 0;
				count   <= 0;
			end
			else begin
				if(load == 1 && shift == 0) begin
					store   <= data_in;
					data_out<= 0;
					count   <= 0;
				end
				else if(load == 0 && shift == 1) begin
					if(count == 8) begin
						data_out <= 0;
						store    <= 0;
						count    <= 0;
					end
					else begin
						data_out <= store[0];
						store    <= store>>1;
						count    <= count + 1;
					end
				end
				else if(load == 0 && shift == 0)begin
					store   <= 0;
					count   <= 0;
					data_out<= 0;
					$display("Work Done");
				end
			end
		end

endmodule