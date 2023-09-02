module ID_Stage_Reg(
    input clk, reset, flush, Status_update_in, Branch_EN_in, MEM_R_EN_in, MEM_W_EN_in, WB_Enable_in, I_in,
    input [3 : 0] EXE_CMD_in, Reg_Dest_in, Status_Reg_in, Reg_File_src_1, Reg_File_src_2,
    input [11 : 0] shifter_operand_in,
    input [23 : 0] signed_immediate_in,
    input [31 : 0] PC_in, Rn_in, Rm_in,
    output reg Status_update_out, Branch_EN_out, mem_read, mem_write, WB_Enable, I,
    output reg [3 : 0] EXE_CMD, Reg_Dest_out, Status_Reg_out, src_1_reg_file, src_2_reg_file,
    output reg [11 : 0] shifter_operand,
    output reg [23 : 0] signed_immediate,
    output reg [31 : 0] PC_out, Rn_out, Rm_out
);

    always @(posedge clk, posedge reset) begin
        if (reset) begin
            Status_update_out = 1'b0;
            Branch_EN_out = 1'b0;
            mem_read = 1'b0;
            mem_write = 1'b0;
            WB_Enable = 1'b0;
            I = 1'b0;
            EXE_CMD = 4'b0;
            Reg_Dest_out = 4'b0;
            Status_Reg_out = 4'b0;
	    src_1_reg_file = 4'b0;
	    src_2_reg_file = 4'b0;
            shifter_operand = 12'b0;
            signed_immediate = 24'b0;
            PC_out = 32'b0;
            Rn_out = 32'b0;
            Rm_out = 32'b0;
        end
		  else if (flush) begin
            Status_update_out = 1'b0;
            Branch_EN_out = 1'b0;
            mem_read = 1'b0;
            mem_write = 1'b0;
            WB_Enable = 1'b0;
            I = 1'b0;
            EXE_CMD = 4'b0;
            Reg_Dest_out = 4'b0;
            Status_Reg_out = 4'b0;
	    src_1_reg_file = 4'b0;
	    src_2_reg_file = 4'b0;
            shifter_operand = 12'b0;
            signed_immediate = 24'b0;
            PC_out = 32'b0;
            Rn_out = 32'b0;
            Rm_out = 32'b0;
        end
        else begin
            Status_update_out = Status_update_in;
            Branch_EN_out = Branch_EN_in;
            mem_read = MEM_R_EN_in;
            mem_write = MEM_W_EN_in;
            WB_Enable = WB_Enable_in;
            I = I_in;
            EXE_CMD = EXE_CMD_in;
            Reg_Dest_out = Reg_Dest_in;
            Status_Reg_out = Status_Reg_in;
	    src_1_reg_file = Reg_File_src_1;
	    src_2_reg_file = Reg_File_src_2;
            shifter_operand = shifter_operand_in;
            signed_immediate = signed_immediate_in;
            PC_out = PC_in;
            Rn_out = Rn_in;
            Rm_out = Rm_in;
        end
    end

endmodule

