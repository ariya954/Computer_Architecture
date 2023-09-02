`timescale 1ns / 1ns

module adder(input [31 : 0]a, b, output [31 : 0]sum);

assign sum = a + b;

endmodule

module MUX_2_To_1(input[31 : 0]input_0, input_1, input select, output[31 : 0]selected_output);

assign selected_output = select ? input_1 : input_0;

endmodule

module MUX_2_To_1_5_bit(input[4 : 0]input_0, input_1, input select, output[4 : 0]selected_output);

assign selected_output = select ? input_1 : input_0;

endmodule

module MUX_2_To_1_11_bit(input[10 : 0]input_0, input_1, input select, output[10 : 0]selected_output);

assign selected_output = select ? input_1 : input_0;

endmodule

module MUX_3_To_1(input[31 : 0]input_0, input_1, input_2, input[1 : 0]select, output[31 : 0]selected_output);

assign selected_output = (select == 2'b10) ? input_2 : 
                         (select == 2'b01) ? input_1 : 
                          input_0;
endmodule

module ALU(input [31 : 0]A, B ,input [2:0]ALU_operation ,output reg [31 : 0]ALU_Result, output reg zero);

always @(ALU_operation or A or B) begin
    case(ALU_operation)
	0: //ADD
	   ALU_Result = A + B;
	1: //SUB
	   ALU_Result = A - B;
	2: //AND
	   ALU_Result = A && B;
	3: //OR
	   ALU_Result = A || B;
	4: //SLT
           ALU_Result = (A < B) ? 1 : 0;
     endcase
end

always @(ALU_Result) begin    if(ALU_Result == 0)       zero = 1;    else       zero = 0;end

endmodule

module Data_Memory(input clk, Mem_Read, Mem_Write, input [31 : 0]Address, Write_Data, Read_Data);

reg  [31 : 0] data_memory [0 : 1023];
wire [9 : 0] Memory_Address;

assign Memory_Address = Address[11 : 2];

initial begin 
$readmemh("C:/Users/HP/Dropbox/PC/Desktop/Data_inputs.txt", data_memory);
end

always @(negedge clk) begin
if(Mem_Write)
   data_memory[Memory_Address] = Write_Data;
end

assign Read_Data = (Mem_Read == 1) ? data_memory[Memory_Address] : 32'b0;

always @(posedge clk) begin
$writememh("C:/Users/HP/Dropbox/PC/Desktop/Data_Memory.txt", data_memory);
end
	
endmodule

module Instruction_Memory(input [31 : 0]Address_of_Instruction, output[31 : 0]Instruction);

reg [31:0] instruction_memory [0 : 1023];

initial begin
$readmemh("C:/Users/HP/Dropbox/PC/Desktop/Instructions.txt", instruction_memory);
end

assign Instruction = instruction_memory[Address_of_Instruction >> 2];

endmodule

module Register_File(input clk, Reg_Write, input [4 : 0]Read_Register1, Read_Register2, Write_Register, input [31 : 0]Write_Data, output [31 : 0]Read_Data1, Read_Data2);

reg [31 : 0] Register [0 : 31];

integer k;
initial begin 
for(k = 0; k < 32; k = k + 1)
   Register[k] = 32'b0;
end

always @(posedge clk) begin

if(Reg_Write == 1) 
   Register[Write_Register] = Write_Data;

end

assign Read_Data1 = Register[Read_Register1];
assign Read_Data2 = Register[Read_Register2];

endmodule 

module PC(input clk, PC_Write, input [31 : 0]PC_input, output reg[31 : 0]PC_output);

initial begin 
PC_output = 32'b0;
end

always@(posedge clk) begin 
if(PC_Write == 1)
   PC_output = PC_input;
end

endmodule
