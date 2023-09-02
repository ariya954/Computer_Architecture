
module RegisterFile ( 
	input clk, rst,
	input [3 : 0] src1, src2, Dest_wb,
	input [31 : 0]Result_WB,
	input writeBackEn,
	output [31 : 0] reg1, reg2
);


reg [31 : 0] RF [14 : 0];

integer i;

always @(negedge clk, posedge rst) begin
	if(rst)
	   for(i = 0; i < 15; i = i + 1) begin
		RF[i] = i;
	   end
	else if(writeBackEn)
		RF[Dest_wb] = Result_WB;
end

assign reg1 = RF[src1];
assign reg2 = RF[src2];

endmodule