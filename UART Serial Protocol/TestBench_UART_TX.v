`timescale 1ns/1ps

module test_uarttx;
	reg clock,reset,start;
	reg [7:0]data_in;
	wire start_bit,stop_bit,parity,tx_out;
	
	uart_tx TX(clock,reset,start,data_in,start_bit,stop_bit,parity,tx_out);
	
	initial
		begin
			clock   <= 0;
			reset   <= 1;
			start   <= 0;
			data_in <= 8'b00000000;
			
			#20 reset <= 0;
			
			#20 data_in <= 8'b10111001;
			    start   <= 1;
			
			#100 start <= 0;
			
			#2000 $finish;
		end
	
	always #5 clock = ~clock;
	
endmodule