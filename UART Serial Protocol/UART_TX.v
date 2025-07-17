`timescale 1ns/1ps

module uart_tx(clock,reset,start,data_in,start_bit,stop_bit,parity,tx_out);
	
	input clock,reset,start;
	input [7:0]data_in;
	output wire start_bit,stop_bit,parity,tx_out;
	
	wire tx_signal, rx_start, rx_data_signal;
	wire load,shift,par_signal,selA,selB;
	wire [3:0] counter;
	wire data_out;
	
	baud_rate_9600 B1(clock,reset,tx_signal,rx_start,rx_data_signal);
	tx_controlpath T1(clock,reset,start,load,shift,counter,par_signal,selA,selB,start_bit,stop_bit,tx_signal);
	tx_datapath    T2(clock,reset,load,shift,counter,par_signal,selA,selB,start_bit,stop_bit,data_in,data_out,parity,tx_out);

endmodule