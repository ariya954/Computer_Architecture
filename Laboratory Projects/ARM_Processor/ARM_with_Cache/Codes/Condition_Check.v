module Condition_Check(
	input [3 : 0]cond, status_register_bits,
	output reg condition
);

wire N, Z, C, V;

assign {N, Z, C, V} = status_register_bits;

always @(N, Z, C, V, cond)begin

	case(cond)
		4'b0000 : begin : EQ
			          condition = Z;
			  end
		4'b0001 : begin : NE
			          condition = !Z;
			  end
		4'b0010 : begin : CS_HS
			          condition = C;
			  end
		4'b0011 : begin : CC_LO
			          condition = !C;
			  end
		4'b0100 : begin : MI
			          condition = N;
			  end
		4'b0101 : begin : PL
			          condition = !N;
			  end
		4'b0110 : begin : VS
			          condition = V;
			  end
		4'b0111 : begin : VC
			          condition = !V;
			  end
		4'b1000 : begin : HI
			          condition = C & !Z;
			  end
		4'b1001 : begin : LS
			          condition = !C & Z;
			  end
		4'b1010 : begin : GE
			          condition = (N & V) | (!N & !V);
			  end
		4'b1011 : begin : LT
			          condition = (N & !V) | (!N & V);
			  end
		4'b1100 : begin : GT
			          condition = !Z & (N == V);
			  end
		4'b1101 : begin : LE
			          condition = Z | (N != V);
			  end
		4'b1110 : begin : AL
			          condition = 1'b1;
			  end
	endcase

end

endmodule