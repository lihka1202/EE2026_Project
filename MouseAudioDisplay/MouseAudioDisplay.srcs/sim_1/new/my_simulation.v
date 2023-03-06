`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/27/2023 09:37:24 AM
// Design Name: 
// Module Name: my_simulation
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


module my_simulation(
    );
    reg clock;
    reg led;
    reg [31:0] count;
    Top_Student dut(clock,led);
    initial begin
        clock <= 0;
        led <= 0;
        count <= 0;
    end
    always begin
            #5 clock = ~clock;
    end
    always @ (posedge clock) begin
        count <= count+1;
        led <= (count == 2499) ? ~led : led ;
    end
endmodule
