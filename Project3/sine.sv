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
    output logic _48b,
);

    logic [8:0] time = 0; 
    logic [8:0] memory [0:127];
    logic [9:0] output;

    initial begin 
        $readmemh("newsine.txt", memory);
    end

    always_ff @(posedge clk) begin
        time <= (time == 511)? 0 : time + 1
    end

    always_comb begin
        if(time < 128) begin
            output = memory[time]
        end else if (time < 256) begin
            output = memory[127 - (time - 128)]
        end else if (x < 384) begin
            output = 1024 - memory[(time - 256)]
        end else begin
            output = 1024 - memory[127 - (time - 384)]
        end
    end
   
    assign {_48b, _45a, _49a, _3b, _5a, _0a, _2a, _4a, _6a, _9b} = output;

    
endmodule

