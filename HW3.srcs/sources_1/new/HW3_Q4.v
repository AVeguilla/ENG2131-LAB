`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/17/2021 04:32:29 PM
// Design Name: 
// Module Name: HW3_Q4_comp4bit
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


module HW3_Q4_comp4bit(
    input [3:0]a, 
    input [3:0]b,
    input EQin,
    input GTin,
    input LTin,
    output reg EQout,
    output reg GTout,
    output reg LTout
    );

always @(a,b,EQin,GTin,LTin)begin
    if(a > b)begin
        GTout <= 1;
        EQout <= 0;
        LTout <= 0;
    end
    else if (a == b) begin
        if(EQin) begin
            GTout <= 0;
            EQout <= 1;
            LTout <= 0;
        end
        else if(GTin) begin
            GTout <= 1;
            EQout <= 0;
            LTout <= 0;
        end
        else if(LTin)begin
            GTout <= 0;
            EQout <= 0;
            LTout <= 1;
        end
    else begin
        EQout <= 1;
        GTout <= 0;
        LTout <= 0;
    end
    
    end
    else if(a < b)begin
        GTout <= 0;
        EQout <= 0;
        LTout <= 1;
    end
        end
endmodule

module HW3_Q4_comp4bit_tb();
reg [3:0]a = 0, b = 0;
reg EQin = 0, GTin = 0, LTin = 0;
wire EQout, GTout, LTout;
HW3_Q4_comp4bit dut2(a,b,EQin,GTin,LTin,EQout,GTout,LTout);


initial begin
    a = 5;
    b = 3;
    #10
    a = 12;
    b = 12;
    #10
    a = 11;
    b = 14;
    #10
    a = 7;
    b = 7;
    GTin = 1;
    #10
    a = 7;
    b = 7;
    GTin = 0;
    LTin = 1;
    #10
    a = 7;
    b = 7;
    LTin = 0;
    EQin = 1;
    #10;
    
end

endmodule

module comp8bit(
input [7:0]a, 
input [7:0]b,
input EQin,
input GTin,
input LTin,
output reg EQout,
output reg GTout,
output reg LTout
);

always @(a,b,EQin,GTin,LTin)begin
    if(a > b)begin
        GTout <= 1;
        EQout <= 0;
        LTout <= 0;       
    end
    else if (a == b) begin
        if(EQin) begin
            GTout <= 0;
            EQout <= 1;
            LTout <= 0;
        end
        else if(GTin) begin
            GTout <= 1;
            EQout <= 0;
            LTout <= 0;
        end
        else if(LTin)begin
            GTout <= 0;
            EQout <= 0;
            LTout <= 1;
        end
    else begin
        EQout <= 1;
        GTout <= 0;
        LTout <= 0;
    end
    
    end
    else if(a < b)begin
        GTout <= 0;
        EQout <= 0;
        LTout <= 1;
    end
        end

endmodule

module comp8bit_tb();
reg [7:0]a = 0, b = 0;
reg EQin = 0, GTin = 0, LTin = 0;
wire EQout, GTout, LTout;
comp8bit dut3(a,b,EQin,GTin,LTin,EQout,GTout,LTout);
initial begin
    a = 5;
    b = 3;
    #10
    a = 12;
    b = 12;
    #10
    a = 11;
    b = 14;
    #10
    a = 7;
    b = 7;
    GTin = 1;
    #10
    a = 7;
    b = 7;
    GTin = 0;
    LTin = 1;
    #10
    a = 7;
    b = 7;
    LTin = 0;
    EQin = 1;
    #10
    EQin = 0;
    a = 25;
    b = 20;
    #10
    a = 30;
    b = 30;
    #10
    a = 22;
    b = 32;
    #10
    a = 20;
    b = 20;
    GTin = 1;
    #10
    a = 20;
    b = 20;
    GTin = 0;
    LTin = 1;
    #10
    a = 20;
    b = 20;
    LTin = 0;
    EQin = 1;
    #10;    
end
    
endmodule