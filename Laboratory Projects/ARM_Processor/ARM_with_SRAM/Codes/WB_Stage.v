module WB_Stage(
    input clk, rst, MEM_R_EN, WB_Enable_in,
    input [3 : 0] Reg_Dest_in,
    input [31 : 0] ALU_result_in, mem_read_data_in,
    output WB_Enable,
    output [3 : 0] Reg_Dest,
    output [31 : 0]WB_data
);
    
    assign Reg_Dest = Reg_Dest_in;
    assign WB_Enable = WB_Enable_in;
    assign WB_data = (MEM_R_EN)? mem_read_data_in : ALU_result_in;

endmodule