module ALU_Controller(input [1 : 0]ALU_Op, input [5 : 0]Func, output reg [2 : 0]ALU_operation);

always @(ALU_Op or Func) begin
	case(ALU_Op)
	    2'b00://add, sub, and, or, slt
		  begin 
		    if(Func == 6'b000001) begin  
			ALU_operation = 3'd0;  //add
		    end else if(Func == 6'b000010) begin
		                  ALU_operation = 3'd1;  //sub
		    end else if(Func == 6'b000100) begin
			ALU_operation = 3'd2;  //and
		    end else if(Func == 6'b001000) begin
			ALU_operation = 3'd3;  //or
		    end else if(Func == 6'b010000) begin
			ALU_operation = 3'd4;  //slt
		    end
		  end
				
	    2'b01://addi, lw, sw
		  begin 
			ALU_operation = 3'd0;  //add
		  end

	    2'b10://slti 
		  begin 
			ALU_operation = 3'd4;  //slt
		  end
	    2'b11://beq
		  begin 
			ALU_operation = 3'd1;  //sub
		  end
        endcase
end

endmodule

module Hazard_Unit(input clk, input [4 : 0]Rs_ID, Rt_ID, Rt_EX, input Mem_Read_EX, output reg PC_Write, IF_ID_Write, Hazard_Control_Signal);
	
always @(negedge clk) begin
	if(Mem_Read_EX && ((Rt_ID == Rt_EX) || (Rs_ID == Rt_EX)))
		{PC_Write, IF_ID_Write, Hazard_Control_Signal} = 3'b001;
	else
		{PC_Write, IF_ID_Write, Hazard_Control_Signal} = 3'b110;
end

endmodule

module Forwarding_Unit(input clk, Reg_Write_Mem, Reg_Write_WB, input [4 : 0]Rs_EX, Rt_EX, Rd_Mem, Rd_WB, output reg [1 : 0]Forward_A, Forward_B);
	
always @(negedge clk) begin
	if((Reg_Write_Mem == 1) && (Rd_Mem == Rs_EX) && ~(Rd_Mem == 5'd0)) begin
		Forward_A = 2'b10;
	end else if ((Reg_Write_WB == 1) && (Rd_WB == Rs_EX) && ~(Rd_WB == 5'd0)) begin
		Forward_A = 2'b01;
	end else begin 
		Forward_A = 2'b00;
	end
end

always @(negedge clk) begin
	if((Reg_Write_Mem == 1) && (Rd_Mem == Rt_EX) && ~(Rd_Mem == 5'd0)) begin
		Forward_B = 2'b10;
	end else if ((Reg_Write_WB == 1) && (Rd_WB == Rt_EX) && ~(Rd_WB == 5'd0)) begin
		Forward_B = 2'b01;
	end else begin 
		Forward_B = 2'b00;
	end
end

endmodule

`define RT 6'b000000
`define ADDI 6'b000001
`define SLTI 6'b000010
`define LW 6'b000011
`define SW 6'b000100
`define BEQ 6'b000101
`define J 6'b000110
`define JR 6'b000111
`define JAL 6'b001000
module Controller(input clk, EQ,input [5 : 0]OPC, output reg Reg_Dst, Reg_Write, Jal, Jr, Jump, Mem_to_Reg, Mem_Read, Mem_Write, ALU_Src, PC_Src, output reg [1 : 0]ALU_Op);

always@(OPC or EQ) begin 
	{Reg_Dst, Reg_Write, Jal, Jr, Jump, Mem_to_Reg, Mem_Read, Mem_Write, ALU_Src, PC_Src, ALU_Op} = 12'd0;
	case(OPC)
		`RT: begin
			Reg_Dst = 1;
			Jal = 0;
			Reg_Write = 1;
			ALU_Src = 0;
			ALU_Op = 2'b00;
			Mem_Read = 0;
			Mem_Write = 0;
			Mem_to_Reg = 0;
			PC_Src = 0;
			Jump = 0;
			Jr = 0;
		end
		`ADDI: begin 
			Reg_Dst = 0;
			Jal = 0;
			Reg_Write = 1;
			ALU_Src = 1;
			ALU_Op = 2'b01;
			Mem_Read = 0;
			Mem_Write = 0;
			Mem_to_Reg = 0;
			PC_Src = 0;
			Jump = 0;
			Jr = 0;
		end
		`SLTI: begin 
			Reg_Dst = 0;
			Jal = 0;
			Reg_Write = 1;
			ALU_Src = 1;
			ALU_Op = 2'b10;
			Mem_Read = 0;
			Mem_Write = 0;
			Mem_to_Reg = 0;
			PC_Src = 0;
			Jump = 0;
			Jr = 0;
		end
		`LW: begin 
			Reg_Dst = 0;
			Jal = 0;
			Reg_Write = 1;
			ALU_Src = 1;
			ALU_Op = 2'b01;
			Mem_Read = 1;
			Mem_Write = 0;
			Mem_to_Reg = 1;
			PC_Src = 0;
			Jump = 0;
			Jr = 0;
		end
		`SW: begin 
			Reg_Dst = 0;
			Jal = 0;
			Reg_Write = 0;
			ALU_Src = 1;
			ALU_Op = 2'b01;
			Mem_Read = 0;
			Mem_Write = 1;
			Mem_to_Reg = 0;
			PC_Src = 0;
			Jump = 0;
			Jr = 0;
		end
		`BEQ: begin 
			Reg_Dst = 0;
			Jal = 0;
			Reg_Write = 0;
			ALU_Src = 0;
			ALU_Op = 2'b11;
			Mem_Read = 0;
			Mem_Write = 0;
			Mem_to_Reg = 0;
			PC_Src = EQ;
			Jump = 0;
			Jr = 0;
		end
		`J: begin 
			Reg_Dst = 0;
			Jal = 0;
			Reg_Write = 0;
			ALU_Src = 0;
			ALU_Op = 2'b00;
			Mem_Read = 0;
			Mem_Write = 0;
			Mem_to_Reg = 0;
			PC_Src = 0;
			Jump = 1;
			Jr = 0;
		end
		`JR: begin 
			Reg_Dst = 0;
			Jal = 0;
			Reg_Write = 0;
			ALU_Src = 0;
			ALU_Op = 2'b00;
			Mem_Read = 0;
			Mem_Write = 0;
			Mem_to_Reg = 0;
			PC_Src = 0;
			Jump = 0;
			Jr = 1;
		end
		`JAL: begin 
			Reg_Dst = 0;
			Jal = 1;
			Reg_Write = 1;
			ALU_Src = 0;
			ALU_Op = 2'b00;
			Mem_Read = 0;
			Mem_Write = 0;
			Mem_to_Reg = 0;
			PC_Src = 0;
			Jump = 1;
			Jr = 0;
		end
	endcase
end

endmodule
