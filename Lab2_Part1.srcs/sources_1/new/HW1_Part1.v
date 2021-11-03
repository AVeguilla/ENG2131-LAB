`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Dunwoody College of Technology
// Engineer: Antonio Veguilla Hernandez 
// 
// Create Date: 09/27/2021 05:57:48 AM
// Design Name: 
// Module Name: HW1_Part1
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


module HW1_Part1(
    input A,
    input B,
    input C,
    input D,
    input E,
    output Y
    
    );
    wire G, F, Y;
    nand(F, B, C, D);
    nand(G, A, F, E);
    not(Y, G);
    
endmodule
module HW1_Part1_testbench;
    wire Y; //output from module
    reg A, B, C, D, E; //inputs to module
    //TODO - Instantiate module under A 
    HW1_Part1  dut(A,B,C,D,E,Y);
    initial begin
    A = 1'b0; B = 1'b0; C = 1'b0; D = 1'b0; E = 1'b0;
    #10;
    A = 1'b0; B = 1'b0; C = 1'b0; D = 1'b0; E = 1'b1;
    #10;
    A = 1'b0; B = 1'b0; C = 1'b0; D = 1'b1; E = 1'b0;
    #10;
    A = 1'b0; B = 1'b0; C = 1'b0; D = 1'b1; E = 1'b1;
    #10;
    A = 1'b0; B = 1'b0; C = 1'b1; D = 1'b0; E = 1'b0;
    #10;
    A = 1'b0; B = 1'b0; C = 1'b1; D = 1'b0; E = 1'b1;
    #10;
    A = 1'b0; B = 1'b0; C = 1'b1; D = 1'b1; E = 1'b0;
    #10;
    A = 1'b0; B = 1'b0; C = 1'b1; D = 1'b1; E = 1'b1;
    #10;
    A = 1'b0; B = 1'b1; C = 1'b0; D = 1'b0; E = 1'b0;
    #10;
    A = 1'b0; B = 1'b1; C = 1'b0; D = 1'b0; E = 1'b1;
    #10;
    A = 1'b0; B = 1'b1; C = 1'b0; D = 1'b1; E = 1'b0;
    #10;
    A = 1'b0; B = 1'b1; C = 1'b0; D = 1'b1; E = 1'b1;
    #10;
    A = 1'b0; B = 1'b1; C = 1'b1; D = 1'b0; E = 1'b0;
    #10;
    A = 1'b0; B = 1'b1; C = 1'b1; D = 1'b0; E = 1'b1;
    #10;
    A = 1'b0; B = 1'b1; C = 1'b1; D = 1'b1; E = 1'b0;
    #10;
    A = 1'b0; B = 1'b1; C = 1'b1; D = 1'b1; E = 1'b1;
    #10;
    A = 1'b1; B = 1'b0; C = 1'b0; D = 1'b0; E = 1'b0;
    #10;
    A = 1'b1; B = 1'b0; C = 1'b0; D = 1'b0; E = 1'b1;
    #10;
    A = 1'b1; B = 1'b0; C = 1'b0; D = 1'b1; E = 1'b0;
    #10;
    A = 1'b1; B = 1'b0; C = 1'b0; D = 1'b1; E = 1'b1;
    #10;
    A = 1'b1; B = 1'b0; C = 1'b1; D = 1'b0; E = 1'b0;
    #10;
    A = 1'b1; B = 1'b0; C = 1'b1; D = 1'b0; E = 1'b1;
    #10;
    A = 1'b1; B = 1'b0; C = 1'b1; D = 1'b1; E = 1'b0;
    #10;
    A = 1'b1; B = 1'b0; C = 1'b1; D = 1'b1; E = 1'b1;
    #10;
    A = 1'b1; B = 1'b1; C = 1'b0; D = 1'b0; E = 1'b0;
    #10;
    A = 1'b1; B = 1'b1; C = 1'b0; D = 1'b0; E = 1'b1;
    #10;
    A = 1'b1; B = 1'b1; C = 1'b0; D = 1'b1; E = 1'b0;
    #10;
    A = 1'b1; B = 1'b1; C = 1'b0; D = 1'b1; E = 1'b1;
    #10;
    A = 1'b1; B = 1'b1; C = 1'b1; D = 1'b0; E = 1'b0;
    #10;
    A = 1'b1; B = 1'b1; C = 1'b1; D = 1'b0; E = 1'b1;
    #10;
    A = 1'b1; B = 1'b1; C = 1'b1; D = 1'b1; E = 1'b0;
    #10;
    A = 1'b1; B = 1'b1; C = 1'b1; D = 1'b1; E = 1'b1;
    #10;
    end
    
endmodule

