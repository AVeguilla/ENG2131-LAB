`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/08/2021 11:55:55 AM
// Design Name: 
// Module Name: Lab2_Part1
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


module Lab2_Part1(
    input A,
    input B,
    input C,
    input D,
    output F
    
    );
    wire G, H;
    and(G, A, B);
    and(H, C, D);
    or(F, G, H);
    
endmodule
module Lab2_Part1_testbench;
    wire F; //output from module
    reg A, B, C, D; //inputs to module
    //TODO - Instantiate module under A 
    Lab2_Part1  dut(A,B,C,D,F);
    initial begin
    A = 1'b0; B = 1'b0; C = 1'b0; D = 1'b0;
    #10;
    A = 1'b0; B = 1'b0; C = 1'b0; D = 1'b1;
    #10;
    A = 1'b0; B = 1'b0; C = 1'b1; D = 1'b0;
    #10;
    A = 1'b0; B = 1'b0; C = 1'b1; D = 1'b1;
    #10;     
    A = 1'b0; B = 1'b1; C = 1'b0; D = 1'b0;
    #10; 
    A = 1'b0; B = 1'b1; C = 1'b0; D = 1'b1;
    #10;            
    A = 1'b0; B = 1'b1; C = 1'b1; D = 1'b0;
    #10; 
    A = 1'b0; B = 1'b1; C = 1'b1; D = 1'b1;
    #10; 
    A = 1'b1; B = 1'b0; C = 1'b0; D = 1'b0;
    #10; 
    A = 1'b1; B = 1'b0; C = 1'b0; D = 1'b1;
    #10;
    A = 1'b1; B = 1'b0; C = 1'b1; D = 1'b0;
    #10;
    A = 1'b1; B = 1'b0; C = 1'b1; D = 1'b1;
    #10;
    A = 1'b1; B = 1'b1; C = 1'b0; D = 1'b0;
    #10;
    A = 1'b1; B = 1'b1; C = 1'b0; D = 1'b1;
    #10;
    A = 1'b1; B = 1'b1; C = 1'b1; D = 1'b0;
    #10;
     A = 1'b1; B = 1'b1; C = 1'b1; D = 1'b1;
    #10;
    end
    
endmodule
    