`timescale 1ns/1ps

module tx_controlpath(clock,reset,start,load,shift,counter,par_signal,selA,selB,start_bit,stop_bit,tx_signal);
	input clock,reset,tx_signal,start;
	input [3:0]counter;
	output reg load,shift,par_signal,selA,selB,start_bit,stop_bit;
	
	reg [2:0] next_state,present_state;
	reg [3:0]data_stable;
	
	parameter IDLE_state   = 3'b000,
	          Data_Load    = 3'b001,
			  Start_State  = 3'b010,
			  Data_TxState = 3'b011,
			  Parity_State = 3'b100,
			  Stop_State   = 3'b101;
	
	always @(posedge clock or posedge reset)
		begin
			if(reset) begin
				load          <= 0;
				shift         <= 0;
				par_signal    <= 0;
				selA          <= 0;
				selB          <= 0;
				start_bit     <= 1;               //when high to low data transfer will begin
				stop_bit      <= 0;               //when low to high data transfer will stop
				data_stable   <= 0;
				present_state <= IDLE_state;
			end
			else begin
				present_state <= next_state;
				if(data_stable == 7)
				    data_stable <= 0;
				else 
				    data_stable <= data_stable + 1; 
			end
		end
	
	always @(*)
		begin
			case(present_state)
				IDLE_state : begin
					if(start && tx_signal)
						next_state = Data_Load;
					else
						next_state = IDLE_state;
				end
				Data_Load : begin
				    if(tx_signal)
				        next_state = Start_State;
				    else
				        next_state = Data_Load;
				end
				Start_State : begin
					if(tx_signal) begin
						next_state = Data_TxState;
					end
					else begin
						next_state = Start_State;
					end
				end
				Data_TxState : begin
					if(tx_signal == 1 && counter == 9) begin
						next_state = Parity_State;
					end
					else if(tx_signal == 1 && counter != 9)begin
						next_state = Data_TxState;
					end
					else begin
						next_state = Data_TxState;
					end
				end
				Parity_State : begin
					if(tx_signal) begin
						next_state = Stop_State;
					end
					else begin
						next_state = Parity_State;
					end
				end
				Stop_State : begin
					if(tx_signal) begin
						next_state = IDLE_state;
					end
					else begin
						next_state = Stop_State;
					end
				end
				default : begin
					next_state = IDLE_state;
				end
			endcase
		end 
		
	always @(*)	
		begin
			load       = 0;
			shift      = 1;
			par_signal = 0;
			selA       = 0;
			selB       = 0;
			start_bit  = 1;
			stop_bit   = 0;
			
			case(present_state)
			
				IDLE_state : begin
					load       = 0;
					shift      = 0;
					par_signal = 0;
					selA       = 0;
					selB       = 0;
					start_bit  = 1;
					stop_bit   = 0;
				end
				Data_Load : begin
				    load = 1;
				end
				Start_State : begin
					start_bit  = 1;
					selA       = 0;
					selB       = 0;
					load       = 0;
					shift      = 0;
				end
				Data_TxState : begin
				    if(data_stable == 0) begin
                        start_bit  = 0;
                        load       = 0;
                        shift      = 1;
                        selA       = 0;
                        selB       = 1;
                    end
                    else begin
                        start_bit  = 0;
                        load       = 0;
                        shift      = 0;
                        selA       = 0;
                        selB       = 1;
                    end
				end
				Parity_State : begin
				    start_bit  = 0;
					par_signal = 1;
					selA       = 1;
					selB       = 0;
				end
				Stop_State : begin
					stop_bit   = 1;
					selA       = 1;
					selB       = 1;
				end
				default : begin
					load       = 0;
					shift      = 0;
					par_signal = 0;
					selA       = 0;
					selB       = 0;
					start_bit  = 1;
					stop_bit   = 0;
				end
			endcase
		end
		
endmodule