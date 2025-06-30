`timescale 1ns / 1ps

module ALU_OP(clk,en,aluopcode,immed,data_A,data_B,data_result,shldBranch);
	// Input Declaration
	input en,clk;
	input      [15:0]data_A,data_B;      // to read stored data from readreg1 and readreg2 to perform operations on it 
	input      [8:0] immed;
	input      [4:0] aluopcode;
	// Output Declaration
	output reg shldBranch;
	output     [17:0]data_result;        // to write the result of the operations into writereg
	
	//For Internal Functions
	wire [3:0]opcode;
	reg  [17:0]result;                   // to store result internally before assigning it to data_result
	wire op_lsb;                         // LSB of opcode as unsigned and signed operation depend on it
	assign opcode = aluopcode[4:1];
	assign op_lsb = aluopcode[0];
	
	initial 
		result <= 0;
	localparam ADD = 0, 
	           OR = 1, 
	           AND = 2, 
	           XOR = 3, 
	           NOT = 4, 
	           RDMem = 5, 
	           WRMem = 6, 
	           LOAD = 8, 
	           COMP = 9, 
	           ShftL = 10, 
	           ShftR = 11, 
	           JumpA = 12, 
	           JumpR = 13;
	
	always @(negedge clk)                                 //Defining the ALU Operations
		begin
			if(en) begin
				case(opcode)
					ADD : begin
					   result <= (op_lsb ? ($signed(data_A)+$signed(data_B)) : (data_A + data_B));
					   shldBranch <= 0;
					end
					OR  : begin
					   result <= data_A | data_B;
					   shldBranch <=0;
					end
					AND : begin
					   result <= data_A & data_B;
					   shldBranch <= 0;
					end
					XOR : begin
					   result <= data_A ^ data_B;
					   shldBranch <= 0;
					end
					NOT : begin
					   result <= ~data_A;
					   shldBranch <= 0;
					end
					LOAD: begin
					   result <= (op_lsb ? ({immed, 8'h000}) : ({8'h000, immed}));
					   shldBranch <= 0;
					end
					COMP: begin
						if(op_lsb)begin
							result[0] <= ($signed(data_A) == $signed(data_B)) ? 1 : 0;
							result[1] <= ($signed(data_A) == 0)               ? 1 : 0;
							result[2] <= ($signed(data_B) == 0)               ? 1 : 0;
							result[3] <= ($signed(data_A) > $signed(data_B))  ? 1 : 0;
							result[4] <= ($signed(data_A) < $signed(data_B))  ? 1 : 0;
						end
						else begin
							result[0] <= (data_A == data_B) ? 1 : 0;
							result[1] <= (data_A == 0)      ? 1 : 0;
							result[2] <= (data_B == 0)      ? 1 : 0;
							result[3] <= (data_A > data_B)  ? 1 : 0;
							result[4] <= (data_A < data_B)  ? 1 : 0;
						end
					end
					ShftL : result <= data_A << (data_B[2:0]);
					ShftR : result <= data_B >> (data_B[2:0]);
					JumpA : begin
						result     <= (op_lsb ? data_A : immed);
						shldBranch <= 1;
					end
					JumpR : begin
						result     <= data_A;
						shldBranch <= data_B [{op_lsb, immed[1:0]}];
					end
				endcase
			end 
		end
	assign data_result = result;
endmodule
	
