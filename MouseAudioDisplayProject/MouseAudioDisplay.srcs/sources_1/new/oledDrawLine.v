`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.03.2023 10:33:50
// Design Name: 
// Module Name: oledDrawLine
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


module oledDrawRect(
    input clk,
    input [12:0] pixel_index,
    input [12:0] rect_PixIndexA,
    input [12:0] rect_PixindexB,
    input [15:0] colour_on,
    input [15:0] colour_off,
    input swON,
    output reg [15:0] oled_data
    );
wire [6:0] x_Pindex = pixel_index % 96;
wire [5:0] y_Pindex = pixel_index / 96;
//wire [6:0] x_indexB = pixel_indexB % 96;
//wire [5:0] y_indexB = pixel_indexB / 96;
wire [6:0] x_indexSmall = (rect_PixIndexA % 96 < rect_PixindexB % 96)? rect_PixIndexA % 96 : rect_PixindexB % 96;
wire [5:0] y_indexSmall = (rect_PixIndexA / 96 < rect_PixindexB / 96)? rect_PixIndexA / 96 : rect_PixindexB / 96;
wire [6:0] x_indexBig = (rect_PixIndexA % 96 < rect_PixindexB % 96)? rect_PixindexB % 96 : rect_PixIndexA % 96;
wire [5:0] y_indexBig = (rect_PixIndexA / 96 < rect_PixindexB / 96)? rect_PixindexB / 96 : rect_PixIndexA / 96;
always @ (posedge clk)
        begin
        if (x_Pindex <= x_indexBig & x_Pindex >= x_indexSmall & y_Pindex <= y_indexBig & y_Pindex >= y_indexSmall) 
        begin
            oled_data <= (swON)? colour_on : colour_on;
        end
        else begin
            oled_data <= (swON)? colour_off : colour_off;
        end
        end
endmodule
