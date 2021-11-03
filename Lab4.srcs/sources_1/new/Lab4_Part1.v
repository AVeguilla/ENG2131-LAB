`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/22/2021 01:04:36 PM
// Design Name: 
// Module Name: Lab4_Part1
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
    input sw0, //Is for the MODE (M)
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
    output led10,
    output led11,
    output led12,
    output led13,
    output led14,
    output led15
    );
    //(sum, cout, x, y, m, v)
    Lab4_Part1 dut(sum, cout, {sw4,sw3,sw2,sw1}, {sw8,sw7,sw6,sw5}, {sw0}, v);
    wire [3:0]sum;
    wire cout, v;
    
    assign led0 = sw0; //Mode Input
    assign led1 = sw1; //y LSB 1st bit
    assign led2 = sw2; //y 2nd bit
    assign led3 = sw3; //y 3rd bit
    assign led4 = sw4; //y MSB 4th bit
    assign led5 = sw5; //x LSB 1st bit
    assign led6 = sw6; //x 2nd bit
    assign led7 = sw7; //x 3rd bit
    assign led8 = sw8; //x MSB 4th bit
    assign led10 = sum[0];
    assign led11 = sum[1];
    assign led12 = sum[2];
    assign led13 = sum[3];
    assign led14 = cout;
    assign led15 = v;
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

module Lab4_Part1 (sum, cout, x, y, m, v);
output [3:0] sum;
output cout, v;
input [3:0] x, y;
input m;
wire [3:1] c; 
xor(d[0], x[0], m);
xor(d[1], x[1], m);
xor(d[2], x[2], m);
xor(d[3], x[3], m);
xor(v, c[3], cout);
wire [3:0]d;

FullAdder FA0 (sum[0], c[1], d[0], y[0], m); //sum, cout, x, y, cin
FullAdder FA1 (sum[1], c[2], d[1], y[1], c[1]);
FullAdder FA2 (sum[2], c[3], d[2], y[2], c[2]);
FullAdder FA3 (sum[3], cout, d[3], y[3], c[3]);

endmodule
