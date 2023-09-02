module Forwarding_Unit(WB_MEM, WB_WB, src_1_Register_File, src_2_Register_File, Reg_Dest_MEM, Reg_Dest_WB, select_src_1_alu, select_src_2_alu);
  
  input WB_MEM, WB_WB;
  input [3 : 0] src_1_Register_File, src_2_Register_File, Reg_Dest_MEM, Reg_Dest_WB;
  output reg [1 : 0] select_src_1_alu, select_src_2_alu;
  
  
always@(*)begin
  select_src_1_alu = 2'b0;
  select_src_2_alu = 2'b0;

  if(WB_MEM & (src_1_Register_File == Reg_Dest_MEM))
    select_src_1_alu = 2'b01;
  else if(WB_WB & (src_1_Register_File == Reg_Dest_WB))
    select_src_1_alu = 2'b10;
  if(WB_MEM & (src_2_Register_File == Reg_Dest_MEM))
    select_src_2_alu = 2'b01;
  else if(WB_WB & (src_2_Register_File == Reg_Dest_WB))
    select_src_2_alu = 2'b10;

  
end

endmodule