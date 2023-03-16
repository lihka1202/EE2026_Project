`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.02.2023 09:35:39
// Design Name: 
// Module Name: clk_div_sim
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


module clk_div_sim();
    reg CLOCK;
    wire my_clock_out;
    clk_divider sim_div(CLOCK,my_clock_out, 1);
    initial begin
        CLOCK = 0;
    end
    always begin
        #5 CLOCK = ~CLOCK;
    end
endmodule
