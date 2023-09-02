module MEM_Stage(
  input clk, reset,
  input MEM_R_EN_in, MEM_W_EN_in, WB_Enable_in,
  input[3 : 0] Reg_Dest_in,
  input[31 : 0] Val_RM, ALU_result_in,
  output  MEM_R_EN_out, WB_Enable_out,
  output [3 : 0] Reg_Dest,
  output [31 : 0] mem_read_data, ALU_result,

  output SRAM_UB_N, SRAM_LB_N, SRAM_CE_N, SRAM_OE_N, SRAM_WE_N, freeze_arm,
  output [17 : 0] SRAM_ADDR,  
  inout  [15 : 0] SRAM_DQ    
);

    wire [31 : 0] aligned_address, cache_data, SRAM_W_DQ, sram_addr, sram_data;
    wire cache_write, freeze_sram, hit, SRAM_w_en, SRAM_r_en;
    
    reg  [31 : 0] mem [63 : 0];
 
    assign Reg_Dest = Reg_Dest_in;
    assign ALU_result = ALU_result_in;
    assign MEM_R_EN_out = MEM_R_EN_in;
    assign WB_Enable_out = WB_Enable_in;
    assign mem_read_data = cache_data; 

    cache Cache(clk, reset, MEM_W_EN_in, MEM_R_EN_in, cache_write, sram_ready, ALU_result_in, Val_RM, hit, freeze_arm, SRAM_w_en, SRAM_r_en, sram_addr, cache_data, SRAM_W_DQ, sram_data);

    SRAM_controller SRAM_CNTRL(
    clk, reset, SRAM_w_en, SRAM_r_en, sram_addr, SRAM_W_DQ, sram_ready, SRAM_UB_N, SRAM_LB_N, SRAM_WE_N,
    SRAM_CE_N, SRAM_OE_N, SRAM_ADDR, sram_data, SRAM_DQ, cache_write);
  
endmodule





