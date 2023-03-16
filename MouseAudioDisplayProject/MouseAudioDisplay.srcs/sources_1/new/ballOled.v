`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.03.2023 16:41:17
// Design Name: 
// Module Name: ballOled
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


module ballOled(
    input clk,
    input [12:0] pixel_index,
    input [15:0] colour_on,
    input [15:0] colour_off,
    output reg [15:0] oled_data,
    input [3:0] state
    );
    wire [7:0] x_Pindex = pixel_index % 96;
    wire [7:0] y_Pindex = pixel_index / 96;
    reg [7:0] ballTopLeftX = 45, ballTopLeftY = 24;
    
    reg ballPixel; 
    reg [5:0] layer;
    
    
    always @ (*)
    begin
    layer[5] = x_Pindex >= ballTopLeftX + 2 & x_Pindex <= ballTopLeftX + 3 & y_Pindex == ballTopLeftY - 2;
    layer[4] = x_Pindex >= ballTopLeftX + 1 & x_Pindex <= ballTopLeftX + 4 & y_Pindex == ballTopLeftY - 1;
    layer[3] = x_Pindex >= ballTopLeftX & x_Pindex <= ballTopLeftX + 5 & y_Pindex == ballTopLeftY;
    layer[2] = x_Pindex >= ballTopLeftX & x_Pindex <= ballTopLeftX + 5 & y_Pindex == ballTopLeftY + 1;
    layer[1] = x_Pindex >= ballTopLeftX + 1 & x_Pindex <= ballTopLeftX + 4 & y_Pindex == ballTopLeftY + 2;
    layer[0] = x_Pindex >= ballTopLeftX + 2 & x_Pindex <= ballTopLeftX + 3 & y_Pindex == ballTopLeftY + 3;
    ballPixel = layer[0] & layer[1] & layer[2] & layer[3] & layer[4] & layer[5];
    
    if(state == 11)
    begin
    oled_data <= (ballPixel)? colour_on:16'h0000;
    end
    end
    
endmodule
