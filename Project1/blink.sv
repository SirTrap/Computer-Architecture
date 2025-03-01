module top(
    input  logic clk,
    output logic RGB_R,
    output logic RGB_B,
    output logic RGB_G
);

    // CLK frequency is 12MHz, so 12,000,000 cycles is 1s, so 2,000,000 is 6 blinks per second
    parameter BLINK_INTERVAL = 2000000;

    logic [31:0] counter;

    logic [2:0] state = 3'b100;

    always_ff @(posedge clk) begin
        if (counter >= BLINK_INTERVAL) begin
            counter <= 0;

            state <= ~state;
            state <= (state << 1) | state[2];
            {RGB_R, RGB_G, RGB_B} <= state; 

            end
        else begin
            counter <= counter + 1;
        end
    end
    
endmodule

