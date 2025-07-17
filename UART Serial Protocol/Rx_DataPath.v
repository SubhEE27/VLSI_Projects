`timescale 1ns/1ps

module rx_datapath(clock,reset,par_load,par_check,par_gen,start_check,stop_check,data_shift,sipo_count,start_bit,data_in,parity,stop_bit,rx_out,sipo_out);
	input clock,reset,par_load,par_gen,start_bit,stop_bit,data_shift,parity,data_in;
	output wire [3:0]sipo_count;
	output wire [7:0]sipo_out;
	output reg  [7:0]rx_out;
	output reg par_check,start_check,stop_check;
	
	reg [7:0]par_store;
	
	SIPO S1(clock,reset,data_in,sipo_out,data_shift,sipo_count);
	
	always @(posedge clock or posedge reset)
		begin
			if(reset) begin
				par_check   <= 0;
				start_check <= 0;
				stop_check  <= 0;
				par_store   <= 0;
				rx_out      <= 0;
			end
			else begin
				if(start_bit == 0)
					start_check <= 1;
				else 
					start_check <= 0;
				if(stop_bit == 1) begin
					stop_check <= 1;
					rx_out     <= sipo_out;
				end
				else begin
					stop_check <= 0;
					rx_out     <= 0;
				end
				if(par_load == 1) begin
					par_store <= sipo_out;           //will be overwritten on arrival of new data
				end
				if(par_gen == 1) begin
					if((^par_store) == parity)
						par_check <= 1;
					else
						par_check <= 0;
				end
				else begin
					par_check  <= 0;
				end
			end	
		end

endmodule