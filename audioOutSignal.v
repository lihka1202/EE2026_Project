`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.03.2023 00:25:04
// Design Name: 
// Module Name: audioOutSignal
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


module audioOutSignal(
    input CLOCK, audioOn,
    input [31:0] m,
    output wire SLOW_CLOCK
    );
    wire outClock;
    clock_universal audio_190Hz(.CLOCK(CLOCK),.m(m),.SLOW_CLOCK(outClock));
    assign SLOW_CLOCK = (audioOn)? outClock : 0;

endmodule
