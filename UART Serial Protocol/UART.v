`timescale 1ns/1ps 

module uart(clock,reset,start,data_in,rx_out);
	
	input clock,reset,start;
	input [7:0]data_in;
	output wire rx_out; 
	
	wire tx_signal, rx_start, rx_data_signal;       //outputs of baud generator
    wire load, shift, par_signal,selA,selB,start_bit,stop_bit,data_out,parity,tx_out;
    wire [3:0]counter;
    wire par_load, par_check, par_gen,start_check, stop_check, data_load, data_shift;
    wire [3:0] sipo_count;
    wire [7:0] sipo_out;
	
	baud_rate_9600 BG(clock,reset,tx_signal,rx_start,rx_data_signal);
	tx_datapath    TD(clock,reset,load,shift,counter,par_signal,selA,selB,start_bit,stop_bit,data_in,data_out,parity,tx_out);
	tx_controlpath TC(clock,reset,start,load,shift,counter,par_signal,selA,selB,start_bit,stop_bit,tx_signal);
	rx_datapath    RD(clock,reset,par_load,par_check,par_gen,start_check,stop_check,data_load,data_shift,sipo_count,tx_out,tx_out,tx_out,tx_out,rx_out,sipo_out);
	rx_controlpath RC(clock,reset,rx_start,rx_data_signal,par_load,par_check,par_gen,start_check,stop_check,data_shift,sipo_count);

endmodule