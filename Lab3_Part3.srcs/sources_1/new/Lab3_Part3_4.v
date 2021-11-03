`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/19/2021 06:58:45 PM
// Design Name: 
// Module Name: Lab3_Part3_4
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

module Board_interface(
    input sw0,
    input sw1,
    input sw2,
    input sw3,
    input sw4,
    input sw5,
    input sw6,
    input sw7,
    input sw8,
    output led0,
    output led1,
    output led2,
    output led3,
    output led4,
    output led5,
    output led6,
    output led7,
    output led8,
    output led11,
    output led12,
    output led13,
    output led14,
    output led15
    );
    Lab3_Part3_4 dut(sum, cout, {sw4,sw3,sw2,sw1}, {sw8,sw7,sw6,sw5}, {sw0});
    wire [3:0]sum;
    wire cout;
    
    assign led0 = sw0; //Carry input
    assign led1 = sw1; //X LSB 1st bit
    assign led2 = sw2; //X 2nd bit
    assign led3 = sw3; //X 3rd bit
    assign led4 = sw4; //x 4th bit
    assign led5 = sw5; //Y LSB 1st bit
    assign led6 = sw6; //Y 2nd bit
    assign led7 = sw7; //Y 3rd bit
    assign led8 = sw8; //Y 4th bit
    assign led11 = sum[0];
assign led12 = sum[1];
assign led13 = sum[2];
assign led14 = sum[3];
assign led15 = cout;
endmodule

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

module Lab3_Part3_4 (sum, cout, x, y, cin);
output [3:0] sum;
output cout;
input [3:0] x, y;
input cin;
wire [3:1] c; 

//input clk;


FullAdder FA0 (sum[0], c[1], x[0], y[0], cin); //sum, cout, x, y, cin
FullAdder FA1 (sum[1], c[2], x[1], y[1], c[1]);
FullAdder FA2 (sum[2], c[3], x[2], y[2], c[2]);
FullAdder FA3 (sum[3], cout, x[3], y[3], c[3]);



endmodule

