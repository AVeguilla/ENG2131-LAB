`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/07/2021 07:25:13 PM
// Design Name: 
// Module Name: LatchWithAsyncClear
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


module LatchWithAsyncClear(
    input clk,
    input d,
    input AsyncClr,
    output q,
    output qn
    );
    
    reg q;
    
    always @(clk or d or AsyncClr)
    begin
        
        if(~clk && AsyncClr)
            begin
                q <= d;
            end
        else if(~AsyncClr)
            begin
                q <= 0;
            end
        
    end
        
    assign qn = ~q;
    
endmodule

module testbench_LatchWithAsyncClear;
    reg clk, d, AsyncClr;
    wire q, qn;
    
    LatchWithAsyncClear dut1(clk, d, AsyncClr, q, qn);
    initial begin
    d = 0;
    clk = 1;
    AsyncClr = 1;
    #8
    d = 1;
    clk = 1;
    AsyncClr = 1;
    #2
    d = 1;
    clk = 0;
    AsyncClr = 1;
    #10
    d = 1;
    clk = 1;
    AsyncClr = 1;
    #2
    d = 0;
    clk = 1;
    AsyncClr = 1;
    #8
    d = 0;
    clk = 0;
    AsyncClr = 1;
    #2
    d = 1;
    clk = 0;
    AsyncClr = 1;
    #8
    d = 1;
    clk = 1;
    AsyncClr = 1;
    #5
    d = 1;
    clk = 1;
    AsyncClr = 0;
    #5
    d = 1;
    clk = 0;
    AsyncClr = 0;
    #10
    d = 1;
    clk = 1;
    AsyncClr = 0;
    #5
    d = 0;
    clk = 1;
    AsyncClr = 0;
    #5
    d = 0;
    clk = 0;
    AsyncClr = 0;
    #10
    d = 0;
    clk = 1;
    AsyncClr = 0;
    #5
    d = 1;
    clk = 1;
    AsyncClr = 0;
    #5
    d = 1;
    clk = 0;
    AsyncClr = 0;
    #10
    d = 1;
    clk = 1;
    AsyncClr = 0;
    end
endmodule