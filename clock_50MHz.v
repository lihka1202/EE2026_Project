`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.02.2023 11:04:57
// Design Name: 
// Module Name: clock_50MHz
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


module clock_50MHz(
    input CLOCK,
    output reg slow_clock = 0
    );
    
    reg [31:0] COUNT = 0;
    always @ (posedge CLOCK) 
    begin
        COUNT <= (COUNT == 2)? 0 : COUNT + 1;
        slow_clock <= (COUNT == 0)? ~slow_clock : slow_clock;
    end
endmodule
