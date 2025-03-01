`timescale 1ns/1ns
`include "pwmblink.sv"

module pwmblink_tb;

    logic clk;
    logic RGB_R, RGB_G, RGB_B;

    //Creating an instance of the pwmblink
    pwmblink pwm_inst (
        .clk(clk),
        .RGB_R(RGB_R),
        .RGB_G(RGB_G),
        .RGB_B(RGB_B)
    );

    initial begin
        // Waveform file:
        $dumpfile("pwmblink_tb.vcd");
        $dumpvars(1, pwm_inst);
        // 1 second
        #1000000000;
        $finish;
    end
    
    initial begin
        clk = 0;
        forever #41.66 clk = ~clk;
    end

endmodule
