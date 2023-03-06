`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.02.2023 11:25:49
// Design Name: 
// Module Name: clock_universal
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


module clock_universal(
    input CLOCK,
    input wire [31:0] m,
    output reg SLOW_CLOCK = 0
    );
    reg [31:0] COUNT = 0;
    always @ (posedge CLOCK) 
    begin
        COUNT <= (COUNT == m)? 0 : COUNT + 1;
        SLOW_CLOCK <= (COUNT == 0)? ~SLOW_CLOCK : SLOW_CLOCK;
    end
endmodule
