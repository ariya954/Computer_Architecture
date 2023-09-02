module MEM_Stage(
  input clk, rst,
  input MEM_R_EN_in, MEM_W_EN_in, WB_Enable_in,
  input[3 : 0] Reg_Dest_in,
  input[31 : 0] Val_RM, ALU_result_in,
  output  MEM_R_EN_out, WB_Enable_out,
  output [3 : 0] Reg_Dest,
  output [31 : 0] mem_read_data, ALU_result
);
 
    assign Reg_Dest = Reg_Dest_in;
    assign ALU_result = ALU_result_in;
    assign MEM_R_EN_out = MEM_R_EN_in;
    assign WB_Enable_out = WB_Enable_in;
    
    wire [31 : 0] aligned_address;
    reg  [31 : 0] mem [63 : 0]; 

    assign aligned_address = (ALU_result_in - 32'd1024) >> 2;
    assign mem_read_data = (MEM_R_EN_in) ? mem[aligned_address] : 32'bz;

    always @(posedge clk) begin
        if (MEM_W_EN_in)
            mem[aligned_address] = Val_RM;
    end

  
endmodule




