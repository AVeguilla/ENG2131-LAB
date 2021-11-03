`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/14/2021 01:05:58 PM
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


module Lab2_Part3(sum, cout, x, y, cin);
    input x;
    input y;
    input cin;
    output cout;
    output sum;

wire e, f, g;

xor(e, x, y);
xor(sum, e, cin);
and(f, e, cin);
and(g, x, y);
or(cout, f, g);
    
endmodule

module Lab2_Part3_testbench;

wire cout, sum;
reg x, y, cin;

Lab2_Part3  dut(sum, cout, x, y, cin);

initial begin
    x = 1'b0; y = 1'b0; cin = 1'b0;
    #10;
    x = 1'b0; y = 1'b0; cin = 1'b1;
    #10;
    x = 1'b0; y = 1'b1; cin = 1'b0;
    #10;
    x = 1'b0; y = 1'b1; cin = 1'b1;
    #10;
    x = 1'b1; y = 1'b0; cin = 1'b0;
    #10;
    x = 1'b1; y = 1'b0; cin = 1'b1;
    #10;
    x = 1'b1; y = 1'b1; cin = 1'b0;
    #10;
    x = 1'b1; y = 1'b1; cin = 1'b1;
    #10;
    end
endmodule