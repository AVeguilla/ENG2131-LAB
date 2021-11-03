`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Dunwoody College of Technology
// Engineer: Antonio Veguilla Hernandez
// 
// Create Date: 09/27/2021 06:42:18 AM
// Design Name: 
// Module Name: HW1_Part2
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


primitive HW1_Part2 (F, X, Y, Z);
    output F;
    input X, Y, Z;
    
    table
        // X    Y   Z       F
            0   0   0   :   0;
            0   0   1   :   1;
            0   1   0   :   0;
            0   1   1   :   1;
            1   0   0   :   0;
            1   0   1   :   0;
            1   1   0   :   1;
            1   1   1   :   1;
            
    endtable
endprimitive


module HW1_Part2_testbench;

wire F;
reg X, Y, Z;

HW1_Part2  dut(F, X, Y, Z);

initial begin
    X = 1'b0; Y = 1'b0; Z = 1'b0;
    #10;
    X = 1'b0; Y = 1'b0; Z = 1'b1;
    #10;
    X = 1'b0; Y = 1'b1; Z = 1'b0;
    #10;
    X = 1'b0; Y = 1'b1; Z = 1'b1;
    #10;
    X = 1'b1; Y = 1'b0; Z = 1'b0;
    #10;
    X = 1'b0; Y = 1'b0; Z = 1'b1;
    #10;
    X = 1'b1; Y = 1'b1; Z = 1'b0;
    #10;
    X = 1'b1; Y = 1'b1; Z = 1'b1;
    #10;
    end
endmodule
