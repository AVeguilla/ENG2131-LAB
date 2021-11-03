`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/14/2021 06:27:37 PM
// Design Name: 
// Module Name: Lab2_Part5
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

module FullAdder(sum, cout, x, y, cin);
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

module Lab2_Part5 (sum, cout, x, y, cin);
output [3:0] sum;
output cout;
input [3:0] x, y;
input cin;
wire [3:1] c; 

FullAdder FA0 (sum[0], c[1], x[0], y[0], cin); //sum, cout, x, y, cin
FullAdder FA1 (sum[1], c[2], x[1], y[1], c[1]);
FullAdder FA2 (sum[2], c[3], x[2], y[2], c[2]);
FullAdder FA3 (sum[3], cout, x[3], y[3], c[3]);

endmodule

module Lab2_Part5_testbench;

reg [3:0] x, y;
reg cin;
wire [3:0] sum;
wire cout;

Lab2_Part5  dut(sum, cout, x, y, cin);

initial begin

    x = 4'b0000; y = 4'b0000; cin = 1'b0;
    #1000;
    x = 4'b1111; y = 4'b0000; cin = 0'b0;
    #1000;
    x = 4'b1111; y = 4'b0000; cin = 1'b1;
    #1000;
    x = 4'b1010; y = 4'b0101; cin = 1'b0;
    #1000;
    x = 4'b1111; y = 4'b1111; cin = 1'b0;
    #1000;
    x = 4'b1111; y = 4'b1111; cin = 1'b1;
    #1000;
    
    
    end
endmodule