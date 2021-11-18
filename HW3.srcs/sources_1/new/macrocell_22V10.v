`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/16/2021 03:33:05 PM
// Design Name: 
// Module Name: macrocell_22V10
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


module macrocell_22V10(
    input clk,
    input s0,
    input s1,
    input sp,
    input ar,
    input d,
    input buf_out,
    output out,
    output fb
    );
    reg q = 0;
    reg qn;
    
    always @(posedge ar)
        begin
        q = 0;
        qn <= ~q;
        end
    
    always @(posedge clk)
        begin
            if(ar == 1 && sp == 1)
                begin
                q <= 0;
                qn <= ~q;
                end
            else if(ar == 0 && sp == 1)
                begin
                q <= 1;
                qn <= ~q;
                end
            else if (ar == 0 && sp == 0)
                begin
                q <= d;
                qn <= ~q;
                end
        end
    
    assign out = (s1) ? (s0 ? !d : d) : ( s0 ? qn : q);
    
    assign fb = (s1) ? buf_out : qn;
       
endmodule

module macrocell_22V10_tb();
    reg clk = 0, s0 = 0, s1 = 0, sp = 0, ar = 0, d = 0, buf_out = 0;
    wire out, fb;
    
    macrocell_22V10 dut(clk,s0,s1,sp,ar,d,buf_out, out, fb);
    
    always begin
    clk = ~clk;
    #1;
    end
    
    initial begin
    d = 0;
    ar = 0;
    sp = 0;
    s0 = 0;
    s1 = 0;
    buf_out = 0;
    #10
    d = 1;
    s1 = 1;
    #10
    s0 = 0;
    s1 = 0;
    #5
    d = 0;
    #5
    sp = 1;
    #11
    ar = 1;
    #10
    sp = 0;
    ar = 0;
    #5
    s0 = 1;
    #10;
    end
    
    
endmodule