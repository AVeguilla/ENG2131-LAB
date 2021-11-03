`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/07/2021 06:47:49 PM
// Design Name: 
// Module Name: DFFwithSyncClear
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


module DFFwithSyncClear(
    input clk,
    input d,
    input syncClr,
    output q,
    output qn
    );
    
    reg q;
    
    always @(posedge clk)
    begin
        if(~syncClr)
            begin
                q <= 0;
            end
        else
            begin
                q <= d;
            end
        
    end
        
    assign qn = ~q;
    
endmodule

module testbench_DFFwithSyncClear;
    reg clk, d, syncClr;
    wire q, qn;
    
    DFFwithSyncClear dut(clk, d, syncClr, q, qn);
    initial begin
    d = 0;
    clk = 1;
    syncClr = 1;
    #8
    d = 1;
    clk = 1;
    syncClr = 1;
    #2
    d = 1;
    clk = 0;
    syncClr = 1;
    #10
    d = 1;
    clk = 1;
    syncClr = 1;
    #2
    d = 0;
    clk = 1;
    syncClr = 1;
    #8
    d = 0;
    clk = 0;
    syncClr = 1;
    #2
    d = 1;
    clk = 0;
    syncClr = 1;
    #8
    d = 1;
    clk = 1;
    syncClr = 0;
    #5
    d = 1;
    clk = 1;
    syncClr = 0;
    #5
    d = 1;
    clk = 0;
    syncClr = 0;
    #10
    d = 1;
    clk = 1;
    syncClr = 0;
    #5
    d = 0;
    clk = 1;
    syncClr = 0;
    #5
    d = 0;
    clk = 0;
    syncClr = 0;
    #10
    d = 0;
    clk = 1;
    syncClr = 0;
    #5
    d = 1;
    clk = 1;
    syncClr = 0;
    #5
    d = 1;
    clk = 0;
    syncClr = 0;
    #10
    d = 1;
    clk = 1;
    syncClr = 0;
    end
endmodule