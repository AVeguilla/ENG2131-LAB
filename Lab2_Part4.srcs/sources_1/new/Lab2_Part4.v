`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/14/2021 01:28:01 PM
// Design Name: 
// Module Name: Lab2_Part4
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

module Lab2_Part4(sum, cout, x, y, cin);
    input x;
    input y;
    input cin;
    output cout;
    output sum;

wire e, f, g;

xor #10 (e, x, y);
xor #10 (sum, e, cin);
and #10 (f, e, cin);
and #10 (g, x, y);
or #10 (cout, f, g);
    
endmodule

module Lab2_Part4_testbench;

wire cout, sum;
reg x, y, cin;

Lab2_Part4  dut(sum, cout, x, y, cin);

initial begin
    x = 1'b0; y = 1'b0; cin = 1'b0;
    #100;
    x = 1'b0; y = 1'b0; cin = 1'b1;
    #100;
    x = 1'b0; y = 1'b1; cin = 1'b0;
    #100;
    x = 1'b0; y = 1'b1; cin = 1'b1;
    #100;
    x = 1'b1; y = 1'b0; cin = 1'b0;
    #100;
    x = 1'b1; y = 1'b0; cin = 1'b1;
    #100;
    x = 1'b1; y = 1'b1; cin = 1'b0;
    #100;
    x = 1'b1; y = 1'b1; cin = 1'b1;
    #100;
    end
endmodule