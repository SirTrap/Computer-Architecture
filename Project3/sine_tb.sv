`timescale 10ns/10ns
`include "sine.sv"

module sine_tb;

    logic clk;
    logic _9b, _6a, _4a, _2a, _0a, _5a, _3b, _49a, _45a, _48b;

    //Creating an instance of the sine
    sine sine_inst (
        .clk    (clk), 
        ._9b    (_9b), 
        ._6a    (_6a), 
        ._4a    (_4a), 
        ._2a    (_2a), 
        ._0a    (_0a), 
        ._5a    (_5a), 
        ._3b    (_3b), 
        ._49a   (_49a), 
        ._45a   (_45a), 
        ._48b   (_48b)
    );

    initial begin
        // Waveform file:
        $dumpfile("sine_tb.vcd");
        $dumpvars(1, sine_inst);
        // 1 second
        #100000000;
        $finish;
    end
    
    initial begin
        clk = 0;
        forever #4 clk = ~clk;
    end

endmodule