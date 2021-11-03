`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Dunwoody College of Technology
// Engineer: Antonio Veguilla Hernandez
// 
// Create Date: 09/29/2021 01:18:22 PM
// Design Name: 
// Module Name: BCDtoSevenSegN
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
module FPGA_Interface(sw,an,seg,clk,led);
output [3:0]an;
input clk;
input [15:0]sw;
output [6:0]seg;
output [15:0]led;

SevenSegmentFourDigits(clk, sw[3:0], sw[7:4], sw[11:8], sw[15:12], an, seg);
assign led[15:0] = sw[15:0];

endmodule

module SevenSegmentFourDigits(clk, bcd0, bcd1, bcd2, bcd3, AN, segN);
input clk; //Standard 100MHz clock
input [3:0]bcd0; //right most digit
input [3:0]bcd1;
input [3:0]bcd2;
input [3:0]bcd3; //left-most digit
output [3:0]AN; //digit enable active low
output [7:0]segN; //segment enable, active low

BCDtoSevenSegN dut(trueBCD, segN);
DigitController dut1(clk, AN);
reg [3:0]trueBCD = 0;

always@(AN)
begin
if(AN[0] == 0)
    begin
        trueBCD = bcd0;
    end
else if(AN[1] == 0)
    begin
    trueBCD = bcd1;
    end
else if(AN[2] == 0)
    begin
    trueBCD = bcd2;
    end
else if(AN[3] == 0)
    begin
        trueBCD = bcd3;
    end
end
endmodule

module BCDtoSevenSegN(
    input [3:0]bcd,
    output [6:0]segN //Active low!
    );
reg [6:0]segN;
always @ bcd
    begin
    case(bcd)
    0 : begin
        segN = 7'b1000000; //0
    end
    1 : begin
        segN = 7'b1111001; //1
    end
    2: begin
        segN = 7'b0100100; //2
    end
    3 : begin
        segN = 7'b0110000; //3
    end
    4 : begin
        segN = 7'b0011001; //4
    end
    5 : begin
        segN = 7'b0010010; //5
    end
    6 : begin
        segN = 7'b0000010; //6
    end
    7 : begin
        segN = 7'b1111000; //7
    end
    8 : begin
        segN = 7'b0000000; //8
    end
    9 : begin
        segN = 7'b0010000; //9
        end
    10 : begin
        segN = 7'b0001000; //A
        end
    11 : begin
        segN = 7'b0000011; //b
        end
    12 : begin
        segN = 7'b1000110; //C
        end
    13 : begin
        segN = 7'b0100001; //d
        end
    14 : begin
        segN = 7'b0000110; //E
        end
    default : begin
        segN = 7'b0001110; //F
        end
    endcase
end

endmodule

module DigitController(
    input clk,
    output [3:0]AN
    );
    parameter refresh_ms = 0.010; //10ms
    parameter numDigits = 4; 
    reg [20:0] count0 = 0; //counter with a magnitude of 2^19 
    reg [1:0]count1 = 0; //this will be used to increment 1 everytime count 0 is reset
    reg [numDigits - 1:0]AN = 4'b0111;
    always @ (posedge clk)
    begin
    if(count0 == 125000)//refresh_ms/numDigits)*50000000
        begin
            if(count1 == 0)
            begin
                AN <= 4'b1110;
                count1 <= count1 +1; //count 1 is set to 1
                count0 <= 0;
            end
            else if(count1 == 1)
            begin
                AN <= 4'b1101;
                count1 <= count1 +1; //count 1 is set to 2
                count0 <= 0;   
            end
            else if(count1 == 2)
            begin
                AN <= 4'b1011;
                count1 <= count1 +1; //count 1 is set to 3
                count0 <= 0;
            end
            else //if(count1 == 3)
            begin
                AN <= 4'b0111;
                count1 <= 0; //resets the counter count1
                count0 <= 0;
            end
        end
        else
            begin
                count0 <= count0+1;
            end
    end
    
endmodule

module testbench_DigitController;
    reg clk;
    wire [3:0]AN;
    integer i = 0;
    DigitController dut(clk, AN);
    initial begin
    clk = 0;
            for(i = 0; i<1000000000; i=i+1)
            begin
            clk = ~clk;
            #10;           
            end
    end
endmodule

module testbench_BCDtoSevenSegN;
wire [6:0]segN;
reg [3:0]bcd;

BCDtoSevenSegN dut(bcd, segN);

initial begin
    bcd = 4'b0000;
    #10
    bcd = 4'b0001;
    #10
    bcd = 4'b0010;
    #10
    bcd = 4'b0011;
    #10
    bcd = 4'b0100;
    #10
    bcd = 4'b0101;
    #10
    bcd = 4'b0110;
    #10
    bcd = 4'b0111;
    #10
    bcd = 4'b1000;
    #10
    bcd = 4'b1001;
    #10
    bcd = 4'b1010;
    #10
    bcd = 4'b1011;
    #10
    bcd = 4'b1100;
    #10
    bcd = 4'b1101;
    #10
    bcd = 4'b1101;
    #10
    bcd = 4'b1110;
    #10
    bcd = 4'b1111;
    #10;
    end
endmodule