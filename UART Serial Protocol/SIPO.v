`timescale 1ns/1ps

module SIPO(clk,rst,data_in,sipo_out,data_shift,sipo_count);
	input clk,rst,data_in,data_shift;
	output reg [7:0]sipo_out;
	output reg [3:0]sipo_count;
	
	reg [7:0] data_store;
	
	always @(posedge clk or posedge rst)
		begin
			if(rst) begin
				sipo_out   <= 0;
				sipo_count <= 0;
				data_store <= 0;
			end
			else begin
				if (data_shift) begin
					data_store <= {data_store[6:0], data_in};
					if (sipo_count == 7) begin
						sipo_out   <= {data_store[6:0], data_in};  // Final byte assembled
						sipo_count <= 0;                           // Reset for next byte
					end 
					else begin
						sipo_count <= sipo_count + 1;
					end
				end
			end
		end
	
endmodule