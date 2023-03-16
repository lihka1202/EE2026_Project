`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.03.2023 18:06:34
// Design Name: 
// Module Name: GreenOutline
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


module GreenOutline(input clk, input [12:0] pixel_index, input swON, inout [15:0] oled_data);
    reg [15:0] green_data = 16'h07E0;
    oledDrawRect vertGreen(.clk(clk),
        .pixel_index(pixel_index),
        .rect_PixIndexA(58),
        .rect_PixindexB(5626),
        .colour_on(green_data),
        .colour_off(16'h0000),
        .swON(swON),
        .oled_data(oled_data)
        );
endmodule
