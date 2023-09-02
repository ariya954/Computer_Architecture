`timescale 1ns/1ns

module ARM_Test_Bench();

reg clk, reset;

ARM_Top_Level ARM(clk, reset); 

always #10 clk = ~clk;

initial begin

clk = 0; reset = 0;
#20 reset = 1;
#40 reset = 0;

repeat(400) @(posedge clk);
$stop;

end

endmodule