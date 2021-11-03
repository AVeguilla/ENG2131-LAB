`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Dunwoody College of Technology
// Engineer: Antonio Veguilla Hernandez
// 
// Create Date: 10/13/2021 11:49:16 AM
// Design Name: Antonio Veguila Hernandez 
// Module Name: Lab6
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

module FPGA_Interface(sw,an,seg,clk,led,btnC);
output [3:0]an;
input clk;
input [15:0]sw;
input btnC;
output [7:0]seg;
output [15:0]led;
ClockHoursMinutes(clk, btnC, an, seg);
endmodule
///////////////////////////////////////////////////////////////////////////
module SevenSegmentFourDigits(clk, bcd0, bcd1, bcd2, bcd3, AN, segN, DPs);
input clk; //Standard 100MHz clock
input [3:0]bcd0; //right most digit
input [3:0]bcd1;
input [3:0]bcd2;
input [3:0]bcd3; //left-most digit
input [3:0]DPs; //decimal point control, active high
output [3:0]AN; //digit enable active low
output [7:0]segN; //segment enable, active low
BCDtoSevenSegN dut(trueBCD, segN[6:0]);
DigitController dut1(clk, AN);
reg [3:0]trueBCD = 0;
reg segN7;
assign segN[7] = segN7;
always@(AN)
begin
if(AN[0] == 0)
    begin
        trueBCD = bcd0;
        segN7 = ~DPs[0];
    end
else if(AN[1] == 0)
    begin
    trueBCD = bcd1;
    segN7 = ~DPs[1];
    end
else if(AN[2] == 0)
    begin
    trueBCD = bcd2;
    segN7 = ~DPs[2];
    end
else if(AN[3] == 0)
    begin
        trueBCD = bcd3;
        segN7 = ~DPs[3];
    end
end
endmodule
/////////////////////////////////////
module BCDtoSevenSegN(
    input [3:0]bcd,
    output reg [6:0]segN //Active low!
    );
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
///////////////////////////////////
module DigitController(clk, AN);
    input clk;
    output [3:0]AN;
    parameter refresh_ms = 0.010; //10ms
    parameter numDigits = 4;
    reg x1 = numDigits/refresh_ms; 
    reg [28:0] count0 = 0; //counter with a magnitude of 2^29 
    reg [1:0]count1 = 0; //this will be used to increment 1 everytime count 0 is reset
    reg [numDigits - 1:0]AN = 4'b0111;
    always @ (posedge clk)
    begin
    if(count0 == 50000000/x1)//50M/400 = 125000
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
///////////////////////////////////////////
module Clock1min(clk, clk_1min, clk_1sec);
input clk; // Standard 100MHz clock
output reg clk_1min = 0; //60Hz clock output = 1 minute
output reg clk_1sec = 0; // 1Hz clock output = 1 second
reg [39:0] count10 = 0; //counter with a magnitude of 2^40 
reg [28:0] count11 = 0; //counter with magnitude of 2^29.
always @(posedge clk)
    begin
        if(count11 == 50000000) //1second//
            begin
                clk_1sec = ~clk_1sec;
                count11 <=0;
            end
        else
            count11 <= count11 + 1;
        if(count10 == 3000000000) //1minute//
            begin
                clk_1min = ~clk_1min;
                count10 <= 0;
            end
        else
            begin
                count10 <= count10 + 1;
            end    
    end
endmodule
//////////////////////////////////////////////////////
module ClockHoursMinutes(clk, reset, AN, segN);
input clk;
input reset; //Resets Active High
output [3:0]AN; //digit enable, active low
output [7:0] segN; //segment enable, active low
reg resetN;
wire [3:0]bcd0;
wire [3:0]bcd1;
wire [3:0]bcd2;
wire [3:0]bcd3; 
/////////////////Instatiate////////////////////
SevenSegmentFourDigits(clk, bcd0, bcd1, bcd2, bcd3, AN, segN, DPs);
Clock1min dut_clk(clk, clk_1min, clk_1sec);
//////////////////////////////////////////////
wire clk_min;
wire clk_1sec;
wire [3:0]DPs;
assign DPs[2] = clk_1sec; //This will make the DP between HRs & mins to blink every second
BCD_Counter #(.resetVal(0), .maxValue(9))cnt1(clk_1min, resetN, bcd0, rollover0);
BCD_Counter #(.resetVal(0), .maxValue(5))cnt2(rollover0, resetN, bcd1, rollover1);
BCD_Counter #(.resetVal(1), .maxValue(9))cnt3(rollover1, resetN, bcd2, rollover3);
BCD_Counter #(.resetVal(0), .maxValue(1))cnt4(rollover3, resetN, bcd3, rollover4);
///////////////////////////////////////////////
always 
begin
    if(bcd3 == 1 & bcd2 == 2 & bcd1 == 5 & bcd0 == 9)
        begin
            resetN = 0;
        end
    else if(reset)
        resetN = 0;
    else
        resetN = 1;
end
endmodule
//////////////////////////////////////////////////////
module BCD_Counter(clk, resetN, value, rollover);
parameter maxValue = 9;
parameter resetVal = 0;
input clk; //counter should increment at each clk posedge
input resetN; //reset, active low, synchronous to clk
output reg [3:0]value = 0; //counter value
output reg rollover = 0; //binary output to indicate roll-over
always @(posedge clk, negedge resetN)
    begin
        if(!resetN)
            begin
                value <= resetVal;
                rollover <= 0;
            end
        else if(value == maxValue)
            begin
                rollover <= 1;
                value <= 0;
            end
        else
            begin
                value <= value +1;
                rollover <= 0;
            end
    end
endmodule
//////////////////////////////////////////////
module testbench_BCD_Counter;
reg clk, resetN;
wire [3:0]value;
wire rollover;
BCD_Counter dut1_1(clk, resetN, value, rollover);
    initial begin
        clk = 0;
        resetN = 1;
        #10
        clk = 1; //1st posedge
        #10
        clk = 0;
        #10
        clk = 1; //2nd posedge
        #10
        clk = 0;
        #10
        clk = 1; //3rd posedge
        #10
        clk = 0;
        #10
        clk = 1; //4th posedge
        #10
        clk = 0;
        #10
        clk = 1; //5th posedge
        #10
        clk = 0;
        #10
        clk = 1; //6th posedge
        #10
        clk = 0;
        #10
        clk = 1; //7th posedge
        #10
        clk = 0;
        #10
        clk = 1; //8th posedge
        #10
        clk = 0;
        #10
        clk = 1; //9th posedge
        #10
        clk = 0;
        #10
        clk = 1; //10th posedge
        #10
        clk = 0;
        #10
        clk = 1; //11th posedge
        #10
        clk = 0;
        #10
        clk = 1; //12th posedge
        #10
        clk = 0;
        #10
        clk = 1; //13th posedge
        #10
        clk = 0;
        #10
        clk = 1; //14th posedge
        #10
        clk = 0;
        #10
        clk = 1; //15th posedge
        #10
        clk = 0;
        #10
        clk = 1; //16th posedge
        #10
        clk = 0;
        #10
        clk = 1; //17th posedge
        #10
        clk = 0;
        #10
        clk = 1; //18th posedge
        #10
        clk = 0;
        #10
        clk = 1; //19th posedge
        #10
        clk = 0;
        #10
        clk = 1; //20th posedge
        #10
        //////Sequence to switch resetN/////////////////
        clk = 0;
        #10
        clk = 1; //1st posedge
        resetN = 0;
        #10
        clk = 0;
        #10
        clk = 1; //2nd posedge
        #10
        clk = 0;
        #10
        clk = 1; //3rd posedge
        #10
        clk = 0;
        #10
        clk = 1; //4th posedge
        #10
        clk = 0;
        #10
        clk = 1; //5th posedge
        #10
        clk = 0;
        #10
        clk = 1; //6th posedge
        resetN = 1;
        #10
        clk = 0;
        #10
        clk = 1; //7th posedge
        #10
        clk = 0;
        #10
        clk = 1; //8th posedge
        #10
        clk = 0;
        #10
        clk = 1; //9th posedge
        #10
        clk = 0;
        #10
        clk = 1; //10th posedge
        #10
        clk = 0;
        #10
        clk = 1; //11th posedge
        resetN = 0;
        #10
        clk = 0;
        #10
        clk = 1; //12th posedge
        #10
        clk = 0;
        #10
        clk = 1; //13th posedge
        #10
        clk = 0;
        #10
        clk = 1; //14th posedge
        #10
        clk = 0;
        #10
        clk = 1; //15th posedge
        #10
        clk = 0;
        #10
        clk = 1; //16th posedge
        resetN =1;
        #10
        clk = 0;
        #10
        clk = 1; //17th posedge
        #10
        clk = 0;
        #10
        clk = 1; //18th posedge
        #10
        clk = 0;
        #10
        clk = 1; //19th posedge
        #10
        clk = 0;
        #10
        clk = 1; //20th posedge
        #10
        clk = 0;
        #10
        clk = 1; //21st posedge
        resetN =1;
        #10;
    end
endmodule
/////////////////////////////////////////////
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