`timescale 1ns/1ps

module rx_controlpath(clock,reset,rx_start,rx_data_signal,par_load,par_check,par_gen,start_check,stop_check,data_shift,sipo_count); //sipo_count from SIPO in data path
	input clock,reset,rx_start,rx_data_signal,par_check,stop_check,start_check;
	input [3:0] sipo_count;                                                     //par_check is signal from Rx_DataPath if parity given by Tx is matching or not
	output reg data_shift,par_load,par_gen;
	
	reg [2:0] next_state, present_state;
	
	parameter IDLE_State   = 3'b000,
		      Data_RxState = 3'b001, 
			  Parity_Load  = 3'b010,
			  Parity_Comp  = 3'b011,
			  Stop_State   = 3'b100;
	
	always @(posedge clock or posedge reset)
		begin
			if(reset) begin
				data_shift    <= 0;
				par_load      <= 0;
				par_gen       <= 0;
				present_state <= IDLE_State;
			end
			else begin
				present_state <= next_state;
			end
		end
		
	always @(*)
		begin
			case(present_state) 
				IDLE_State : begin
					if(start_check == 1 && rx_start == 1)
						next_state = Data_RxState;
					else 
						next_state = IDLE_State;
				end
				Data_RxState : begin
					if(sipo_count == 8 && rx_data_signal == 1)
						next_state = Parity_State;
					else 
						next_state = Data_RxState;
				end
				Parity_Load : begin
					if(rx_data_signal == 1)
						next_state = Parity_Comp;
					else 
						next_state = Parity_Load;
				end
				Parity_Comp : begin
					if(par_check == 1 && rx_data_signal == 1)
						next_state = Stop_State;
					else if(par_check == 0 && rx_data_signal == 1)
						next_state = IDLE_State;
					else 
						next_state = Parity_Comp;
				end
				Stop_State : begin
					if(stop_check == 1 && rx_data_signal == 1)          //if stop check is 0 no output will be given from receiver rx_out will be 0
						next_state = IDLE_State;
					else
						next_state = IDLE_State;
				end
				default : begin
					next_state = IDLE_State;
				end
			endcase
		end
		
	always @(*)
		begin
			data_shift = 0;
			par_load   = 0;
			par_gen    = 0;
			case(present_state)
				IDLE_State : begin
					data_shift = 0;
					par_load   = 0;
				end
				Data_RxState : begin
					data_shift = 1;
				end
				Parity_Load : begin
					par_load  = 1;
				end
				Parity_Comp : begin
					par_gen = 1;
				end
				Stop_State : begin
					par_load  = 0;
				end
				default : begin
					data_shift = 0;
					par_load   = 0;
				end
			endcase
		end
		
endmodule