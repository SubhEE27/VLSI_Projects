`timescale 1ns / 1ps

module SPort_RAM(clk,rst,addr,wenable,din,dout);
    input clk,rst,wenable;
    input      [2:0] addr;      //single port through which we can access 8 memory locations
    input      [31:0] din;      //write data into the specific memory location
    output reg [31:0] dout;     //read data from the specific memory location
    
    reg [31:0] mem [7:0];     //8 memory locations each can hold 32 bits of data
    
    initial
        begin
            dout   <= 0;
              
            mem[0] <= 32'd52;
            mem[1] <= 32'd78;
            mem[2] <= 32'd95;
            mem[3] <= 32'd47;
            mem[4] <= 32'd102;
            mem[5] <= 32'd80;
            mem[6] <= 32'd82;
            mem[7] <= 32'd118;
        end
          
    always @(posedge clk or posedge rst)
        begin
            if(rst) begin
                dout <= 0;
            end
            else begin
                if(wenable) begin
                    mem[addr] <= din;   
                end
                else begin
                    dout <= mem[addr];
                end
            end
        end
endmodule

