module ARM_Top_Level(input clk, reset);

wire freeze, flush, two_src, move, hazard, Branch_Taken, Branch_ID_in, Branch_ID_out, Status_update_EN_ID_in, Status_update_EN_ID_out, Immediate_En_ID_in, Immediate_En_ID_out, Status_update_EN, MEM_W_EN_ID_in, MEM_W_EN_ID_out, MEM_W_EN_EXE_in, MEM_W_EN_EXE_out, MEM_R_EN_ID_in, MEM_R_EN_ID_out, MEM_R_EN_EXE_in, MEM_R_EN_EXE_out, MEM_R_EN_MEM_in, MEM_R_EN_MEM_out, WB_Enable_ID_in, WB_Enable_ID_out, WB_Enable_EXE_in, WB_Enable_EXE_out, WB_Enable_MEM_in, WB_Enable_MEM_out;
wire [31 : 0] Branch_Address, Instruction, Instruction_ID_stage, PC_IF, PC_IF_out, PC_ID_in, PC_ID_out;
wire [31 : 0] Val_Rn_ID_in, Val_Rn_ID_out, Val_Rm_ID_in, Val_Rm_ID_out, Val_Rm_EXE, Val_Rm_EXE_out, mem_read_data_MEM_in, mem_read_data_MEM_out, ALU_result_EXE, ALU_result_EXE_out, ALU_result_MEM_in, ALU_result_MEM_out, WB_data;
wire [3 : 0]  Reg_File_src_1, Reg_File_src_2, Status_reg_ID_in, Status_reg_ID_out, Status_reg, EXE_CMD_ID_in, EXE_CMD_ID_out, Reg_Dest_ID_in, Reg_Dest_ID_out, Reg_Dest_EXE_in, Reg_Dest_EXE_out, Reg_Dest_MEM_in, Reg_Dest_MEM_out, Reg_Dest;
wire [11 : 0] Shift_operand_ID_in, Shift_operand_ID_out;
wire [23 : 0] Signed_immediate_ID_in, Signed_immediate_ID_out;

assign freeze = hazard;
assign flush = Branch_Taken;

IF_Stage IF_stage (clk, reset, freeze, Branch_Taken, Branch_Address, PC_IF, Instruction);

IF_Stage_Reg IF_stage_reg (clk, reset, freeze, flush, PC_IF, Instruction, PC_IF_out, Instruction_ID_stage);

ID_Stage ID_stage (clk, reset, Instruction_ID_stage, WB_data, WB_Enable, Reg_Dest, Status_reg_ID_in, hazard, WB_Enable_ID_in, MEM_R_EN_ID_in, MEM_W_EN_ID_in, Branch_ID_in, Status_update_EN_ID_in, EXE_CMD_ID_in, Val_Rn_ID_in, Val_Rm_ID_in, Immediate_En_ID_in, Shift_operand_ID_in, Signed_immediate_ID_in, Reg_Dest_ID_in, two_src, move, Reg_File_src_1, Reg_File_src_2, PC_IF_out, PC_ID_in);

hazard_unit Hazard_Unit (two_src, move, WB_Enable_MEM_in, WB_Enable_EXE_in, Reg_Dest_MEM_in, Reg_Dest_EXE_in, Reg_File_src_1, Reg_File_src_2, hazard);

ID_Stage_Reg ID_stage_reg (clk, reset, flush, Status_update_EN_ID_in, Branch_ID_in, MEM_R_EN_ID_in, MEM_W_EN_ID_in, WB_Enable_ID_in, Immediate_En_ID_in, EXE_CMD_ID_in, Reg_Dest_ID_in, Status_reg_ID_in, Shift_operand_ID_in, Signed_immediate_ID_in, PC_ID_in, Val_Rn_ID_in, Val_Rm_ID_in, Status_update_EN_ID_out, Branch_ID_out, MEM_R_EN_ID_out, MEM_W_EN_ID_out, WB_Enable_ID_out, Immediate_En_ID_out, EXE_CMD_ID_out, Reg_Dest_ID_out, Status_reg_ID_out, Shift_operand_ID_out, Signed_immediate_ID_out, PC_ID_out, Val_Rn_ID_out, Val_Rm_ID_out);

EXE_Stage EXE_stage (clk, reset, WB_Enable_ID_out, MEM_R_EN_ID_out, MEM_W_EN_ID_out, Immediate_En_ID_out, Status_update_EN_ID_out, Branch_ID_out, EXE_CMD_ID_out, Status_reg_ID_out, Reg_Dest_ID_out, Shift_operand_ID_out, Signed_immediate_ID_out, PC_ID_out, Val_Rn_ID_out, Val_Rm_ID_out, Status_update_EN, Branch_Taken, MEM_R_EN_EXE_in, MEM_W_EN_EXE_in, WB_Enable_EXE_in, Status_reg, Reg_Dest_EXE_in, ALU_result_EXE, Branch_Address, Val_Rm_EXE);

status_register Status_Register (clk, reset, Status_update_EN, Status_reg, Status_reg_ID_in);

EXE_Stage_Reg EXE_stage_reg (clk, reset, MEM_R_EN_EXE_in, MEM_W_EN_EXE_in, WB_Enable_EXE_in, Reg_Dest_EXE_in, Val_Rm_EXE, ALU_result_EXE, MEM_R_EN_EXE_out, MEM_W_EN_EXE_out, WB_Enable_EXE_out, Reg_Dest_EXE_out, Val_Rm_EXE_out, ALU_result_EXE_out);

MEM_Stage MEM_stage (clk, reset, MEM_R_EN_EXE_out, MEM_W_EN_EXE_out, WB_Enable_EXE_out, Reg_Dest_EXE_out, Val_Rm_EXE_out, ALU_result_EXE_out, MEM_R_EN_MEM_in, WB_Enable_MEM_in, Reg_Dest_MEM_in, mem_read_data_MEM_in, ALU_result_MEM_in);

MEM_Stage_Reg MEM_stage_reg (clk, reset, MEM_R_EN_MEM_in, WB_Enable_MEM_in, Reg_Dest_MEM_in, mem_read_data_MEM_in, ALU_result_MEM_in, MEM_R_EN_MEM_out, WB_Enable_MEM_out, Reg_Dest_MEM_out, mem_read_data_MEM_out, ALU_result_MEM_out);

WB_Stage WB_stage (clk, reset, MEM_R_EN_MEM_out, WB_Enable_MEM_out, Reg_Dest_MEM_out, ALU_result_MEM_out, mem_read_data_MEM_out, WB_Enable, Reg_Dest, WB_data);

endmodule 