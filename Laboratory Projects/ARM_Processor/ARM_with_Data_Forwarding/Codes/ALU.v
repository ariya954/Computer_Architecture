module ALU(Val_1, Val_2, status_register, EXE_CMD, status, result);
	input [31 : 0]Val_1, Val_2;
	input [3 : 0] status_register, EXE_CMD;
	output [3 : 0] status;
	output reg [31 : 0]result;

wire N, Z, N_in, Z_in, C_in, V_in;
reg C, V;

assign {N_in, Z_in, C_in, V_in} = status_register;
assign N = result[31];
assign Z = ~(|result);
assign status = {N, Z, C, V};

always @(Val_1, Val_2, status_register, EXE_CMD) begin
	C = C_in;
	V = V_in;
	case(EXE_CMD)
		4'b0001: begin : MOV
	             result = Val_2;
		end
		4'b1001: begin : MVN
	             result = ~Val_2;
		end
		4'b0010: begin : ADD
	             {C, result} = Val_1 + Val_2;
		      V = (Val_1[31] & Val_2[31] & ~result[31]) | (~Val_1[31] & ~Val_2[31] & result[31]);
		end
		4'b0011: begin : ADC
	             {C, result} = Val_1 + Val_2 + C_in;
		      V = (Val_1[31] & Val_2[31] & ~result[31]) | (~Val_1[31] & ~Val_2[31] & result[31]);
		end
		4'b0100: begin : SUB
	             {C, result} = Val_1 - Val_2;
		      V = ((~Val_1[31] & Val_2[31]) & result[31]) | ((Val_1[31] & ~Val_2[31]) & ~result[31]);
		end
		4'b0101: begin : SUB_WITH_CARRY
	             {C, result} = Val_1 - Val_2 - {31'b0, ~C_in};
		      V = ((~Val_1[31] & Val_2[31]) & result[31]) | ((Val_1[31] & ~Val_2[31]) & ~result[31]);
		end
		4'b0110: begin : AND
	             result = Val_1 & Val_2;
		end
		4'b0111: begin : ORR
	             result = Val_1 | Val_2;
		end
		4'b1000: begin : XOR
	             result = Val_1 ^ Val_2;
		end
		default: result = 32'b0;
	endcase
end

endmodule