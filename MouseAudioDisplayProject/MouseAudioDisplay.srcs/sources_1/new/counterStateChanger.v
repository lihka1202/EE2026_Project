`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.03.2023 16:06:20
// Design Name: 
// Module Name: counterStateChanger
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


module counterStateChanger(
    input CLOCK,
    output reg [3:0] state = 10,
    input [15:14]sw
    );
    integer countThree = 0;
    always @ (posedge CLOCK)
    begin
    countThree <= (sw[15] & countThree != 299999999)? countThree + 1 : 0;
    if(~sw[15])
    begin
    state <= 10;
    countThree <= 0;
    end
    if(~sw[15] & sw[14])
    begin
    state <= 11;
    countThree <= 0;
    end
    if(countThree == 299999999)
    begin
    //countThree <= ((sw15))? 299999999:0;
    state <= ((sw[15]) & (state >= 1))? state - 1: (state == 0)? 9 : state;
    end
    end
endmodule

