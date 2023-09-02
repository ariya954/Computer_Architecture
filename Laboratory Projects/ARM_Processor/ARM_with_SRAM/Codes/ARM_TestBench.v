`timescale 1ns/1ns

module ARM_Test_Bench();

reg clk, reset;

wire SRAM_UB_N, SRAM_LB_N, SRAM_CE_N, SRAM_OE_N, SRAM_WE_N, sram_ready;
wire [17 : 0] SRAM_ADDR;
wire [15 : 0] SRAM_DQ;

SRAM sram(clk, reset, SRAM_WE_N, SRAM_ADDR, SRAM_DQ);

ARM_Top_Level ARM(clk, reset, SRAM_UB_N, SRAM_LB_N, SRAM_CE_N, SRAM_OE_N, SRAM_WE_N, sram_ready, SRAM_ADDR, SRAM_DQ); 

always #10 clk = ~clk;

initial begin

clk = 0; reset = 0;
#20 reset = 1;
#40 reset = 0;

repeat(1500) @(posedge clk);
$stop;

end

endmodule