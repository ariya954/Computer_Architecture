module PipeLine_MIPS_Data_Path(input clk);

wire PCWrite, IF_ID_Write, MemReadEX, RegWriteM, RegWriteWB;
wire [2  : 0] ctrlIF, ctrlM_ID, ctrlWB_ID, ctrlM_EX, ctrlWB_EX, ctrlM_M, ctrlWB_M, ctrlWB_WB;
wire [4  : 0] ctrlEX_ID, ctrlEX_EX, WriteRegister, RtEX, RsEX, RdEX, Rs, Rt, Rd, DstRegEX, DstRegM, DstRegWB;
wire [5  : 0] Func, FuncOut;
wire [31 : 0] JmpAdr, JrAdr, BeqAdr, Inst, PC4, adrID, Out_inst, WriteData, ReadData1, ReadData2, Offset, ReadData1_out, ReadData2_out, Offset_out, adrEX, adrM, adrWB, MemoryAdr, ALUResult, ALUB, ALU1, MemoryAdrOut, WriteDataMem, ReadDataMem, ReadDataWB, MemoryAdrWB;

assign MemReadEX = ctrlM_EX[1];
assign RegWriteM = ctrlM_M[2];
assign RegWriteWB = ctrlWB_WB[2];
assign WriteRegister = DstRegWB;
assign ALU1 = WriteData;

Stage_IF IF(clk, ctrlIF, PCWrite, JmpAdr, JrAdr, BeqAdr, Inst, PC4);
IF_ID IF_to_ID(clk, IF_ID_Write, PC4, Inst, adrID, Out_inst);
Stage_ID ID(clk, RegWriteWB, WriteRegister, MemReadEX, RtEX, adrID, Out_inst, WriteData, IF_ID_Write, PCWrite, BeqAdr, JmpAdr, JrAdr, ReadData1, ReadData2, Offset, Rs, Rt, Rd, Func, ctrlWB_ID, ctrlM_ID, ctrlEX_ID, ctrlIF);
ID_EX ID_to_EX(clk, adrID, ctrlWB_ID, ctrlM_ID, ctrlEX_ID, ReadData1, ReadData2, Offset, Rt, Rd, Rs, Func, adrEX, ctrlWB_EX, ctrlM_EX, ctrlEX_EX, ReadData1_out, ReadData2_out, Offset_out, RdEX, RtEX, RsEX, FuncOut);
Stage_EX EX(clk, RegWriteM, RegWriteWB, ctrlEX_EX, RtEX, RsEX, RdEX, DstRegM, DstRegWB, FuncOut, Offset_out, ReadData1_out, ReadData2_out, ALU1, MemoryAdr, DstRegEX, ALUResult, ALUB);
EX_M EX_to_M(clk, adrEX, ctrlWB_EX, ctrlM_EX, ALUResult, ALUB, DstRegEX, adrM, ctrlWB_M, ctrlM_M, MemoryAdr, WriteDataMem, DstRegM);
Stage_MEM M(clk, ctrlM_M, MemoryAdr, WriteDataMem, MemoryAdrOut, ReadDataMem);
M_WB M_to_WB(clk, adrM, ctrlWB_M, MemoryAdrOut, ReadDataMem, DstRegM, adrWB, ctrlWB_WB, MemoryAdrWB, ReadDataWB, DstRegWB);
Stage_Write_Back WB(ctrlWB_WB, adrWB, MemoryAdrWB, ReadDataWB, WriteData);
	
endmodule 
