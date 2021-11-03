`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/06/2021 08:53:48 AM
// Design Name: 
// Module Name: Lab4_Part3_4
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


module Lab4_Part3_4(
    input clk,
    input d,
    input clrN,
    output q,
    output qn
    );
    
    //reg clk,d;
    reg q;
    
    always @(posedge clk or negedge clrN)
    begin
        if(~clrN)
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

module testbench_Lab4_Part3_4;
    reg clk, d, clrN;
    wire q, qn;
    
    Lab4_Part3_4 dut(clk, d, clrN, q, qn);
    initial begin
    d = 0;
    clk = 1;
    clrN = 1;
    #8
    d = 1;
    clk = 1;
    clrN = 1;
    #2
    d = 1;
    clk = 0;
    clrN = 1;
    #10
    d = 1;
    clk = 1;
    clrN = 1;
    #2
    d = 0;
    clk = 1;
    clrN = 1;
    #8
    d = 0;
    clk = 0;
    clrN = 1;
    #2
    d = 1;
    clk = 0;
    clrN = 1;
    #8
    d = 1;
    clk = 1;
    clrN = 1;
    #5
    d = 1;
    clk = 1;
    clrN = 0;
    #5
    d = 1;
    clk = 0;
    clrN = 0;
    #10
    d = 1;
    clk = 1;
    clrN = 0;
    #5
    d = 0;
    clk = 1;
    clrN = 0;
    #5
    d = 0;
    clk = 0;
    clrN = 0;
    #10
    d = 0;
    clk = 1;
    clrN = 0;
    #5
    d = 1;
    clk = 1;
    clrN = 0;
    #5
    d = 1;
    clk = 0;
    clrN = 0;
    #10
    d = 1;
    clk = 1;
    clrN = 0;
    end
endmodule