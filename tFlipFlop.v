`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.03.2023 00:56:05
// Design Name: 
// Module Name: tFlipFlop
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


module tFlipFlop(
    input t,
    input CLOCK,
    output reg q = 0
    );
    always @(posedge CLOCK)
    begin
        if (t)
            begin
            q <= ~q;
            end
    end
endmodule
