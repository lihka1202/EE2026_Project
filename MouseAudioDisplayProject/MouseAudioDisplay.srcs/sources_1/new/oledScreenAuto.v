`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.03.2023 16:13:51
// Design Name: 
// Module Name: oledScreenAuto
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


module oledScreenAuto(
    input btnU,
    input btnD,
    input btnL,
    input btnR,
    input clk,
    input [12:0] pixel_index,
    input [15:0] colour_on,
    input [15:0] colour_off,
    input [10:0] sw,
    output reg [15:0] oled_data,
    input [3:0] state
    );
wire [7:0] x_Pindex = pixel_index % 96;
wire [7:0] y_Pindex = pixel_index / 96;
reg segA, segB, segC, segD, segE, segF, segG, greenOutline;

reg [7:0] ballTopLeftX = 45, ballTopLeftY = 30;
reg ballPixel; 
reg [5:0] layer;
reg [31:0] ballCounter = 0;
always @ (posedge clk)
        begin 
        ballCounter <= (ballCounter == 5000000)? 0 : ballCounter + 1 ;
        
        segA = x_Pindex <= 44 & x_Pindex >= 14 & y_Pindex <= 15 & y_Pindex >= 10; 
        segB = x_Pindex <= 44 & x_Pindex >= 39 & y_Pindex <= 32 & y_Pindex >= 10; 
        segC = x_Pindex <= 44 & x_Pindex >= 39 & y_Pindex <= 49 & y_Pindex >= 27; 
        segD = x_Pindex <= 44 & x_Pindex >= 14 & y_Pindex <= 49 & y_Pindex >= 44; 
        segE = x_Pindex <= 19 & x_Pindex >= 14 & y_Pindex <= 49 & y_Pindex >= 27; 
        segF = x_Pindex <= 19 & x_Pindex >= 14 & y_Pindex <= 32 & y_Pindex >= 10; 
        segG = x_Pindex <= 44 & x_Pindex >= 14 & y_Pindex <= 32 & y_Pindex >= 27; 
        greenOutline = (x_Pindex > 0 &( x_Pindex % 58 == 0 | x_Pindex % 59 == 0 | x_Pindex % 60 == 0 )& y_Pindex <= 60) | (y_Pindex > 0 & (y_Pindex % 58 == 0 | y_Pindex % 59 == 0 | y_Pindex % 60 == 0) & x_Pindex <= 60);
        
        
        //ballTopLeftY <= (btnU & (ballCounter == 0) & ballTopLeftY >= 1)? ballTopLeftY - 1 : (btnU & (ballCounter == 0) & ballTopLeftY == 0)? 60 :
        //                (btnD & (ballCounter == 0) & ballTopLeftY <= 60)? ballTopLeftY + 1 :(btnD & (ballCounter == 0) & ballTopLeftY == 61)? 0: ballTopLeftY;
        //ballTopLeftX <= (btnL & (ballCounter == 0) & (ballTopLeftX >= 1))? ballTopLeftX - 1 : (btnL & (ballCounter == 0) & (ballTopLeftX == 0))? 92 :                
        //                (btnR & (ballCounter == 0) & (ballTopLeftX <= 91))? ballTopLeftX + 1 :(btnR & (ballCounter == 0) & (ballTopLeftX == 92))? 0: ballTopLeftX;
                
        layer[5] = x_Pindex >= ballTopLeftX + 2 & x_Pindex <= ballTopLeftX + 3 & y_Pindex == ballTopLeftY - 2;
        layer[4] = x_Pindex >= ballTopLeftX + 1 & x_Pindex <= ballTopLeftX + 4 & y_Pindex == ballTopLeftY - 1;
        layer[3] = x_Pindex >= ballTopLeftX & x_Pindex <= ballTopLeftX + 5 & y_Pindex == ballTopLeftY;
        layer[2] = x_Pindex >= ballTopLeftX & x_Pindex <= ballTopLeftX + 5 & y_Pindex == ballTopLeftY + 1;
        layer[1] = x_Pindex >= ballTopLeftX + 1 & x_Pindex <= ballTopLeftX + 4 & y_Pindex == ballTopLeftY + 2;
        layer[0] = x_Pindex >= ballTopLeftX + 2 & x_Pindex <= ballTopLeftX + 3 & y_Pindex == ballTopLeftY + 3;
        
        ballPixel = layer[0] | layer[1] | layer[2] | layer[3] | layer[4] | layer[5];
        if(state == 11)
        begin
        oled_data <= (ballPixel)? colour_on:16'h0000;
        //if ((ballCounter == 0))
        begin
            if( btnU )begin
                ballTopLeftY <= (ballTopLeftY >= 1)? ballTopLeftY - 1 : 60;
            end
            
            if( btnD )begin
                ballTopLeftY <= (ballTopLeftY <= 60)? ballTopLeftY + 1 : 0;
            end
            if( btnL )begin
                ballTopLeftX <= (ballTopLeftX >= 1)? ballTopLeftX - 1 : 92;
            end 
            if( btnR )begin
                ballTopLeftX <= (ballTopLeftX <= 91)? ballTopLeftX + 1 : 0;
            end
        end 
        end
        
        
        if(state == 10)
        begin
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
            end//state == 10
            if (state <= 9)
            begin
            if (sw[10])
                        begin
                            oled_data <= greenOutline? 16'h07E0 : colour_off; // green outline controlled by sw10
                        end
                    if (state == 9) 
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
                    else if (state == 8) 
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
                    else if (state == 7) 
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
                    else if (state == 6) 
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
                    else if (state == 5) 
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
                    else if (state == 4) 
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
                    else if (state == 3) 
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
                    else if (state == 2) 
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
                    else if (state == 1) 
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
                    else if (state == 0) 
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
            end// state <=9
        end
endmodule