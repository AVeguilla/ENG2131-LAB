`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/10/2021 12:14:33 PM
// Design Name: 
// Module Name: PixelClock
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
module FPGA_Interface(clk,led, JA, btnC, vgaRed, vgaGreen,vgaBlue, Hsync, Vsync, sw);
input clk;
input btnC;
input [15:0]sw;
output [3:0]vgaRed;
output [3:0]vgaBlue;
output [3:0]vgaGreen;
output Hsync, Vsync;
output [15:0]led;
output [7:0]JA;
PixelClock(clk, clk_25MHz);
assign led[0] =clk;
assign led[1] =clk_25MHz;
assign JA[1] =clk;
assign JA[2] =clk_25MHz;
//SyncSignals(clk, btnC);
SyncSignals(clk, btnC, Hcount, Vcount, Hsync, Vsync, DE);
wire [9:0]Hcount, Vcount;
wire DE;
assign vgaRed = (DE) ?  0 : sw[3:0];
assign vgaBlue = (DE) ?  0 : sw[7:4];
assign vgaGreen = (DE) ?  0 : sw[11:8];

endmodule
///////////////////////////////////////////////////////////////////////////
module SyncSignals(
input clk,
input rst,
output reg [9:0]Hcount = 0,
output reg [9:0]Vcount = 0,
output HSYNC,
output VSYNC,
output DE
);

PixelClock myclk(clk, clk_25MHz);
wire clk_25MHz;

assign DE = ~(Hcount < 640 && Vcount < 480);
assign HSYNC = ~(Hcount > 655 && Hcount < 752);
assign VSYNC = ~(Vcount > 488 && Vcount < 492);


always @(posedge clk_25MHz)
    begin
        if(rst == 1)
            begin
                Hcount <= 0;
                Vcount <= 0;
            end
        else begin
            Hcount <= Hcount +1;
            if(Hcount == 799) begin
                Hcount <= 0;
                Vcount <= Vcount + 1;
            end
            if(Vcount == 520) Vcount <= 0;
        end    
    end
endmodule

module testbench_SyncSignals();
reg clk = 0;
reg rst = 0;
SyncSignals dut1(clk, rst, Hcount, Vcount, HSYNC, VSYNC, DE);

wire HSYNC;
wire VSYNC;
wire DE = 1;
wire [9:0]Hcount;
wire [9:0]Vcount;

 always begin
    clk = ~clk;
    #5;
    end
    
initial begin
    rst = 1;
    #10
    rst = 0;
    #10
    rst = 0;
    #10;
end

endmodule

module PixelClock(clk, clk_25MHz);
    input clk;
    output reg clk_25MHz = 0;
    reg [9:1]count = 0;
    always @ (posedge clk)
        begin
            if(count == 1)
                begin
                clk_25MHz <= ~clk_25MHz;
                count <= 0;
                end
            else
                count <= count + 1;
        end
    
endmodule

module testbench_PixelClock;
reg clk;
wire clk_25MHz;

PixelClock dut(clk, clk_25MHz);
initial begin
clk =1;
#10
clk =0;
#10
clk =1;
#10
clk =0;
#10
clk =1;
#10
clk =0;
#10
clk =1;
#10
clk =0;
#10
clk =1;
#10
clk =0;
#10
clk =1;
#10
clk =0;
#10
clk =1;
#10
clk =0;
#10
clk =1;
#10
clk =0;
#10
clk =1;
#10
clk =0;
#10
clk =1;
#10
clk =0;
#10
clk =1;
#10
clk =0;
#10
clk =1;
#10
clk =0;
#10
clk =1;
#10
clk =0;
#10
clk =1;
#10
clk =0;
#10
clk =1;
#10
clk =0;
#10
clk =1;
#10
clk =0;
#10
clk =1;
#10
clk =0;
#10
clk =1;
#10
clk =0;
#10
clk =1;
#10
clk =0;
#10
clk =1;
#10
clk =0;
#10
clk =1;
#10
clk =0;
#10
clk =1;
#10
clk =0;
#10
clk =1;
#10
clk =0;
#10
clk =1;
#10
clk =0;
#10
clk =1;
#10
clk =0;
#10
clk =1;
#10
clk =0;
#10
clk =1;
#10
clk =0;
#10
clk =1;
#10
clk =0;
#10
clk =1;
#10
clk =0;
#10
clk =1;
#10
clk =0;
#10
clk =1;
#10
clk =0;
#10
clk =1;
#10
clk =0;
#10
clk =1;
#10
clk =0;
#10
clk =1;
#10
clk =0;
#10
clk =1;
#10
clk =0;
#10
clk =1;
#10
clk =0;
#10
clk =1;
#10
clk =0;
#10
clk =1;
#10
clk =0;
#10
clk =1;
#10
clk =0;
#10
clk =1;
#10
clk =0;
#10
clk =1;
#10
clk =0;
#10
clk =1;
#10
clk =0;
#10
clk =1;
#10
clk =0;
#10
clk =1;
#10
clk =0;
#10;
end

endmodule