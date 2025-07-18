`timescale 1ns/1ps

module PISO(clk, rst, load, shift, data_in, data_out, count);
    input clk, rst, load, shift;
    input [7:0] data_in;
    output reg data_out;
    output reg [3:0] count;

    reg [7:0] store;

    always @(posedge clk) begin
        if (rst) begin
            store    <= 0;
            data_out <= 0;
            count    <= 0;
        end
        else begin
            // Highest Priority: Load (even if shift is also 1)
            if (load) begin
                store    <= data_in;
                data_out <= 0;
                count    <= 0;
            end
            // Second Priority: Shift
            else if (shift) begin
                if (count == 9) begin
                    data_out <= 0;
                    store    <= 0;
                    count    <= 0;
                end
                else begin
                    data_out <= store[0];
                    store    <= store >> 1;
                    count    <= count + 1;
                end
            end
            // Else: Hold (no change)
            else begin
                store    <= store;
                data_out <= data_out;
                count    <= count;
            end
        end
    end

endmodule
