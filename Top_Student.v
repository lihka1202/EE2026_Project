`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
//
//  FILL IN THE FOLLOWING INFORMATION:
//  STUDENT A NAME: 
//  STUDENT B NAME: LIM HONG YAO
//  STUDENT C NAME: 
//  STUDENT D NAME:  
//
//////////////////////////////////////////////////////////////////////////////////

module Top_Student (
    input CLOCK, BTNC,
    output D1, D2, CLK_OUT, nSYNC
    );
    wire DONE;
    wire clk50MHz; wire clk20kHz;
    wire [11:0] audio_out;
    wire q;
    
    clock_universal clock50MHz (.CLOCK(CLOCK),.m(2), .SLOW_CLOCK(clk50MHz));
    clock_20kHz clock20kHz (.CLOCK(CLOCK), .slow_clock(clk20kHz));
    audioOutSignal audioSignal(.CLOCK(CLOCK), .m(263156), .audioOn(q), .SLOW_CLOCK(audio_out[11]));
    
    tFlipFlop tff(.t(BTNC),.CLOCK(CLOCK),.q(q));
    
    Audio_Output audioout(.CLK(clk50MHz),.START(clk20kHz),.DATA1(audio_out),
    .DATA2(audio_out),.RST(1'b0),.D1(D1),.D2(D2),.CLK_OUT(CLK_OUT),.nSYNC(nSYNC),
    .DONE(DONE));
   

endmodule