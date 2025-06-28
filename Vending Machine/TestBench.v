`timescale 1ns / 1ps

module Vending_Machine_TB;
    reg clock,start,rst,cancel,online_payment;
    reg [2:0]products;
    reg [6:0]amount_given;
    
    wire [3:0]state;
    wire      dispense_product;
    wire [7:0]product_price;
    wire [7:0]return_change;
    
    Vending_Machine V1(clock,start,rst,cancel,products,product_price,state,amount_given,online_payment,return_change,dispense_product);
    
    always #5 clock = ~clock;
    
    initial
        begin
            clock          = 1'b0;
            rst            = 1'b1;
            start          = 1'b0;
            cancel         = 1'b0;
            online_payment = 1'b0;
            amount_given   = 1'b0;
            products       = 1'b0;
            
            #50 rst             = 1'b0;
            #50;
            start           = 1'b1;
            products        = 3'b101;
            online_payment  = 1'b1;
            #30 start       = 1'b0;
            online_payment  = 1'b0;
            
            #50;
            start        = 1'b1;
            products     = 3'b001;
            amount_given = 8'd85;
            #30 start    = 1'b0;
            amount_given = 8'd0;
            
            #50;
            start        = 1'b1;
            products     = 3'b011;
            amount_given = 8'd10;
            #30 start    = 1'b0;
            amount_given = 8'd0;
            
            #50;
            start        = 1'b1;
            products     = 3'b110;
            amount_given = 8'd110;
            #30 start    = 1'b0;
            amount_given = 8'd0;
            
            #50;
            start        = 1'b1;
            products     = 3'b010;
            amount_given = 8'd80;
            #30 start    = 1'b0;
            amount_given = 8'd0;
            
            #500 $finish;
        end
        
endmodule
