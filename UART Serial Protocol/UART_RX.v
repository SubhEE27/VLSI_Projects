`timescale 1ns/1ps

module uart_rx(clock,reset,start_bit,stop_bit,data_in,parity,rx_out);
	
	input clock,reset,start_bit,stop_bit,data_in,parity;
	output wire [7:0]rx_out; 
	
	wire tx_signal, rx_start, rx_data_signal;
	wire data_shift,par_load,par_gen;
	wire [3:0]sipo_count;
	wire [7:0]sipo_out;
	wire par_check,start_check,stop_check;
	
	baud_rate_9600 B2(clock,reset,tx_signal,rx_start,rx_data_signal);
	rx_datapath    R1(clock,reset,par_load,par_check,par_gen,start_check,stop_check,data_shift,sipo_count,start_bit,data_in,parity,stop_bit,rx_out,sipo_out);
	rx_controlpath R2(clock,reset,rx_start,rx_data_signal,par_load,par_check,par_gen,start_check,stop_check,data_shift,sipo_count);
	
endmodule