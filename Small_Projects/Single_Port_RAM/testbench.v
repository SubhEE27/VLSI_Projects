`timescale 1ns / 1ps

module SPort_tb;
    reg clock,wenable,reset;
    reg  [2:0] addr;
    reg  [31:0] data_in;
    wire [31:0]data_out;
    SPort_RAM M1(clock,reset,addr,wenable,data_in,data_out);
    
    initial clock = 0;
    always #5 clock = ~clock;
    
    initial
        begin
            reset   = 1;
            wenable = 0;
            addr    = 0;
            data_in = 0;
            
            #15;
            reset = 0;
            
            #10;
            addr  = 3'b101;
            
            #10;
            addr   = 3'b011;
            wenable = 1;
            data_in= 32'd52;
            
            #10;
            addr    = 3'b100;
            data_in = 32'd100;
            
            #10;
            wenable = 0;
            addr    = 3'b100; 
            
            #20;
            $finish;   
        end
endmodule
