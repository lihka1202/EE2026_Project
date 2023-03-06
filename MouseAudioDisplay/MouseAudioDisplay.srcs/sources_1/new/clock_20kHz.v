`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/27/2023 11:16:57 AM
// Design Name: 
// Module Name: clock_20kHz
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


module clock_generator(
    input clock,
    wire [31:0] m,
    output reg led
    );
    reg [31:0] counter = 0;
    reg slow_clock = 0;
    //assign led = slow_clock;
    always @ (posedge clock)
        begin
            counter <= (counter == m) ? 0 : counter + 1;
            led <= (counter == 0) ? ~led : led;
        end
    
endmodule
