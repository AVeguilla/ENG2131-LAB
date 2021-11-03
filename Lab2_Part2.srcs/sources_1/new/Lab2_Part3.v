`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/08/2021 01:40:43 PM
// Design Name: 
// Module Name: Lab2_Part3
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


module Lab2_Part3 (sum, Co, A, B, Ci);
output sum;
output Co;
input A, B;
input ci;

wire E, F, G;

xor(E, A, B);
xor(sum, E, Ci);
and(F, E, Ci);
and(G, A, B);
or(Co, F, G);

endmodule



module Lab2_Part3_testbench;

wire Co, sum;
reg A, B, Ci;

Lab2_Part3  dut(sum, Co, A, B, Ci);

initial begin
    A = 1'b0; B = 1'b0; Ci = 1'b0;
    #10;
    A = 1'b0; B = 1'b0; Ci = 1'b1;
    #10;
    A = 1'b0; B = 1'b1; Ci = 1'b0;
    #10;
    A = 1'b0; B = 1'b1; Ci = 1'b1;
    #10;
    A = 1'b1; B = 1'b0; Ci = 1'b0;
    #10;
    A = 1'b1; B = 1'b0; Ci = 1'b1;
    #10;
    A = 1'b1; B = 1'b1; Ci = 1'b0;
    #10;
    A = 1'b1; B = 1'b1; Ci = 1'b1;
    #10;
    end
endmodule
