module EXE_Stage(
	input clk, reset, WB_EN_in, MEM_R_EN_in, MEM_W_EN_in, Immediate_En, Status, Branch,
	input [1 : 0]select_src_1_alu, select_src_2_alu, 
	input [3 : 0]EXE_CMD, Status_reg_in, Reg_Dest_in,
	input [11 : 0] shifter_operand,
	input [23 : 0] signed_immediate,
	input [31 : 0] PC, Val_Rn, Val_Rm_in, alu_result_MEM, alu_result_WB,
	output Status_En, Branch_En, MEM_R_EN_out, MEM_W_EN_out, WB_EN_out,
	output [3 : 0]  Status_Reg_out, Reg_Dest_out,
        output [31 : 0] ALU_result, branch_address, Val_Rm_out);

  wire [31 : 0]Val_1, Val_2;
 
  assign Status_En = Status;
  assign Branch_En = Branch;
  assign branch_address = PC + 4 + ({{8{signed_immediate[23]}}, signed_immediate} << 2);
  assign MEM_R_EN_out = MEM_R_EN_in;
  assign MEM_W_EN_out = MEM_W_EN_in;

  assign WB_EN_out = WB_EN_in;
  assign Reg_Dest_out = Reg_Dest_in;

  assign Val_Rm_out = (select_src_2_alu == 2'b00) ? Val_Rm_in :
                      (select_src_2_alu == 2'b01) ? alu_result_MEM :
                      (select_src_2_alu == 2'b10) ? alu_result_WB  : 32'd0;

  assign Val_1 = (select_src_1_alu == 2'b00) ? Val_Rn :
                 (select_src_1_alu == 2'b01) ? alu_result_MEM :
                 (select_src_1_alu == 2'b10) ? alu_result_WB  : 32'd0;
 
  Val_2_Generator VG2(Immediate_En, MEM_R_EN_in | MEM_W_EN_in, shifter_operand, Val_Rm_out, Val_2);
  
  ALU alu(Val_1, Val_2, Status_reg_in, EXE_CMD, Status_Reg_out, ALU_result);
  
  
  
endmodule    
