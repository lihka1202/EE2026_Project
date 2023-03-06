`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
//
//  FILL IN THE FOLLOWING INFORMATION:
//  STUDENT A NAME: Muthya Narayanachary Akhil
//  STUDENT B NAME:
//  STUDENT C NAME: 
//  STUDENT D NAME:  
//
//////////////////////////////////////////////////////////////////////////////////


module Top_Student (
    input clock,
    output reg [11:0] led=0,
    input J_MIC3_Pin3,
    output J_MIC3_Pin1,
    output J_MIC3_Pin4,
    input SW1
    // Delete this comment and include Basys3 inputs and outputs here
    );
    wire clk_10, clk_20k;
    wire [11:0] audio_sample;
    clock_generator clk10 (clock,4999999, clk_10);
    clock_generator clk20k (clock, 2499, clk_20k);
    reg selection_clock;
    Audio_Input audio_input(.CLK(clock), .cs(clk_20k), .MISO(J_MIC3_Pin3), .clk_samp(J_MIC3_Pin1), .sclk(J_MIC3_Pin4), .sample(audio_sample));
    
    always @(posedge clock)
    begin
        if(SW1==1)
        begin
            selection_clock <= clk_10;
        end
        
        else
        begin
            selection_clock <= clk_20k;
        end
    end
    
    always @ (posedge selection_clock)
    begin
        led[11:0] <= audio_sample[11:0];
    end
endmodule