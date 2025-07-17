`timescale 1ns/1ps

module rx_controlpath(clock,reset,rx_signal,start_bit,stop_bit,par_load,par_check,data_load,data_shift,sipo_count); //sipo_count from SIPO in data path
	input clock,reset,rx_signal,par_check,start_bit,stop_bit;
	input [3:0] sipo_count;   //par_check is signal from Rx_DataPath if parity given by Tx is matching or not
	output reg data_shift,par_load,data_load;
	
	reg [3:0] no_tick,next_no_tick;                     // number of baud ticks
	reg [1:0] next_state, present_state;
	
	parameter IDLE_State   = 2'b00,
		      Data_RxState = 2'b01,
			  Parity_State = 2'b10,
			  Stop_State   = 2'b11;
	
	always @(posedge clock or posedge reset)
		begin
			if(reset) begin
				data_shift    <= 0;
				data_load     <= 0;
				par_load      <= 0;
				no_tick       <= 0;
				present_state <= IDLE_State;
			end
			else begin
				present_state <= next_state;
				no_tick       <= next_no_tick;
			end
		end
	
	always @(*)
		begin
		next_no_tick = 0;
		next_state   = present_state;
			case(present_state)
				IDLE_State : begin
					if(start_bit == 0) begin
						if(rx_signal == 1 && no_tick == 7) begin
							next_state    = Data_RxState;
							next_no_tick  = 0;
						end
						else if(rx_signal == 1 && no_tick != 7) begin
							next_state = IDLE_State;
							next_no_tick   = no_tick + 1;
						end
						else begin
							next_state = IDLE_State;
							next_no_tick   = 0;
						end
					end
					else begin
						next_state = IDLE_State;
					end
				end
				Data_RxState : begin
					if(rx_signal) begin
						if(no_tick == 15) begin
							next_no_tick = 0;
						end
						else begin
							next_no_tick = no_tick + 1;
						end	
					end
					else begin
						next_no_tick = 0;
					end
					
                    if(sipo_count == 8) begin
						next_state = Parity_State;
					end
					else begin
						next_state = Data_RxState;
					end
				end
				Parity_State : begin
					if(rx_signal) begin
						if(no_tick == 15) begin
							next_no_tick = 0;
						end
						else begin
							next_no_tick = no_tick + 1;
						end
						if(par_check)
							next_state = Stop_State;
						else 
							next_state = IDLE_State;
					end
					else begin
						next_no_tick = 0;
						next_state = Parity_State;
					end	
				end
				Stop_State : begin
					if(stop_bit) begin
						if(rx_signal == 1 && no_tick == 15) begin
							next_state = IDLE_State;
							next_no_tick   = 0;
						end
						else if(rx_signal == 1 && no_tick != 15) begin
							next_state = Stop_State;
							next_no_tick   = no_tick + 1;
						end
						else begin
							next_state = Stop_State;
							next_no_tick   = 0;
						end
					end
					else begin
						next_state = Stop_State;
					end
				end
				default : begin
					next_state = IDLE_State;
					next_no_tick = 0;
				end
			endcase
		end

	always @(*)
		begin
			data_shift = 0;
			data_load  = 0;
			par_load   = 0;
			case(present_state)
				IDLE_State : begin
					data_shift = 0;
					data_load  = 0;
					par_load   = 0;
				end
				Data_RxState : begin
					if(rx_signal) begin
						if(no_tick == 15) begin
							data_shift = 1;
						end
						else begin
							data_shift = 0;
						end	
					end
					else begin
						data_shift = 0;
					end
				end
				Parity_State : begin
					if(rx_signal) begin
						if(no_tick == 15) begin
							data_load = 1;
							par_load  = 1;       //after data is converted from serial to parallel then it will be load to parity checker and check if the parity bit from tx is matching or not
						end
						else begin
							data_load = 0;
							par_load  = 0;
						end
					end
					else begin
						data_load = 0;
						par_load  = 0;
					end	
				end
				Stop_State : begin
					data_shift = 0;
					data_load  = 0;
					par_load   = 0;
				end
				default : begin
					data_shift = 0;
					data_load  = 0;
					par_load   = 0;
				end
			endcase
		end
endmodule  