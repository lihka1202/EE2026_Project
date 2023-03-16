`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
//
//  FILL IN THE FOLLOWING INFORMATION:
//  STUDENT A NAME: 
//  STUDENT B NAME:
//  STUDENT C NAME: 
//  STUDENT D NAME: Linus Puah
//
//////////////////////////////////////////////////////////////////////////////////


module Top_Student (input [15:0] sw, input btnU,
    input btnD,
    input btnL,
    input btnR, input CLOCK, output [7:0] JB);
    wire clk25m, clk6p25m, frame_begin, sending_pixels, sample_index;
    wire [12:0] pixel_index;
    reg [15:0] green_data = 16'h07E0;
    reg [15:0] blue_data = 16'b0000000000011111;
    reg [15:0] red_data = 16'b1111100000000000;
    reg [15:0] white_data = 16'hFFFF;
    reg [15:0] purple_data = 16'b1111100000011111;
    wire [15:0] oled_data, oled_greenLine, oled_rect;
    clk_divider clk_unit_oled(.CLOCK(CLOCK),.my_clock_out(clk6p25m), .m(7));
    clk_divider clk_unit_pixelInd(.CLOCK(CLOCK),.my_clock_out(clk25m), .m(1));
    
    Oled_Display oled_unit(.clk(clk6p25m), .reset(0), .frame_begin(frame_begin), 
        .sending_pixels(sending_pixels),.sample_pixel(sample_index), .pixel_index(pixel_index), 
        .pixel_data(oled_data), .cs(JB[0]), .sdin(JB[1]), .sclk(JB[3]), 
        .d_cn(JB[4]), .resn(JB[5]), .vccen(JB[6]), .pmoden(JB[7]));
    
    
    subtask4D task4D(.clk(clk25m),
            .pixel_index(pixel_index),
            .colour_on(green_data),
            .colour_off(16'h0000),
            .sw(sw),
            .oled_data(oled_data));
            
endmodule