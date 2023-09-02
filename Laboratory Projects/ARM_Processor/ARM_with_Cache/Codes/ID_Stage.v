module ID_Stage(
	input clk, rst,
	input [31 : 0] instruction, Result_WB, 
	input writeBackEn,
	input [3 : 0] Dest_wb, Status_Reg,
	input hazard,
	output WB_EN, MEM_R_EN, MEM_W_EN, B, S,
	output [3 : 0] EXE_CMD,
	output [31 : 0] Val_Rn, Val_Rm,
	output immediate_enable,
	output [11 : 0] shifter_operand,
	output [23 : 0] Signed_immediate_24,
	output [3 : 0]  RegDest,
	output two_src, move,
	output [3 : 0]  Reg_File_src_1, Reg_File_src_2,
	input  [31 : 0] PC_in,
	output [31 : 0] PC
);
 
wire S_C, B_C, mem_write, mem_read, WB_Enable, condition;
wire [1 : 0] instruction_mode;
wire [3 : 0] EXE_CMD_C, opcode, RM;

assign PC = PC_in;
assign Reg_File_src_1 = instruction [19 : 16];
assign RegDest = instruction [15 : 12];
assign RM = instruction [3 : 0];
assign Status_update_enable_in = instruction[20];
assign instruction_mode = instruction[27 : 26];
assign opcode = instruction[24 : 21];
assign Reg_File_src_2 = (MEM_W_EN) ? RegDest : RM;
assign {WB_EN, MEM_R_EN, MEM_W_EN, B, S, EXE_CMD} = (~condition | hazard) ? 9'b0 : {WB_Enable, mem_read, mem_write, B_C, S_C, EXE_CMD_C}; 
assign Signed_immediate_24 = instruction[23 : 0];
assign shifter_operand = instruction[11 : 0];
assign immediate_enable = instruction[25];
assign two_src = ~((EXE_CMD_C == 4'b0001) || (EXE_CMD_C == 4'b1001)); //((~immediate_enable) & (instruction_mode == 2'b0)) | mem_write;

ARM_ID_Control_Unit CU (Status_update_enable_in, instruction_mode, opcode, S_C, B_C, mem_write, mem_read, WB_Enable, move, EXE_CMD_C);
RegisterFile RF (clk, rst, Reg_File_src_1, Reg_File_src_2, Dest_wb, Result_WB, writeBackEn, Val_Rn, Val_Rm);
Condition_Check CC (instruction[31 : 28], Status_Reg, condition);

endmodule