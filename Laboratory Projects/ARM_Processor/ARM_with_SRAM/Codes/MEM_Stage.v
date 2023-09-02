module MEM_Stage(
  input clk, reset,
  input MEM_R_EN_in, MEM_W_EN_in, WB_Enable_in,
  input[3 : 0] Reg_Dest_in,
  input[31 : 0] Val_RM, ALU_result_in,
  output  MEM_R_EN_out, WB_Enable_out,
  output [3 : 0] Reg_Dest,
  output [31 : 0] mem_read_data, ALU_result,

  output SRAM_UB_N, SRAM_LB_N, SRAM_CE_N, SRAM_OE_N, SRAM_WE_N, sram_ready,
  output [17 : 0] SRAM_ADDR,  
  inout  [15 : 0] SRAM_DQ    
);
 
    assign Reg_Dest = Reg_Dest_in;
    assign ALU_result = ALU_result_in;
    assign MEM_R_EN_out = MEM_R_EN_in;
    assign WB_Enable_out = WB_Enable_in;
    
    wire [31 : 0] aligned_address;
    reg  [31 : 0] mem [63 : 0]; 

    SRAM_controller SRAM_CNTRL(
    clk, reset, MEM_W_EN_in, MEM_R_EN_in, ALU_result_in, Val_RM, sram_ready, SRAM_UB_N, SRAM_LB_N, SRAM_WE_N,
    SRAM_CE_N, SRAM_OE_N, SRAM_ADDR, mem_read_data, SRAM_DQ);
  
endmodule





