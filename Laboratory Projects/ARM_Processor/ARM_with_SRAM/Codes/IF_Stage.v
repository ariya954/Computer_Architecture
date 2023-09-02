module IF_Stage(
	input clk, reset, freeze, sram_ready, Branch_Taken,
	input [31 : 0] Branch_Address, 
	output reg[31 : 0] PC, 
        output [31 : 0]Instruction
); 

reg [31 : 0] instruction_mem [46 : 0];

initial begin
	$readmemb("instruction_mem.txt", instruction_mem);
end

always @(posedge clk, posedge reset) begin

   if(reset)
     PC <= 0;
   else if(~freeze && sram_ready)
     PC <= (Branch_Taken) ? Branch_Address : 
			        (PC < 200) ? PC + 32'd4
				           : 200;


end

assign Instruction = instruction_mem[PC[31 : 2]];


endmodule
