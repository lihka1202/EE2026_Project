`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.03.2023 10:05:14
// Design Name: 
// Module Name: btnStateDelay
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


module btnStateDelay(input BTNC, CLOCK, input wire [31:0] m, output wire btnState);
    reg [31:0] COUNT = 0;


    dFlipFlop d_ff (.CLK(CLOCK),.d(BTNC),.q(btnState));

    
endmodule
