`timescale 1ns / 1ps

module memory(clk, wenable, addr, data_in, data_out);
	input            clk,wenable;
	input     [15:0]  addr;                 //8 memories so 3 bits would have been sufficient but this address will come from program counter so declared as 16 bits
	input     [15:0] data_in;
	output reg[15:0] data_out;
	
	reg [15:0] mem [255:0]; 
	integer i;                //8 memories with specific address each to store 16 bit values
	
	initial
		begin
			data_out <= 0;
			
			//Initially the memories contains some values stored in it
			mem[0]   <= 16'b0000101101011101;
			mem[1]   <= 16'b0000000010110100;
			mem[2]   <= 16'b0011100001010111;
			mem[3]   <= 16'b0000000000101101;
			mem[4]   <= 16'b0000000000000111;
			mem[5]   <= 16'b0000001111010010;
			mem[6]   <= 16'b0000011110010111;
			mem[7]   <= 16'b0000000011100101;
			mem[8]   <= 16'b0001101100110101;
			
			for (i = 9; i < 256; i = i + 1) begin
                mem[i] = $random & 16'hFFFF;
            end
		end	
	always @(posedge clk)
		begin
			if(wenable)
				mem[addr] <= data_in;       //Write into the memory with specified address
		    else
		      data_out <= mem[addr];          //Read from the memory with specified address
		end
endmodule
