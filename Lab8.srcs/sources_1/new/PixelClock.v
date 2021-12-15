`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Dunwoody College of Technology
// Engineer: Antonio Veguilla Hernandez
// 
// Create Date: 11/10/2021 12:14:33 PM
// Design Name: 
// Module Name: PixelClock
// Project Name: Raycasting
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
module FPGA_Interface(clk,led,JB,btnC, vgaRed, vgaGreen,vgaBlue, Hsync, Vsync, sw);
input clk;
input btnC;
input [15:0]sw;
output [3:0]vgaRed;
output [3:0]vgaBlue;
output [3:0]vgaGreen;
output Hsync, Vsync;
output [15:0]led;
input [0:0]JB;

PixelClock(clk, clk_25MHz);

SyncSignals(clk, btnC, Hcount, Vcount, Hsync, Vsync, DE);
wire [9:0]Hcount, Vcount;
wire DE;

async_receiver(clk, JB[0], Rx_Data_Ready, Rx_DataIn);
wire [7:0]Rx_DataIn;
wire Rx_Data_Ready;
assign led[8]=Rx_Data_Ready;
assign led[7:0]=Rx_DataIn;

Looker_Upper(clk,Hcount,Vcount,HeightAndColorData,sw[15:0],RGB_color,Hcount_Out);
wire [11:0]RGB_color;
reg [11:0]Ceiling_RGB;
reg [11:0]Floor_RGB;
wire [9:0]Hcount_Out;
wire [19:0]HeightAndColorData;
assign vgaRed = (DE) ?  0 : RGB_color[11:8];//was sw[3:0]
assign vgaGreen = (DE) ?  0 : RGB_color[7:4]; //was sw[11:8]
assign vgaBlue = (DE) ?  0 : RGB_color[3:0]; //was sw[7:4]

////////////////////////////////////////////////////////////
receiver myrecvr(Rx_DataIn, Rx_Data_Ready, Address_out, Data_out, write_Enable);
wire [19:0]Data_out;
wire [9:0]Address_out;
wire write_Enable;
////////////////////////////////////////////////////////////
blk_mem_gen_0 myBram (
  
  //PORTA is for serial interface writting
  .clka(clk),    // input wire clka
  .wea(write_Enable),      // input wire [0 : 0] wea
  .addra(Address_out),  // input wire [9 : 0] addra
  .dina(Data_out),    // input wire [19 : 0] dina
  
  //PORTB is for Looker Upper to read data out
  .clkb(clk),    // input wire clkb
  .addrb(Hcount),  // input wire [9 : 0] addrb
  .doutb(HeightAndColorData)  // output wire [19 : 0] doutb
);

///////////////////////////////////////////////////////////
endmodule //end of FPGA Interface module
//////////////////////////////////////////////////////////////////////////
module Looker_Upper(
input clk,
input [9:0]Hcount_In,
input [9:0]Vcount,
input [19:0]HeightAndColorData,
input [15:0]switches,
output reg [11:0]RGB_color,
output Hcount_Out
);

reg [11:0]Ceiling_RGB = 12'b000011111111; //DEFAULT light blue color for the ceiling//
reg [11:0]Floor_RGB = 12'b100001110011; //DEFAULT sand color for the floor//

always @(posedge clk)begin
    if(switches[15] == 1) Floor_RGB <= switches[11:0];
    if(switches[14] == 1) Ceiling_RGB <= switches[11:0];
end


always @(Vcount, Hcount_In)begin
    if(Vcount > 240)begin
        if(Vcount - 240 < HeightAndColorData[19:12])begin
            RGB_color <= HeightAndColorData[11:0];
        end
        else RGB_color <= Floor_RGB;
            //else RGB_color <= 12'b100001110011; //sand color for the floor//
    end
    else begin
        if(240 - Vcount < HeightAndColorData[19:12]) RGB_color <= HeightAndColorData[11:0];
        else RGB_color <= Ceiling_RGB;
            //else RGB_color <= 12'b000011111111; //light blue color for the ceiling//
    end
        
    end
    
endmodule
//////////////////////////////////////////////////////////////////////////
module receiver(
input [7:0]Rx_DataIn,
input Rx_Data_Ready,
output reg[9:0]Address_out,
output reg[19:0]Data_out,
output reg write_Enable
);
reg [7:0]cksum;
reg [2:0]state = 0;

always @(posedge Rx_Data_Ready)begin
    case(state)
        0:begin
            write_Enable = 1;
            cksum <= 0;
            if(Rx_DataIn == 0) state = 1;
            //else keep state at 0.
        end
        1:begin
            Address_out[7:0] <= Rx_DataIn;
            cksum <= cksum^Rx_DataIn;
            state = 2;
        end
        2:begin
            Address_out[9:8] <= Rx_DataIn;
            cksum <= cksum^Rx_DataIn;
            state = 3;
        end
        3:begin
            Data_out[19:12] <= Rx_DataIn;
            cksum <= cksum^Rx_DataIn;
            state = 4;
        end
        4:begin
            Data_out[7:0] <= Rx_DataIn;
            cksum <= cksum^Rx_DataIn;
            state = 5;
        end
        5:begin
            Data_out[11:8] <= Rx_DataIn;
            state = 6;    
        end
         6:begin
            if(Rx_DataIn == cksum) write_Enable <= 0;
            state = 0; 
        end
    endcase
end

endmodule
//////////////////////////////////////////////////////////////////////////
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

assign DE = ~(Hcount <= 639 && Vcount <= 479);
assign HSYNC = ~(Hcount >= 655 && Hcount < 751);
assign VSYNC = ~(Vcount >= 489 && Vcount < 491);


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
                Vcount <= (Vcount == 524) ? 0 : Vcount + 1;
            end
        end    
    end
endmodule

/////////////////////////////////////////////////////////
module async_receiver(
	input clk,
	input RxD,
	output reg RxD_data_ready = 0,
	output reg [7:0] RxD_data = 0  // data received, valid only (for one clock cycle) when RxD_data_ready is asserted
);

parameter Baud = 921600; //was: 115200
parameter Oversampling = 16;  // needs to be a power of 2
// we oversample the RxD line at a fixed rate to capture each RxD data bit at the "right" time
// 8 times oversampling by default, use 16 for higher quality reception

//generate
	//if(ClkFrequency<Baud*Oversampling) ASSERTION_ERROR PARAMETER_OUT_OF_RANGE("Frequency too low for current Baud rate and oversampling");
	//if(Oversampling<8 || ((Oversampling & (Oversampling-1))!=0)) ASSERTION_ERROR PARAMETER_OUT_OF_RANGE("Invalid oversampling value");
//endgenerate

////////////////////////////////
reg [3:0] RxD_state = 0;
parameter ClkFrequency = 100000000;

wire OversamplingTick;
BaudTickGen #(ClkFrequency, Baud, Oversampling) tickgen(.clk(clk), .enable(1'b1), .tick(OversamplingTick));

// synchronize RxD to our clk domain
reg [1:0] RxD_sync = 2'b11;
always @(posedge clk) 
    if(OversamplingTick)
        RxD_sync <= {RxD_sync[0], RxD};

// and filter it
reg [1:0] Filter_cnt = 2'b11;
reg RxD_bit = 1'b1;

always @(posedge clk)
if(OversamplingTick)
begin
	if(RxD_sync[1]==1'b1 && Filter_cnt!=2'b11) Filter_cnt <= Filter_cnt + 1'd1;
	else 
	if(RxD_sync[1]==1'b0 && Filter_cnt!=2'b00) Filter_cnt <= Filter_cnt - 1'd1;

	if(Filter_cnt==2'b11) RxD_bit <= 1'b1;
	else
	if(Filter_cnt==2'b00) RxD_bit <= 1'b0;
end

// and decide when is the good time to sample the RxD line
function integer log2(input integer v); begin log2=0; while(v>>log2) log2=log2+1; end endfunction
localparam l2o = log2(Oversampling);
reg [l2o-2:0] OversamplingCnt = 0;
always @(posedge clk) if(OversamplingTick) OversamplingCnt <= (RxD_state==0) ? 1'd0 : OversamplingCnt + 1'd1;
wire sampleNow = OversamplingTick && (OversamplingCnt==Oversampling/2-1);

// now we can accumulate the RxD bits in a shift-register
always @(posedge clk)
case(RxD_state)
	4'b0000: if(~RxD_bit) RxD_state <= `ifdef SIMULATION 4'b1000 `else 4'b0001 `endif;  // start bit found?
	4'b0001: if(sampleNow) RxD_state <= 4'b1000;  // sync start bit to sampleNow
	4'b1000: if(sampleNow) RxD_state <= 4'b1001;  // bit 0
	4'b1001: if(sampleNow) RxD_state <= 4'b1010;  // bit 1
	4'b1010: if(sampleNow) RxD_state <= 4'b1011;  // bit 2
	4'b1011: if(sampleNow) RxD_state <= 4'b1100;  // bit 3
	4'b1100: if(sampleNow) RxD_state <= 4'b1101;  // bit 4
	4'b1101: if(sampleNow) RxD_state <= 4'b1110;  // bit 5
	4'b1110: if(sampleNow) RxD_state <= 4'b1111;  // bit 6
	4'b1111: if(sampleNow) RxD_state <= 4'b0010;  // bit 7
	4'b0010: if(sampleNow) RxD_state <= 4'b0000;  // stop bit
	default: RxD_state <= 4'b0000;
endcase

always @(posedge clk)
if(sampleNow && RxD_state[3]) RxD_data <= {RxD_bit, RxD_data[7:1]};

//reg RxD_data_error = 0;
always @(posedge clk)
begin
	RxD_data_ready <= (sampleNow && RxD_state==4'b0010 && RxD_bit);  // make sure a stop bit is received
	//RxD_data_error <= (sampleNow && RxD_state==4'b0010 && ~RxD_bit);  // error if a stop bit is not received
end


endmodule


////////////////////////////////////////////////////////
// dummy module used to be able to raise an assertion in Verilog
module ASSERTION_ERROR();
endmodule


////////////////////////////////////////////////////////
module BaudTickGen(
	input clk, enable,
	output tick  // generate a tick at the specified baud rate * oversampling
);
parameter ClkFrequency = 100000000;
parameter Baud = 921600;//was:115200;
parameter Oversampling = 1;

function integer log2(input integer v); begin log2=0; while(v>>log2) log2=log2+1; end endfunction
localparam AccWidth = log2(ClkFrequency/Baud)+8;  // +/- 2% max timing error over a byte
reg [AccWidth:0] Acc = 0;
localparam ShiftLimiter = log2(Baud*Oversampling >> (31-AccWidth));  // this makes sure Inc calculation doesn't overflow
localparam Inc = ((Baud*Oversampling << (AccWidth-ShiftLimiter))+(ClkFrequency>>(ShiftLimiter+1)))/(ClkFrequency>>ShiftLimiter);
always @(posedge clk) if(enable) Acc <= Acc[AccWidth-1:0] + Inc[AccWidth:0]; else Acc <= Inc[AccWidth:0];
assign tick = Acc[AccWidth];
endmodule
////////////////////////////////////////////////////////

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
/////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////
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