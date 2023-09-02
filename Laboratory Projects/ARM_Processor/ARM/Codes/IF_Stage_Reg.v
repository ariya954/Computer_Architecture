module IF_Stage_Reg
(
    input clk, reset, freeze, flush,
    input [31 : 0] PC_in, instruction_in,
    output reg [31 : 0] PC_out, instruction_out
);

    always @(posedge clk, posedge reset) begin
        if (reset) begin
            PC_out = 32'b0;
            instruction_out = 32'b0;
        end
        else if (flush) begin
            PC_out = 32'b0;
            instruction_out = 32'b0;
        end		  
        else if (~freeze) begin
            PC_out = PC_in;
            instruction_out = instruction_in;
        end
    end

endmodule
