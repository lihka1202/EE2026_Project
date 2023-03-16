`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.03.2023 12:49:32
// Design Name: 
// Module Name: subtask4D
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


module subtask4D(
    input clk,
    input [12:0] pixel_index,
    input [15:0] colour_on,
    input [15:0] colour_off,
    input [10:0] sw,
    output reg [15:0] oled_data
    );
wire [6:0] x_Pindex = pixel_index % 96;
wire [5:0] y_Pindex = pixel_index / 96;
reg segA, segB, segC, segD, segE, segF, segG, greenOutline;
always @ (posedge clk)
        begin 
        segA = x_Pindex <= 44 & x_Pindex >= 14 & y_Pindex <= 15 & y_Pindex >= 10; 
        segB = x_Pindex <= 44 & x_Pindex >= 39 & y_Pindex <= 32 & y_Pindex >= 10; 
        segC = x_Pindex <= 44 & x_Pindex >= 39 & y_Pindex <= 49 & y_Pindex >= 27; 
        segD = x_Pindex <= 44 & x_Pindex >= 14 & y_Pindex <= 49 & y_Pindex >= 44; 
        segE = x_Pindex <= 19 & x_Pindex >= 14 & y_Pindex <= 49 & y_Pindex >= 27; 
        segF = x_Pindex <= 19 & x_Pindex >= 14 & y_Pindex <= 32 & y_Pindex >= 10; 
        segG = x_Pindex <= 44 & x_Pindex >= 14 & y_Pindex <= 32 & y_Pindex >= 27; 
        greenOutline = (x_Pindex > 0 &( x_Pindex % 58 == 0 | x_Pindex % 59 == 0 | x_Pindex % 60 == 0 )& y_Pindex <= 60) | (y_Pindex > 0 & (y_Pindex % 58 == 0 | y_Pindex % 59 == 0 | y_Pindex % 60 == 0) & x_Pindex <= 60);
        if (sw[10])
            begin
                oled_data <= greenOutline? 16'h07E0 : colour_off; // green outline controlled by sw10
            end
        if (sw[9] & sw[9:0] <= 10'b1111111111) 
            begin
                if (sw[10])
                begin
                    oled_data <= (greenOutline)? 16'h07E0 : 
                    (segA | segB | segC | segD | segF | segG)? 16'hFFFF : 
                    colour_off; // green outline controlled by sw10
                end else
                begin
                oled_data <= (segA | segB | segC | segD | segF | segG)? 16'hFFFF:16'h0000;
                end
            end
        else if (sw[8] & sw[9:0] <= 10'b0111111111) 
            begin
            if (sw[10])
                begin
                    oled_data <= (greenOutline)? 16'h07E0 : 
                    (segA | segB | segC | segD | segE | segF | segG)? 16'hFFFF : 
                    colour_off; // green outline controlled by sw10
                end else
                begin
                oled_data <= (segA | segB | segC | segD | segE | segF | segG)? 16'hFFFF:16'h0000;
                end
            end
        else if (sw[7] & sw[9:0] <= 10'b0011111111) 
            begin
            if (sw[10])
                begin
                    oled_data <= (greenOutline)? 16'h07E0 : 
                    (segA | segB | segC)? 16'hFFFF : 
                    colour_off; // green outline controlled by sw10
                end else 
                begin
                oled_data <= (segA | segB | segC)? 16'hFFFF:16'h0000;
                end
            end
        else if (sw[6] & sw[9:0] <= 10'b0001111111) 
            begin
            if (sw[10])
                begin
                    oled_data <= (greenOutline)? 16'h07E0 : 
                    (segA | segC | segD | segE | segF | segG)? 16'hFFFF : 
                    colour_off; // green outline controlled by sw10
                end else
                begin
                oled_data <= (segA | segC | segD | segE | segF | segG)? 16'hFFFF:16'h0000;
                end
            end
        else if (sw[5] & sw[9:0] <= 10'b0000111111) 
            begin
            if (sw[10])
                begin
                    oled_data <= (greenOutline)? 16'h07E0 : 
                    (segA | segC | segD | segF | segG)? 16'hFFFF : 
                    colour_off; // green outline controlled by sw10
                end else
                begin
                oled_data <= (segA | segC | segD | segF | segG)? 16'hFFFF:16'h0000;
                end
            end
        else if (sw[4] & sw[9:0] <= 10'b0000011111) 
            begin
            if (sw[10])
                begin
                    oled_data <= (greenOutline)? 16'h07E0 : 
                    (segB | segC | segF | segG)? 16'hFFFF : 
                    colour_off; // green outline controlled by sw10
                end else
                begin
                oled_data <= (segB | segC | segF | segG)? 16'hFFFF:16'h0000;
                end
            end        
        else if (sw[3] & sw[9:0] <= 10'b0000001111) 
            begin
            if (sw[10])
                begin
                    oled_data <= (greenOutline)? 16'h07E0 : 
                    (segA | segB | segC | segD | segG)? 16'hFFFF : 
                    colour_off; // green outline controlled by sw10
                end else
                begin
                oled_data <= (segA | segB | segC | segD | segG)? 16'hFFFF:16'h0000;
                end
            end        
        else if (sw[2] & sw[9:0] <= 10'b0000000111) 
            begin
            if (sw[10])
                begin
                    oled_data <= (greenOutline)? 16'h07E0 : 
                    (segA | segB | segD | segE | segG)? 16'hFFFF : 
                    colour_off; // green outline controlled by sw10
                end else 
                begin
                oled_data <= (segA | segB | segD | segE | segG)? 16'hFFFF:16'h0000;
                end
            end
        else if (sw[1] & sw[9:0] <= 10'b0000000011) 
            begin
            if (sw[10])
                begin
                    oled_data <= (greenOutline)? 16'h07E0 : 
                    (segB | segC)? 16'hFFFF : 
                    colour_off; // green outline controlled by sw10
                end else 
                begin
                oled_data <= (segB | segC)? 16'hFFFF:16'h0000;
                end
            end
        else if (sw[0] & sw[9:0] <= 10'b0000000001) 
            begin
            if (sw[10])
                begin
                    oled_data <= (greenOutline)? 16'h07E0 : 
                    (segA | segB | segC | segD | segE | segF)? 16'hFFFF : 
                    colour_off; // green outline controlled by sw10
                end else 
                begin
                oled_data <= (segA | segB | segC | segD | segE | segF)? 16'hFFFF:16'h0000;
                end
            end
        end
endmodule
