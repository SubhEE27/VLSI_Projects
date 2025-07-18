`timescale 1ns/1ps

module rx_datapath_dmux(clock,reset,par_load,par_check,par_gen,start_check,stop_check,data_shift,sipo_count,tx_in,rx_out,sipo_out,selC,selD);
	input clock,reset,par_load,par_gen,data_shift,tx_in,selC,selD;
	output wire [3:0]sipo_count;
	output reg  [7:0]rx_out;
	output reg par_check,start_check,stop_check;
	output wire[7:0]sipo_out;
	wire outA,outB,outC,outD;
	
	reg [7:0]par_store;
	
	SIPO S1(clock,reset,outB,sipo_out,data_shift,sipo_count);
	demux1to4(selC,selD,outA,outB,outC,outD,tx_in);
	
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
				if(selC == 0 && selD == 0 && outA == 0)
					start_check <= 1;
				else 
					start_check <= 0;
				if(selC == 1 && selD == 1 && outD == 1) begin
					stop_check <= 1;
					rx_out     <= sipo_out;
				end
				else begin
					stop_check <= 0;
					rx_out     <= 0;
				end
				if(par_load == 1) begin
					par_store <= sipo_out;                               //will be overwritten on arrival of new data
				end
				if(par_gen == 1 && selC == 1 && selD == 0) begin
					if((^par_store) == outC)
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