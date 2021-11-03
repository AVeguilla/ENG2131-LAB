`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Dunwoody College of Technology
// Engineer: Antonio Veguilla Hernandez
// 
// Create Date: 09/15/2021 12:16:47 PM
// Design Name: 
// Module Name: Blinky
// Project Name: Lab3_Part1 & Part2
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


module Blinky(
    input clk,
    output led0,    //declaring led0 from the BASYS 3 board to be used as an output
    output led1,    //declaring led1 from the BASYS 3 board to be used as an output
    output led2,    //declaring led2 from the BASYS 3 board to be used as an output
    output led3     //declaring led3 from the BASYS 3 board to be used as an output
    );
    reg [25:0] count0 = 0; //creating count 0 with a bit count of 0-25 = 2^26 = 67108864
    reg [24:0] count1 = 0; //creating count 1 with a bit count of 0-24 = 2^25 = 33554432
    reg [24:0] count2 = 0; //creating count 2 with a bit count of 0-24 = 2^25 = 33554432
    reg [24:0] count3 = 0; //creating count 3 with a bit count of 0-24 = 2^25 = 33554432
    
    reg led0reg = 0; //creating led0reg and initializing it by setting to 0.
    reg led1reg = 0; //creating led1reg and initializing it by setting to 0.
    reg led2reg = 0; //creating led2reg and initializing it by setting to 0.
    reg led3reg = 0; //creating led3reg and initializing it by setting to 0.

assign led0 = led0reg; //This assign the vlaue at ledreg0 into led0;
assign led1 = led1reg; //This assign the vlaue at ledreg1 into led1;
assign led2 = led2reg; //This assign the vlaue at ledreg2 into led2;
assign led3 = led3reg; //This assign the vlaue at ledreg3 into led3;
 
always @ (posedge(clk)) 
begin
if(count0 == 50000000) //1Hz blink 
    begin
    count0 <= 0; //This will reset the variable count0 to 0.
    led0reg <= !led0reg; //This will toggle the value located at led0reg.
    end
else
    begin
    count0 <= count0 + 1; //This keep the counter counting
    end
if(count1 == 12500000) //4Hz Blink
    begin
    count1 <= 0;//This will reset the variable count1 to 0.
    led1reg <= !led1reg; //This will toggle the value located at led1reg.
    end
else
    begin
    count1 <= count1 + 1; //This keep the counter counting
    end
if(count2 == 10000000) //5Hz Blink
    begin
    count2 <= 0;//This will reset the variable count2 to 0.
    led2reg <= !led2reg; //This will toggle the value located at led2reg.
    end
else
    begin
    count2 <= count2 + 1; //This keep the counter counting
    end
if(count3 == 7142857) //7Hz Blink
    begin
    count3 <= 0;//This will reset the variable count3 to 0.
    led3reg <= !led3reg; //This will toggle the value located at led3reg.
    end
else
    begin
    count3 <= count3 + 1; //This keep the counter counting
    end

end
endmodule
