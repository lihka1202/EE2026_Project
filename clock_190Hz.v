`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.02.2023 11:15:46
// Design Name: 
// Module Name: clock_190Hz
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


module clock_190Hz(
    input CLOCK,
    output reg slow_clock
    );
    
    reg [31:0] COUNT = 0;
    always @ (posedge CLOCK) 
    begin
        COUNT <= (COUNT == 263156)? 0 : COUNT + 1;
        slow_clock <= (COUNT == 0)? ~slow_clock : slow_clock;
    end
endmodule
