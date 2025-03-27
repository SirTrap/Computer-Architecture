module sine(
    input  logic clk,
    output logic _9b,
    output logic _6a,
    output logic _4a,
    output logic _2a,
    output logic _0a,
    output logic _5a,
    output logic _3b,
    output logic _49a,
    output logic _45a,
    output logic _48b
);

    logic [8:0] timef = 0; 
    logic [9:0] memory [0:127];
    logic [9:0] outputa;

    initial begin 
        $readmemh("newsine.txt", memory);
    end

    always_ff @(posedge clk) begin
        timef <= (timef == 511) ? 0 : timef + 1;
    end

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
   
    assign {_48b, _45a, _49a, _3b, _5a, _0a, _2a, _4a, _6a, _9b} = outputa[9:0];

    
endmodule

