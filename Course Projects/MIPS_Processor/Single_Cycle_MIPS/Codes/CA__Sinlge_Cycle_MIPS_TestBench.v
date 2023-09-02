`timescale 1ns/1ns

module Single_Cycle_MIPS_Test_Bench();

reg clk, reset, instruction_Write_en;
reg  [31 : 0]Write_address, Write_instruction;
wire [31 : 0]ALU_Result, Register_file_Write_Data;

Single_Cycle_MIPS single_cycle_MIPS(clk, reset, instruction_Write_en, Write_address, Write_instruction, ALU_Result, Register_file_Write_Data);

always #50 clk = ~clk;
initial begin

clk = 0; reset = 0; instruction_Write_en = 1; Write_address = 0;

#100 Write_instruction = 32'b00011000000000010000000000000110; // ADDI R1, R0, 6 
#1000 Write_address = Write_address + 1;
#100 Write_instruction = 32'b00011000000000100000000000000111; // ADDI R2, R0, 7
#1000 Write_address = Write_address + 1;
#100 Write_instruction = 32'b00011000000000110000000000001000; // ADDI R3, R0, 8
#1000 Write_address = Write_address + 1;
#100 Write_instruction = 32'b00011000000001000000000000001001; // ADDI R4, R0, 9
#1000 Write_address = Write_address + 1;
#100 Write_instruction = 32'b00011000000001010000000000001010; // ADDI R5, R0, 10
#1000 Write_address = Write_address + 1;
#100 Write_instruction = 32'b00011000000001100000000000001011; // ADDI R6, R0, 11
#1000 Write_address = Write_address + 1;
#100 Write_instruction = 32'b00011000000001110000000000001100; // ADDI R7, R0, 12
#1000 Write_address = Write_address + 1;
#100 Write_instruction = 32'b00011000000010000000000000001101; // ADDI R8, R0, 13
#1000 Write_address = Write_address + 1;
#100 Write_instruction = 32'b00011000000010010000000000001110; // ADDI R9, R0, 14
#1000 Write_address = Write_address + 1;
#100 Write_instruction = 32'b00011000000010100000000000001111; // ADDI R10, R0, 15
#1000 Write_address = Write_address + 1;
#100 Write_instruction = 32'b00011000000010110000000000010000; // ADDI R11, R0, 16
#1000 Write_address = Write_address + 1;
#100 Write_instruction = 32'b00011000000011000000000000010001; // ADDI R12, R0, 17
#1000 Write_address = Write_address + 1;
#100 Write_instruction = 32'b00000000001000100110111111000000; // ADD R13, R1, R2
#1000 Write_address = Write_address + 1;
#100 Write_instruction = 32'b00000000100000110111011111000001; // SUB R14, R4, R3 
#1000 Write_address = Write_address + 1;
#100 Write_instruction = 32'b00000000101001100111111111000011; // SLT R15, R5, R6
#1000 Write_address = Write_address + 1;
#100 Write_instruction = 32'b00000000111010001000011111000100; // AND R16, R7, R8
#1000 Write_address = Write_address + 1;
#100 Write_instruction = 32'b00000001001010101000111111000101; // OR R17, R9, R10
#1000 Write_address = Write_address + 1;
#100 Write_instruction = 32'b00100001011100100000000000001010; // SLTI R18, R11, 10
#1000 Write_address = Write_address + 1;
#100 Write_instruction = 32'b00010000101100010000000001010000; // SW R5, R17, 80   R5 = 10
#1000 Write_address = Write_address + 1;
#100 Write_instruction = 32'b00001000101100110000000001010000; // lW R5, R19, 80   R5 = 10
#1000 Write_address = Write_address + 1;
#100 Write_instruction = 32'b00101000000000000000000000111100; // J 60
#1000 Write_address = Write_address + 1;
#100 Write_instruction = 32'b00011000000101000000000000011001; // ADDI R20, R0, 25
#1000 Write_address = 60;
#100 Write_instruction = 32'b00011000000101000000000000010111; // ADDI R20, R0, 23
#1000 Write_address = Write_address + 1;
#100 Write_instruction = 32'b00110010101000000000000000110010; // JAL R21, 50
#1000 Write_address = Write_address + 1;
#100 Write_instruction = 32'b00011000000101100000000000011010; // ADDI R22, R0, 26
#1000 Write_address = 50;
#100 Write_instruction = 32'b00011000000101100000000000000000; // ADDI R22, R0, 0
#1000 Write_address = Write_address + 1;
#100 Write_instruction = 32'b00011000000101110000000000101000; // ADDI R23, R0, 40
#1000 Write_address = Write_address + 1;
#100 Write_instruction = 32'b00111010111000000000000000000000; // JR R23
#1000 Write_address = Write_address + 1;
#100 Write_instruction = 32'b00011000000110000000000000100000; // ADDI R24, R0, 32
#1000 Write_address = 40;
#100 Write_instruction = 32'b00011000000110000000000000101011; // ADDI R24, R0, 43
#1000 Write_address = Write_address + 1;
#100 Write_instruction = 32'b01000010001100110000000001001011; // Beq R17, R19, 75
#1000 Write_address = Write_address + 1;
#100 Write_instruction = 32'b00011000000110010000000000100000; // ADDI R25, R0, 32
#1000 Write_address = 75;
#100 Write_instruction = 32'b00011000000110010000000000101101; // ADDI R25, R0, 53
#1000 Write_address = Write_address + 1;
#100 Write_instruction = 32'b00011000000100100000000001001011; // ADDI R18, R0, 43
#1000 Write_address = Write_address + 1;
#100 Write_instruction = 32'b00011000000110100000000000000001; // ADDI R26, R0, 1
#1000 Write_address = Write_address + 1;
#100 Write_instruction = 32'b00010000000000000000000000110011; // SW R0, R0, 51
#1000 Write_address = Write_address + 1;
#100 Write_instruction = 32'b00010000000000010000000000110100; // SW R0, R1, 52
#1000 Write_address = Write_address + 1;
#100 Write_instruction = 32'b00010000000000100000000000110101; // SW R0, R2, 53
#1000 Write_address = Write_address + 1;
#100 Write_instruction = 32'b00010000000000110000000000110110; // SW R0, R3, 54
#1000 Write_address = Write_address + 1;
#100 Write_instruction = 32'b00010000000001000000000000110111; // SW R0, R4, 55
#1000 Write_address = Write_address + 1;
#100 Write_instruction = 32'b00010000000001010000000000111000; // SW R0, R5, 56
#1000 Write_address = Write_address + 1;
#100 Write_instruction = 32'b00010000000001100000000000111001; // SW R0, R6, 57
#1000 Write_address = Write_address + 1;
#100 Write_instruction = 32'b00010000000001110000000000111010; // SW R0, R7, 58
#1000 Write_address = Write_address + 1;
#100 Write_instruction = 32'b00010000000010000000000000111011; // SW R0, R8, 59
#1000 Write_address = Write_address + 1;
#100 Write_instruction = 32'b00010000000010010000000000111100; // SW R0, R9, 60
#1000 Write_address = Write_address + 1;
#100 Write_instruction = 32'b00010000000010100000000000111101; // SW R0, R10, 61
#1000 Write_address = Write_address + 1;
#100 Write_instruction = 32'b00010000000010110000000000111110; // SW R0, R11, 62
#1000 Write_address = Write_address + 1;
#100 Write_instruction = 32'b00010000000011000000000000111111; // SW R0, R12, 63
#1000 Write_address = Write_address + 1;
#100 Write_instruction = 32'b00010000000011010000000001000000; // SW R0, R13, 64
#1000 Write_address = Write_address + 1;
#100 Write_instruction = 32'b00010000000011100000000001000001; // SW R0, R14, 65
#1000 Write_address = Write_address + 1;
#100 Write_instruction = 32'b00010000000011110000000001000010; // SW R0, R15, 66
#1000 Write_address = Write_address + 1;
#100 Write_instruction = 32'b00010000000100000000000001000011; // SW R0, R16, 67
#1000 Write_address = Write_address + 1;
#100 Write_instruction = 32'b00010000000100010000000001000100; // SW R0, R17, 68
#1000 Write_address = Write_address + 1;
#100 Write_instruction = 32'b00010000000100100000000001000101; // SW R0, R18, 69
#1000 Write_address = Write_address + 1;
#100 Write_instruction = 32'b00010000000100110000000001000110; // SW R0, R19, 70

#1000 Write_address = Write_address + 1;
#100 Write_instruction = 32'b00011000000101000000000000110011; // ADDI R20, R0, 51 equals with i = 51;
#1000 Write_address = Write_address + 1;
#100 Write_instruction = 32'b00011000000101010000000001000111; // ADDI R21, R0, 71 equals with n = 71;
#1000 Write_address = Write_address + 1;
#100 Write_instruction = 32'b00101000000000000000000010001100; // J 140
#1000 Write_address = 140;
#100 Write_instruction = 32'b01000010100101010000000011000111; // Beq R20, R21, 199(End) equals with for(; i < n; i++)
#1000 Write_address = Write_address + 1;
#100 Write_instruction = 32'b00001010100110010000000000000001; // lW R20, R25, 0 equals with x = mem[i]
#1000 Write_address = Write_address + 1;
#100 Write_instruction = 32'b00000010110110011100011111000011; // SLT R24, R22, R25
#1000 Write_address = Write_address + 1;
#100 Write_instruction = 32'b01000011000110100000000010100000; // Beq R24, R26 160 equals with if(max < x) we assumed that max is in R22
#1000 Write_address = Write_address + 1;
#100 Write_instruction = 32'b00101000000000000000000010101010; // J 170
#1000 Write_address = 160;                                     // equals with max = mem[i];
                                                               //             max_index = i; we assumed that maximum index is in R23
#100 Write_instruction = 32'b00000000000110011011011111000000; // ADD R22, R0, R25
#1000 Write_address = Write_address + 1;
#100 Write_instruction = 32'b00000000000101001011111111000000; // ADD R23, R0, R20
#1000 Write_address = Write_address + 1;
#100 Write_instruction = 32'b00101000000000000000000010101010; // J 170
#1000 Write_address = 170;
#100 Write_instruction = 32'b00011010100101000000000000000001; // ADDI R20, R20, 1 equals with i++;
#1000 Write_address = Write_address + 1;
#100 Write_instruction = 32'b00101000000000000000000010001100; // J 140


#100 reset = 1; instruction_Write_en = 0;
#200 reset = 0;

#90000 $stop;

end

endmodule
