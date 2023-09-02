`timescale 1ns/1ns

module Multi_Cycle_MIPS_Test_Bench();

reg clk, reset, instruction_Write_en;
reg [11 : 0]i;
reg [15 : 0]Write_instruction_address, Write_instruction;

Multi_Cycle_MIPS multi_cycle_MIPS(clk, reset, instruction_Write_en, Write_instruction_address, Write_instruction);

always #50 clk = ~clk;
initial begin

clk = 0; reset = 0; instruction_Write_en = 1; Write_instruction_address = 1; i = 129;


/*
#100 Write_instruction = 16'b1111000000100111; // ADDI 6 
#100 Write_instruction_address = Write_instruction_address + 1;
#100 Write_instruction = 16'b1110000000100111; // ANDI 7 
#100 Write_instruction_address = Write_instruction_address + 1;
#100 Write_instruction = 16'b1000101000000001; // MoveTo R5 
#100 Write_instruction_address = Write_instruction_address + 1;

#100 Write_instruction = 16'b1000101000000100; // ADD R0 , R5 
#100 Write_instruction_address = Write_instruction_address + 1;

#100 Write_instruction = 16'b1101000000000110; // SUBI 6 
#100 Write_instruction_address = Write_instruction_address + 1;



#100 Write_instruction = 16'b1000101000010000; // AND R5 
#100 Write_instruction_address = Write_instruction_address + 1;

#100 Write_instruction = 16'b1000101000000010; // MoveFrom R5 
#100 Write_instruction_address = Write_instruction_address + 1;

#100 Write_instruction = 16'b0001111110011111; // Store M[3999] 
#100 Write_instruction_address = Write_instruction_address + 1;

#100 Write_instruction = 16'b1100000000000110; // ADDI 6 
#100 Write_instruction_address = Write_instruction_address + 1;

#100 Write_instruction = 16'b1000101000001000; // SUB R5 
#100 Write_instruction_address = Write_instruction_address + 1;

#100 Write_instruction = 16'b0010000100000000; // JUMP 256 
#100 Write_instruction_address = Write_instruction_address + 1;

#100 Write_instruction_address = 257;

#100 Write_instruction = 16'b1000010000000001; // MoveTo R2 
#100 Write_instruction_address = Write_instruction_address + 1;

#100 Write_instruction = 16'b0100010111111111; // BranchZ R2, 511 (new_PC = old_PC + 511) 
#100 Write_instruction_address = Write_instruction_address + 1;

#100 Write_instruction_address = 512;

#100 Write_instruction = 16'b1000100000000001; // MoveTo R4 
*/

#100 Write_instruction = 16'b1100000000000110; // ADDI 6 
#100 Write_instruction_address = Write_instruction_address + 1;
#100 Write_instruction = 16'b0001000001100100; // Store M[100]                      // M[100] = 6;
#100 Write_instruction_address = Write_instruction_address + 1;
#100 Write_instruction = 16'b1110000000000000; // ANDI 0(R0 = 0;)
#100 Write_instruction_address = Write_instruction_address + 1;

#100 Write_instruction = 16'b1100000000000111; // ADDI 7 
#100 Write_instruction_address = Write_instruction_address + 1;
#100 Write_instruction = 16'b0001000001100101; // Store M[101]                      // M[101] = 7;
#100 Write_instruction_address = Write_instruction_address + 1;
#100 Write_instruction = 16'b1110000000000000; // ANDI 0(R0 = 0;)
#100 Write_instruction_address = Write_instruction_address + 1;

#100 Write_instruction = 16'b1100000000001000; // ADDI 8 
#100 Write_instruction_address = Write_instruction_address + 1;
#100 Write_instruction = 16'b0001000001100110; // Store M[102]                      // M[102] = 8;
#100 Write_instruction_address = Write_instruction_address + 1;
#100 Write_instruction = 16'b1110000000000000; // ANDI 0(R0 = 0;)
#100 Write_instruction_address = Write_instruction_address + 1;

#100 Write_instruction = 16'b1100000000001001; // ADDI 9 
#100 Write_instruction_address = Write_instruction_address + 1;
#100 Write_instruction = 16'b0001000001100111; // Store M[103]                      // M[103] = 9;
#100 Write_instruction_address = Write_instruction_address + 1;
#100 Write_instruction = 16'b1110000000000000; // ANDI 0(R0 = 0;)
#100 Write_instruction_address = Write_instruction_address + 1;

#100 Write_instruction = 16'b1100000000001010; // ADDI 10 
#100 Write_instruction_address = Write_instruction_address + 1;
#100 Write_instruction = 16'b0001000001101000; // Store M[104]                      // M[104] = 10;
#100 Write_instruction_address = Write_instruction_address + 1;
#100 Write_instruction = 16'b1110000000000000; // ANDI 0(R0 = 0;)
#100 Write_instruction_address = Write_instruction_address + 1;

#100 Write_instruction = 16'b1100000000001011; // ADDI 11 
#100 Write_instruction_address = Write_instruction_address + 1;
#100 Write_instruction = 16'b0001000001101001; // Store M[105]                      // M[105] = 11;
#100 Write_instruction_address = Write_instruction_address + 1;
#100 Write_instruction = 16'b1110000000000000; // ANDI 0(R0 = 0;)
#100 Write_instruction_address = Write_instruction_address + 1;

#100 Write_instruction = 16'b1100000000001100; // ADDI 12 
#100 Write_instruction_address = Write_instruction_address + 1;
#100 Write_instruction = 16'b0001000001101010; // Store M[106]                      // M[106] = 12;
#100 Write_instruction_address = Write_instruction_address + 1;
#100 Write_instruction = 16'b1110000000000000; // ANDI 0(R0 = 0;)
#100 Write_instruction_address = Write_instruction_address + 1;

#100 Write_instruction = 16'b1100000000001101; // ADDI 13 
#100 Write_instruction_address = Write_instruction_address + 1;
#100 Write_instruction = 16'b0001000001101011; // Store M[107]                      // M[107] = 13;
#100 Write_instruction_address = Write_instruction_address + 1;
#100 Write_instruction = 16'b1110000000000000; // ANDI 0(R0 = 0;)
#100 Write_instruction_address = Write_instruction_address + 1;

#100 Write_instruction = 16'b1100000000001110; // ADDI 14 
#100 Write_instruction_address = Write_instruction_address + 1;
#100 Write_instruction = 16'b0001000001101100; // Store M[108]                      // M[108] = 14;
#100 Write_instruction_address = Write_instruction_address + 1;
#100 Write_instruction = 16'b1110000000000000; // ANDI 0(R0 = 0;)
#100 Write_instruction_address = Write_instruction_address + 1;


#100 Write_instruction = 16'b1100000000001111; // ADDI 15 
#100 Write_instruction_address = Write_instruction_address + 1;
#100 Write_instruction = 16'b0001000001101101; // Store M[109]                      // M[109] = 15;
#100 Write_instruction_address = Write_instruction_address + 1;
#100 Write_instruction = 16'b1110000000000000; // ANDI 0(R0 = 0;)
#100 Write_instruction_address = Write_instruction_address + 1;

#100 Write_instruction = 16'b1100000000010000; // ADDI 16 
#100 Write_instruction_address = Write_instruction_address + 1;
#100 Write_instruction = 16'b0001000001101110; // Store M[110]                      // M[110] = 16;
#100 Write_instruction_address = Write_instruction_address + 1;
#100 Write_instruction = 16'b1110000000000000; // ANDI 0(R0 = 0;)
#100 Write_instruction_address = Write_instruction_address + 1;

#100 Write_instruction = 16'b1100000000010001; // ADDI 17 
#100 Write_instruction_address = Write_instruction_address + 1;
#100 Write_instruction = 16'b0001000001101111; // Store M[111]                      // M[111] = 17;
#100 Write_instruction_address = Write_instruction_address + 1;
#100 Write_instruction = 16'b1110000000000000; // ANDI 0(R0 = 0;)
#100 Write_instruction_address = Write_instruction_address + 1;

#100 Write_instruction = 16'b1100000000010010; // ADDI 18 
#100 Write_instruction_address = Write_instruction_address + 1;
#100 Write_instruction = 16'b0001000001110000; // Store M[112]                      // M[112] = 18;
#100 Write_instruction_address = Write_instruction_address + 1;
#100 Write_instruction = 16'b1110000000000000; // ANDI 0(R0 = 0;)
#100 Write_instruction_address = Write_instruction_address + 1;

#100 Write_instruction = 16'b1100000000010011; // ADDI 19 
#100 Write_instruction_address = Write_instruction_address + 1;
#100 Write_instruction = 16'b0001000001110001; // Store M[113]                      // M[113] = 19;
#100 Write_instruction_address = Write_instruction_address + 1;
#100 Write_instruction = 16'b1110000000000000; // ANDI 0(R0 = 0;)
#100 Write_instruction_address = Write_instruction_address + 1;

#100 Write_instruction = 16'b1100000000010100; // ADDI 20 
#100 Write_instruction_address = Write_instruction_address + 1;
#100 Write_instruction = 16'b0001000001110010; // Store M[114]                      // M[114] = 20;
#100 Write_instruction_address = Write_instruction_address + 1;
#100 Write_instruction = 16'b1110000000000000; // ANDI 0(R0 = 0;)
#100 Write_instruction_address = Write_instruction_address + 1;

#100 Write_instruction = 16'b1100000000010101; // ADDI 21 
#100 Write_instruction_address = Write_instruction_address + 1;
#100 Write_instruction = 16'b0001000001110011; // Store M[115]                      // M[115] = 21;
#100 Write_instruction_address = Write_instruction_address + 1;
#100 Write_instruction = 16'b1110000000000000; // ANDI 0(R0 = 0;)
#100 Write_instruction_address = Write_instruction_address + 1;

#100 Write_instruction = 16'b1100000000010110; // ADDI 22 
#100 Write_instruction_address = Write_instruction_address + 1;
#100 Write_instruction = 16'b0001000001110100; // Store M[116]                      // M[116] = 22;
#100 Write_instruction_address = Write_instruction_address + 1;
#100 Write_instruction = 16'b1110000000000000; // ANDI 0(R0 = 0;)
#100 Write_instruction_address = Write_instruction_address + 1;

#100 Write_instruction = 16'b1100000010000000; // ADDI 128 
#100 Write_instruction_address = Write_instruction_address + 1;
#100 Write_instruction = 16'b0001000001110101; // Store M[117]                      // M[117] = 128;
#100 Write_instruction_address = Write_instruction_address + 1;
#100 Write_instruction = 16'b1110000000000000; // ANDI 0(R0 = 0;)
#100 Write_instruction_address = Write_instruction_address + 1;

#100 Write_instruction = 16'b1100000000010111; // ADDI 23 
#100 Write_instruction_address = Write_instruction_address + 1;
#100 Write_instruction = 16'b0001000001110110; // Store M[118]                      // M[118] = 23;
#100 Write_instruction_address = Write_instruction_address + 1;
#100 Write_instruction = 16'b1110000000000000; // ANDI 0(R0 = 0;)
#100 Write_instruction_address = Write_instruction_address + 1;

#100 Write_instruction = 16'b1100000000011000; // ADDI 24 
#100 Write_instruction_address = Write_instruction_address + 1;
#100 Write_instruction = 16'b0001000001110111; // Store M[119]                      // M[119] = 24;
#100 Write_instruction_address = Write_instruction_address + 1;
#100 Write_instruction = 16'b1110000000000000; // ANDI 0(R0 = 0;)
#100 Write_instruction_address = Write_instruction_address + 1;

#100 Write_instruction = 16'b1100000001100100; // ADDI 100 
#100 Write_instruction_address = Write_instruction_address + 1;
#100 Write_instruction = 16'b1000001000000001; // MoveTo R1                      // R1 = Current_Address = 100;
#100 Write_instruction_address = Write_instruction_address + 1;
#100 Write_instruction = 16'b1110000000000000; // ANDI 0(R0 = 0;)
#100 Write_instruction_address = Write_instruction_address + 1;

#100 Write_instruction = 16'b1100000001111000; // ADDI 120 
#100 Write_instruction_address = Write_instruction_address + 1;
#100 Write_instruction = 16'b1000010000000001; // MoveTo R2                      // R2 = End_Address = 120;
#100 Write_instruction_address = Write_instruction_address + 1;
#100 Write_instruction = 16'b1110000000000000; // ANDI 0(R0 = 0;)
#100 Write_instruction_address = Write_instruction_address + 1;

#100 Write_instruction = 16'b1100100000000000; // ADDI 100000000000
#100 Write_instruction_address = Write_instruction_address + 1;
#100 Write_instruction = 16'b1000100000000001; // MoveTo R4                      // R4 = 100000000000;
#100 Write_instruction_address = Write_instruction_address + 1;
#100 Write_instruction = 16'b1110000000000000; // ANDI 0(R0 = 0;)
#100 Write_instruction_address = Write_instruction_address + 1;

#100 Write_instruction = 16'b1000001000000010; // MoveFrom R1                    // R0 = R1 = Start_Address
#100 Write_instruction_address = Write_instruction_address + 1;

#100 Write_instruction = 16'b0100010001011111; // BranchZ R2(End_Address), END_Loop(95)  // for(; Current_Address != End_Address; Current_Address++)
#100 Write_instruction_address = Write_instruction_address + 1;

#100 Write_instruction = 16'b1000001000000001; // MoveTo R1
#100 Write_instruction_address = Write_instruction_address + 1;

#100 Write_instruction = 16'b0000000001100100; // Load M[100]                    // R0 = M[i];
#100 Write_instruction_address = Write_instruction_address + 1;

#100 Write_instruction = 16'b1000011000000001; // MoveTo R3                      // R3(temp) = R0 = M[i];
#100 Write_instruction_address = Write_instruction_address + 1;

#100 Write_instruction = 16'b1000101000001000; // SUB R5                         // R0 - R5; we assumed that max is in R22
#100 Write_instruction_address = Write_instruction_address + 1;

#100 Write_instruction = 16'b1000100000010000; // AND R4                         // R0 - R5 && R4(100000000000); : Checking if R0 is larger than Rmax(R5) 
#100 Write_instruction_address = Write_instruction_address + 1;

#100 Write_instruction = 16'b0100100001011010; // BranchZ R4, 90                 // if(R0 < R5) then Jump 91
#100 Write_instruction_address = Write_instruction_address + 1;
                                                                                 // else (R0(M[i]) > Rmax(R5))
#100 Write_instruction = 16'b1000011000000010; // MoveFrom R3                    // R0 = R3 = M[i];
#100 Write_instruction_address = Write_instruction_address + 1;

#100 Write_instruction = 16'b1000101000000001; // MoveTo Rmax(R5)                // R5(Rmax) = R0 = M[i];
#100 Write_instruction_address = Write_instruction_address + 1;

#100 Write_instruction = 16'b1000001000000010; // MoveFrom R1                    // R0 = R1 = Current_Address;
#100 Write_instruction_address = Write_instruction_address + 1;
#100 Write_instruction = 16'b1101000001100100; // SUBI 100                       // R0 = R0 - 100; (generating index of current element)
#100 Write_instruction_address = Write_instruction_address + 1;
#100 Write_instruction = 16'b1000110000000001; // MoveTo R6                      // R6(Index of Max Element) = R0 = i;
#100 Write_instruction_address = Write_instruction_address + 1;
#100 Write_instruction = 16'b0010000001011010; // JUMP 91
#100 Write_instruction_address = Write_instruction_address + 1;


#100 Write_instruction_address = 91;

#100 Write_instruction = 16'b1000001000000010; // MoveFrom R1                    // R0 = R1 = Current_Address;
#100 Write_instruction_address = Write_instruction_address + 1;
#100 Write_instruction = 16'b1100000000000001; // ADDI 1                         // (R0 = Current_Address)++
#100 Write_instruction_address = Write_instruction_address + 1;
#100 Write_instruction = 16'b0001000001001001; // Store M[73]                   //  Current_Address++
#100 Write_instruction_address = Write_instruction_address + 1;   
#100 Write_instruction = 16'b0010000001000110; // JUMP 70
#100 Write_instruction_address = Write_instruction_address + 1;  

#100 Write_instruction_address = 96;

#100 Write_instruction = 16'b1000101000000010; // MoveFrom R5                    // R0 = R5(max);
#100 Write_instruction_address = Write_instruction_address + 1;
#100 Write_instruction = 16'b0001000010000000; // Store M[128]                   //  M[128] = max;
#100 Write_instruction_address = Write_instruction_address + 1; 
#100 Write_instruction = 16'b1000110000000010; // MoveFrom R6                    // R0 = R6(Index of Max Element);
#100 Write_instruction_address = Write_instruction_address + 1;
#100 Write_instruction = 16'b0001000010000001; // Store M[129]                   //  M[129] = Index of Max Element;
#100 Write_instruction_address = Write_instruction_address + 1;                                                           

/*
         //R3 = copy of R0
moveFrom(R1) - Branch R2 Jump End_Loop - moveTo(R1) - load(M[100]) - moveTo(R3) - sub(Rmax) - and(R4 = 1000000000) - beq(R4, jump A) - A: moveFrom(R1) - addI(1) - store - Jump Branch
                                                          - moveFrom(R3)
                                                          - moveTo Rmax // max = 5
                                                          - moveFrom(R1)
                                                          - subI 100
                                                          - moveTo maxIndex
                                                          - jump A
*/



#100 reset = 1; instruction_Write_en = 0;

#200 reset = 0;

#160000 $stop;

end

endmodule