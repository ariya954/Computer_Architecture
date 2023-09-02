module SRAM(
    input clk, reset, SRAM_WE_N,
    input [17 : 0] SRAM_ADDR,
    inout [15 : 0] SRAM_DQ
);

    reg [15 : 0] mem [511 : 0];

    assign  SRAM_DQ = SRAM_WE_N ? mem[SRAM_ADDR] : 16'bz;

    always @(posedge clk) begin
        if (~SRAM_WE_N)
            mem[SRAM_ADDR] = SRAM_DQ;
    end
    
endmodule
