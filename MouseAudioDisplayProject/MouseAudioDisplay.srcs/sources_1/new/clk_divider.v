`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.02.2023 09:28:23
// Design Name: 
// Module Name: clk_divider
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


module clk_divider(
    input CLOCK,
    output reg my_clock_out = 0,
    input [31:0] m
    );
    reg [31:0] count0 = 1;
    always @ (posedge CLOCK) begin
    count0 <= (count0 == m)? 0 : count0 + 1;
    my_clock_out <= (count0 == 0)? ~my_clock_out : my_clock_out;
    end
endmodule
