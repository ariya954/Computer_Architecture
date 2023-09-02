module ARM_ID_Control_Unit(
	input Status_update_enable_in,
	input [1 : 0]mode,
	input [3 : 0]opcode,
	output reg S, B, mem_write, mem_read, WB_Enable, move,
	output reg [3 : 0]EXE_CMD
);

always @(Status_update_enable_in, mode, opcode) begin
	{B, mem_write, mem_read, WB_Enable, move, EXE_CMD} = 9'b0;
	S = Status_update_enable_in;
	case(mode)
		2'b10 : B = 1;
		2'b01 : begin : LDR_STR
				EXE_CMD = 4'b0010;
				if(Status_update_enable_in) begin
					mem_read = 1;
					WB_Enable = 1;
                                        S = 1;
				end
				else
					mem_write = 1;
                                        S = 0;
				
			end
		2'b00 : begin
				case(opcode)
					4'b1101 : begin : MOV
							  EXE_CMD = 4'b0001;
					  		  WB_Enable = 1;
                                                          move = 1;
					  	  end
					4'b1111 : begin : MVN
							  EXE_CMD = 4'b1001;
					  		  WB_Enable = 1;
                                                          move = 1;
					  	  end
					4'b0100 : begin : ADD
							  EXE_CMD = 4'b0010;
					  		  WB_Enable = 1;
					  	  end
					4'b0101 : begin : ADC
							  EXE_CMD = 4'b0011;
					  		  WB_Enable = 1;
					  	  end
					4'b0010 : begin : SUB
							  EXE_CMD = 4'b0100;
					  		  WB_Enable = 1;
					  	  end
					4'b0110 : begin : SBC
							  EXE_CMD = 4'b0101;
					  		  WB_Enable = 1;
						  end
					4'b0000 : begin : AND
							  EXE_CMD = 4'b0110;
					  		  WB_Enable = 1;
					  	  end	
					4'b1100 : begin : OR
							  EXE_CMD = 4'b0111;
					  		  WB_Enable = 1;
					  	  end				  	
					4'b0001 : begin : EOR
							  EXE_CMD = 4'b1000;
					  		  WB_Enable = 1;
					  	  end	
					4'b1010 : begin : CMP
							  EXE_CMD = 4'b0100;
                                                          S = 1;
					  	  end	
					4'b1000 : begin : TST
							  EXE_CMD = 4'b0110;
                                                          S = 1;
					  	  end	
				endcase
			end
	endcase

end

endmodule