`timescale 1ns/1ps

module test_uart;
	reg clock,reset,start;
	reg [7:0]data_in;
	wire rx_out;
	
	uart U1(clock,reset,start,data_in,rx_out);
	
	initial
		begin
			clock   <= 0;
			reset   <= 1;
			start   <= 0;
			data_in <= 8'b00000000;
			
			#20 reset <= 0;
			
			#20 data_in <= 8'b10111010;
			    start   <= 1;
			
			#100 start <= 0;
			
			#1150000 $finish;
		end
	
	always #5 clock = ~clock;
	
endmodule