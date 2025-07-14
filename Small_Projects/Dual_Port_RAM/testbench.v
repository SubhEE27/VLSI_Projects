`timescale 1ns / 1ps

module DPort_tb;
    reg clock,reset,wenable1,wenable2;
    reg [2:0]addr1,addr2;         
    reg [31:0]data_in1,data_in2;
    
    wire [31:0]data_out1,data_out2;
    
    DPort_RAM M1(clock,reset,wenable1,wenable2,addr1,addr2,data_in1,data_in2,data_out1,data_out2);
    
    always #5 clock = ~clock;
    
    initial
        begin
            clock    = 0;
            reset    = 1;
            wenable1 = 0;
            wenable2 = 0;
            addr1    = 0;
            addr2    = 0;
            data_in1 = 0;
            data_in2 = 0;
            
            #15 reset = 0;
            
            #10;
            wenable1 = 0;
            wenable2 = 0;
            addr1    = 3'b101;
            addr2    = 3'b010;
            
            #10;
            wenable1 = 0;
            wenable2 = 1;
            addr1    = 3'b001;
            addr2    = 3'b111;
            data_in1 = 0;
            data_in2 = 32'd88;
            
            #10;
            wenable1 = 1;
            wenable2 = 0;
            addr1    = 3'b110;
            addr2    = 3'b111;
            data_in1 = 32'd99;
            data_in2 = 0;
            
            #10;
            wenable1 = 0;
            wenable2 = 0;
            addr1    = 3'b001;
            addr2    = 3'b111;
            data_in1 = 0;
            data_in2 = 0;
            
            #10;
            wenable1 = 1;
            wenable2 = 1;
            addr1    = 3'b000;
            addr2    = 3'b100;
            data_in1 = 32'd13;
            data_in2 = 32'd96;
            
            #10;
            wenable1 = 0;
            wenable2 = 0;
            addr1    = 3'b000;
            addr2    = 3'b100;
            data_in1 = 0;
            data_in2 = 0;
            
            #20 $finish;
        end
endmodule
