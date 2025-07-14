`timescale 1ns / 1ps

module DPort_RAM(clk,rst,wen1,wen2,addr1,addr2,din1,din2,dout1,dout2);
    input clk,rst,wen1,wen2;
    input [2:0]addr1,addr2;         //2 ports to access two different locations of the memory at the same time
    input [31:0]din1,din2;
    
    output reg [31:0]dout1,dout2;
    
    reg [31:0] mem [7:0];          //memory with 8 locations each  can store 32 bits
    
    initial
        begin
            dout1 <= 0;
            dout2 <= 0;
            
            mem[0] <= 32'd20;
            mem[1] <= 32'd202;
            mem[2] <= 32'd42;
            mem[3] <= 32'd17;
            mem[4] <= 32'd69;
            mem[5] <= 32'd93;
            mem[6] <= 32'd105;
            mem[7] <= 32'd127;
        end
        
        always @(posedge clk or posedge rst)
            begin
                if(rst) begin
                    dout1 <= 0;
                    dout2 <= 0; 
                end
                else begin
                    if(wen1 == 0 && wen2 == 0) begin
                        dout1 <= mem[addr1];
                        dout2 <= mem[addr2];
                    end
                    else if(wen1 == 0 && wen2 == 1) begin
                        mem[addr2] <= din2;
                        dout1 <= mem[addr1];
                    end
                    else if(wen1 == 1 && wen2 == 0) begin
                        mem[addr1] <= din1;
                        dout2 <= mem[addr2];
                    end
                    else begin
                        mem[addr1] <= din1;
                        mem[addr2] <= din2;
                    end
                end
            end
endmodule
