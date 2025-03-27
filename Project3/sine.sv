module sine(
    input  logic clk,
    output logic _9b, //D0
    output logic _6a, //D1
    output logic _4a, //D2
    output logic _2a, //D3
    output logic _0a, //D4
    output logic _5a, //D5
    output logic _3b, //D6
    output logic _49a, //D7
    output logic _45a, //D8
    output logic _48b //D9
);


    logic [8:0] timef = 0; 
    //Memory Cell for 128 10-bit value storage
    logic [9:0] memory [0:127];
    logic [9:0] outputa;

    //Copying the contents of the sine file into the memory cells
    initial begin 
        $readmemh("newsine.txt", memory);
    end

    //Time logic for operating from 0 to 512
    always_ff @(posedge clk) begin
        timef <= (timef == 511) ? 0 : timef + 1;
    end

    //Combinational Logic to find the sinewave region and compute the corresponding output
    always_comb begin
        if(timef < 128) begin
            outputa = memory[timef];
        end else if (timef < 256) begin
            outputa = memory[127 - (timef - 128)];
        end else if (timef < 384) begin
            outputa = 1024 - memory[(timef - 256)];
        end else begin
            outputa = 1024 - memory[127 - (timef - 384)];
        end
    end
   
    //Assigning the output pin values to the 10 corresponding pins
    assign {_48b, _45a, _49a, _3b, _5a, _0a, _2a, _4a, _6a, _9b} = outputa[9:0];

    
endmodule

