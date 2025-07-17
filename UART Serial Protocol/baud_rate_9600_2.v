`timescale 1ns/1ps

module baud_rate_9600(clk,rst,tx_signal,rx_start,rx_data_signal);
	input clk,rst;
	output reg tx_signal, rx_start, rx_data_signal;
	
	reg rx_tick;
	reg[15:0] cycles_tx, cycles_rx;
	reg[3:0]  cycles_rxstart, cycles_rxdata;
	
	always @(posedge clk or posedge rst)
		begin
			if(rst) begin
				cycles_tx      <= 0;
				cycles_rx      <= 0;
				tx_signal      <= 0;                   //transmitter signal
				rx_tick        <= 0;
				rx_start       <= 0;
				rx_data_signal <= 0;                   //receivier signal
				cycles_rxstart <= 0;
				cycles_rxdata  <= 0;
			end
			
			else begin
				if(cycles_tx == 10416) begin      //from 0 to 10416 = 10417 counts 100 MHz clock period with 9600 baud rate
					tx_signal <= 1;
					cycles_tx <= 0;
				end
				else begin
					tx_signal <= 0;
					cycles_tx <= cycles_tx + 1;
				end
				
				if(cycles_rx == 650) begin       //from 0 to 650 = 651 counts 100 Mhz clock period with 16x oversampling for 9600 baud rate
					rx_tick <= 1;
					cycles_rx <= 0;
				end
				else begin
					rx_tick <= 0;
					cycles_rx <= cycles_rx + 1;
				end
				if(rx_tick) begin
					if(cycles_rxstart == 7) begin
						rx_start       <= 1;
						cycles_rxstart <= 0;
					end
					else begin
						rx_start       <= 0;
						cycles_rxstart <= cycles_rxstart + 1;
					end
					if(cycles_rxdata == 15) begin
						rx_data_signal <= 1;
						cycles_rxdata  <= 0;
					end
					else begin
						rx_data_signal <= 0;
						cycles_rxdata  <= cycles_rxdata + 1;
					end
				end
				else begin
					rx_start       <= 0;
					rx_data_signal <= 0;
				end
			end	
		end
		
endmodule