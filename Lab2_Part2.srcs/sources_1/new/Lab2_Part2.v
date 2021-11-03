`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/08/2021 01:03:41 PM
// Design Name: 
// Module Name: Lab2_Part2
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


primitive Lab2_Part2 (F, X, Y, Z);
    output F;
    input X, Y, Z;
    
    table
        // X    Y   Z       F
            0   0   0   :   0;
            0   0   1   :   1;
            0   1   0   :   0;
            0   1   1   :   0;
            1   0   0   :   1;
            1   0   1   :   1;
            1   1   0   :   1;
            1   1   1   :   1;
            
    endtable
endprimitive


module Lab2_Part2_testbench;

wire F;
reg X, Y, Z;

Lab2_Part2  dut(F, X, Y, Z);

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