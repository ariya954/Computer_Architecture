`timescale 1ns/1ns

module PipeLine_MIPS_TestBench();

reg clk = 0 ;

PipeLine_MIPS_Data_Path Data_Path(clk);

always #5 clk = ~clk;

initial begin

#5000 $stop;

end

endmodule

