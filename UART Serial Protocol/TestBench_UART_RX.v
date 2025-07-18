`timescale 1ns/1ps

module test_uartrx;
	reg clock,reset,start_bit,stop_bit,data_in,parity;
	wire [7:0]rx_out;
	
	uart_rx RX(clock,reset,start_bit,stop_bit,data_in,parity,rx_out);
	
	initial
		begin
			clock     <= 0;
			reset     <= 1;
			start_bit <= 1;
			stop_bit  <= 0;
			data_in   <= 0;
			parity    <= 1;
			
			#20 reset <= 0;
			
			#80 start_bit <= 0;
			
			#80 data_in <= 1;
			#80 data_in <= 0;
			#80 data_in <= 1;
			#80 data_in <= 1;
			#80 data_in <= 0;
			#80 data_in <= 1;
			#80 data_in <= 1;
			#80 data_in <= 1;
			
			#80 parity  <= 0;
			#80 stop_bit<= 1;
			
			#1500 $finish;
		end
	
	always #5 clock = ~clock;
	
endmodule