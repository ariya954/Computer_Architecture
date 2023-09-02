module ARM_Top_Level(input clk, reset, output SRAM_UB_N, SRAM_LB_N, SRAM_CE_N, SRAM_OE_N, SRAM_WE_N, sram_ready, output [17 : 0] SRAM_ADDR, inout [15 : 0] SRAM_DQ);

wire freeze, flush, two_src, move, hazard, Branch_Taken, Branch_ID_in, Branch_ID_out, Status_update_EN_ID_in, Status_update_EN_ID_out, Immediate_En_ID_in, Immediate_En_ID_out, Status_update_EN, MEM_W_EN_ID_in, MEM_W_EN_ID_out, MEM_W_EN_EXE_in, MEM_W_EN_EXE_out, MEM_R_EN_ID_in, MEM_R_EN_ID_out, MEM_R_EN_EXE_in, MEM_R_EN_EXE_out, MEM_R_EN_MEM_in, MEM_R_EN_MEM_out, WB_Enable_ID_in, WB_Enable_ID_out, WB_Enable_EXE_in, WB_Enable_EXE_out, WB_Enable_MEM_in, WB_Enable_MEM_out;
wire [31 : 0] Branch_Address, Instruction, Instruction_ID_stage, PC_IF, PC_IF_out, PC_ID_in, PC_ID_out;
wire [31 : 0] Val_Rn_ID_in, Val_Rn_ID_out, Val_Rm_ID_in, Val_Rm_ID_out, Val_Rm_EXE, Val_Rm_EXE_out, mem_read_data_MEM_in, mem_read_data_MEM_out, ALU_result_EXE, ALU_result_EXE_out, ALU_result_MEM_in, ALU_result_MEM_out, WB_data;
wire [1 : 0]  select_src_1_alu, select_src_2_alu;
wire [3 : 0]  Reg_File_src_1, Reg_File_src_2, src_1_reg_file, src_2_reg_file, Status_reg_ID_in, Status_reg_ID_out, Status_reg, EXE_CMD_ID_in, EXE_CMD_ID_out, Reg_Dest_ID_in, Reg_Dest_ID_out, Reg_Dest_EXE_in, Reg_Dest_EXE_out, Reg_Dest_MEM_in, Reg_Dest_MEM_out, Reg_Dest;
wire [11 : 0] Shift_operand_ID_in, Shift_operand_ID_out;
wire [23 : 0] Signed_immediate_ID_in, Signed_immediate_ID_out;

assign freeze = hazard;
assign flush = Branch_Taken;

IF_Stage IF_stage (clk, reset, freeze, sram_ready, Branch_Taken, Branch_Address, PC_IF, Instruction);

IF_Stage_Reg IF_stage_reg (clk, reset, freeze, sram_ready, flush, PC_IF, Instruction, PC_IF_out, Instruction_ID_stage);

ID_Stage ID_stage (clk, reset, Instruction_ID_stage, WB_data, WB_Enable, Reg_Dest, Status_reg_ID_in, hazard, WB_Enable_ID_in, MEM_R_EN_ID_in, MEM_W_EN_ID_in, Branch_ID_in, Status_update_EN_ID_in, EXE_CMD_ID_in, Val_Rn_ID_in, Val_Rm_ID_in, Immediate_En_ID_in, Shift_operand_ID_in, Signed_immediate_ID_in, Reg_Dest_ID_in, two_src, move, Reg_File_src_1, Reg_File_src_2, PC_IF_out, PC_ID_in);

hazard_unit Hazard_Unit (two_src, move, WB_Enable_MEM_in, WB_Enable_EXE_in, Reg_Dest_MEM_in, Reg_Dest_EXE_in, Reg_File_src_1, Reg_File_src_2, MEM_R_EN_EXE_in, hazard);

ID_Stage_Reg ID_stage_reg (clk, reset, flush, sram_ready, Status_update_EN_ID_in, Branch_ID_in, MEM_R_EN_ID_in, MEM_W_EN_ID_in, WB_Enable_ID_in, Immediate_En_ID_in, EXE_CMD_ID_in, Reg_Dest_ID_in, Status_reg_ID_in, Reg_File_src_1, Reg_File_src_2, Shift_operand_ID_in, Signed_immediate_ID_in, PC_ID_in, Val_Rn_ID_in, Val_Rm_ID_in, Status_update_EN_ID_out, Branch_ID_out, MEM_R_EN_ID_out, MEM_W_EN_ID_out, WB_Enable_ID_out, Immediate_En_ID_out, EXE_CMD_ID_out, Reg_Dest_ID_out, Status_reg_ID_out, src_1_reg_file, src_2_reg_file, Shift_operand_ID_out, Signed_immediate_ID_out, PC_ID_out, Val_Rn_ID_out, Val_Rm_ID_out);

EXE_Stage EXE_stage (clk, reset, WB_Enable_ID_out, MEM_R_EN_ID_out, MEM_W_EN_ID_out, Immediate_En_ID_out, Status_update_EN_ID_out, Branch_ID_out, select_src_1_alu, select_src_2_alu, EXE_CMD_ID_out, Status_reg_ID_out, Reg_Dest_ID_out, Shift_operand_ID_out, Signed_immediate_ID_out, PC_ID_out, Val_Rn_ID_out, Val_Rm_ID_out, ALU_result_MEM_in, WB_data, Status_update_EN, Branch_Taken, MEM_R_EN_EXE_in, MEM_W_EN_EXE_in, WB_Enable_EXE_in, Status_reg, Reg_Dest_EXE_in, ALU_result_EXE, Branch_Address, Val_Rm_EXE);

status_register Status_Register (clk, reset, Status_update_EN, Status_reg, Status_reg_ID_in);

EXE_Stage_Reg EXE_stage_reg (clk, reset, sram_ready, MEM_R_EN_EXE_in, MEM_W_EN_EXE_in, WB_Enable_EXE_in, Reg_Dest_EXE_in, Val_Rm_EXE, ALU_result_EXE, MEM_R_EN_EXE_out, MEM_W_EN_EXE_out, WB_Enable_EXE_out, Reg_Dest_EXE_out, Val_Rm_EXE_out, ALU_result_EXE_out);

Forwarding_Unit forwarding_unit(WB_Enable_MEM_in, WB_Enable, src_1_reg_file, src_2_reg_file, Reg_Dest_MEM_in, Reg_Dest, select_src_1_alu, select_src_2_alu);

MEM_Stage MEM_stage (clk, reset, MEM_R_EN_EXE_out, MEM_W_EN_EXE_out, WB_Enable_EXE_out, Reg_Dest_EXE_out, Val_Rm_EXE_out, ALU_result_EXE_out, MEM_R_EN_MEM_in, WB_Enable_MEM_in, Reg_Dest_MEM_in, mem_read_data_MEM_in, ALU_result_MEM_in, SRAM_UB_N, SRAM_LB_N, SRAM_CE_N, SRAM_OE_N, SRAM_WE_N, sram_ready, SRAM_ADDR, SRAM_DQ);

MEM_Stage_Reg MEM_stage_reg (clk, reset, MEM_R_EN_MEM_in, WB_Enable_MEM_in, sram_ready, Reg_Dest_MEM_in, mem_read_data_MEM_in, ALU_result_MEM_in, MEM_R_EN_MEM_out, WB_Enable_MEM_out, Reg_Dest_MEM_out, mem_read_data_MEM_out, ALU_result_MEM_out);

WB_Stage WB_stage (clk, reset, MEM_R_EN_MEM_out, WB_Enable_MEM_out, Reg_Dest_MEM_out, ALU_result_MEM_out, mem_read_data_MEM_out, WB_Enable, Reg_Dest, WB_data);

endmodule 