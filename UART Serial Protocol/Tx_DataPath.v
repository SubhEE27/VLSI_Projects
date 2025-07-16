`timescale 1ns/1ps

module tx_datapath(clock,reset,load,shift,counter,par_signal,selA,selB,start_bit,stop_bit,data_in,data_out,parity,tx_out);
	
	input clock,reset,load,shift,par_signal,selA,selB,start_bit,stop_bit;
	input [7:0] data_in;
	output wire [3:0] counter;
	output wire data_out, parity,tx_out;
	
	mux4to1 M1(selA,selB,start_bit,data_out,parity,stop_bit,tx_out);
	PISO    P1(clock,reset,load,shift,data_in,data_out,counter);
	parity_bit PB1(clock,reset,data_in,load,parity,par_signal);
	
endmodule