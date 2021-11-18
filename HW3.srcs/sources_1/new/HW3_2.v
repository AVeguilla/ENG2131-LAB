`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/16/2021 05:17:40 PM
// Design Name: 
// Module Name: HW3_2
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


module HW3_2(
    input c,
    input a,
    input b,
    output F1
    );

assign F1 = (a) ? (b ? 1 : !c) : ( b ? 0 : c );

endmodule

module HW3_2_tb();

HW3_2 dut1(c, a, b, F1);
reg a = 0, b = 0, c = 0;
wire F1;
initial begin
    a = 0;
    b = 0;
    c = 0;
    #10
    a = 0;
    b = 0;
    c = 1;
    #10
    a = 0;
    b = 1;
    c = 0;
    #10
    a = 0;
    b = 1;
    c = 1;
    #10
    a = 1;
    b = 0;
    c = 0;
    #10
    a = 1;
    b = 0;
    c = 1;
    #10
    a = 1;
    b = 1;
    c = 0;
    #10
    a = 1;
    b = 1;
    c = 1;
    #10;
end

endmodule