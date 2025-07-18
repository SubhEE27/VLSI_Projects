`timescale 1ns/1ps

module demux1to4(selA,selB,outA,outB,outC,outD,in);
	input selA,selB;
	input in;
	output reg outA,outB,outC,outD;
	
	always @(*)
		begin
			case({selA,selB})
				2'b00: begin
					outA = in;
					outB = 0;
					outC = 0;
					outD = 0;
				end
				2'b01: begin
					outB = in;
					outA = 0;
					outC = 0;
					outD = 0;
				end
				2'b10: begin
					outC = in;
					outB = 0;
					outA = 0;
					outD = 0;
				end
				2'b11: begin
					outD = in;
					outB = 0;
					outC = 0;
					outA = 0;
				end
				default: begin
					outA = 1;
					outB = 1;
					outC = 1;
					outD = 1;
				end
			endcase
		end

endmodule