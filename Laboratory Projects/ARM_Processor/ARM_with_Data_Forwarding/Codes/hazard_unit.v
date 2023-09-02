module hazard_unit(
    input two_src, move, WB_MEM, WB_EXE,
    input [3 : 0] RegDest_MEM, RegDest_EXE, Rn, Rm, input MEM_R_EN_EXE,
    output reg hazard
);
    
    always @* begin
        hazard = 1'b0;
	if(MEM_R_EN_EXE) begin
           if (two_src)
               if(WB_EXE & (RegDest_EXE == Rm))
                   hazard = 1'b1;
           if(WB_EXE & (RegDest_EXE == Rn))
                   hazard = 1'b1;
	end

    end

endmodule
