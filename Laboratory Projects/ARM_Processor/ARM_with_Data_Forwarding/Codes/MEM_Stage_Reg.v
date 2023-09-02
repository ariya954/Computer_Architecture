module MEM_Stage_Reg(
  input clk, reset,
  input MEM_R_EN_in, WB_Enable_in,
  input[3 : 0] Reg_Dest_in,
  input[31 : 0] mem_read_data_in, ALU_result_in,
  output reg mem_read, WB_Enable,
  output reg[3 : 0] Reg_Dest_out,
  output reg[31 : 0] mem_read_data, ALU_result
);
 
  always @(posedge clk, posedge reset) begin
    if (reset) begin
        mem_read = 1'b0;
        WB_Enable = 1'b0;
        Reg_Dest_out = 4'b0;
        mem_read_data = 32'b0;
        ALU_result = 32'b0;
    end
    else begin
        mem_read = MEM_R_EN_in;
        WB_Enable = WB_Enable_in;
        Reg_Dest_out = Reg_Dest_in;
        mem_read_data = mem_read_data_in;
        ALU_result = ALU_result_in;
    end
  end
  
endmodule

