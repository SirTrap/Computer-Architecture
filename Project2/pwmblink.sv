module pwmblink(
    input  logic clk,
    output logic RGB_R,
    output logic RGB_B,
    output logic RGB_G
);

    parameter CLKMAX = 12000000; // 12000000 time steps per second

    logic [31:0] counter = 0; 
    logic [8:0] x = 0; // This is the parameter for the PWM output
    logic [7:0] sharktooth = 0; // Creates a sharktooth signal to determine the duty cycle

    //8-bit values for the LED states (between 0-255)
    logic [7:0] red;
    logic [7:0] green;
    logic [7:0] blue;

    always_ff @(posedge clk) begin
        //Every 12M/360 time steps increase the x by 1
        if (counter >= CLKMAX/360) begin
            
            counter <= 0;

            if (x >= 359) begin
                x <= 0;
            end
            else begin
                x <= x + 1;
            end
            end
        else begin
            counter <= counter + 1;
        end
        
        //Shark tooth signal
        sharktooth <= sharktooth + 1;
    end

    //Combinational Logic for red, green and blue LEDs
    always_comb begin
        if(x < 60) begin
            green = 255*x/60;
            blue = 0;
            red  = 255;
        end else if (x < 120) begin
            green = 255;
            blue = 0;
            red  = 255 - 255*(x-60)/60;
        end else if (x < 180) begin
            green = 255;
            blue = 255*(x-120)/60;
            red  = 0;
        end else if (x < 240) begin
            green = 255 - 255*(x-180)/60;
            blue = 255;
            red  = 0;
        end else if (x < 300) begin
            green = 0;
            blue = 255;
            red  = 255*(x-240)/60;
        end else begin
            green = 0;
            blue = 255 - 255*(x-300)/60;
            red  = 255;
        end
    end
   
    //Assigning high or low to the RGB values
    assign {RGB_R, RGB_G, RGB_B} = {sharktooth < red, sharktooth < green, sharktooth < blue};

    
endmodule

