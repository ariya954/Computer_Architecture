module hazard_unit(
    input two_src, move, WB_MEM, WB_EXE,
    input [3 : 0] RegDest_MEM, RegDest_EXE, Rn, Rm,
    output reg hazard
);
    
    always @* begin
        hazard = 1'b0;
        if (two_src)
            if((WB_EXE & (RegDest_EXE == Rm)) | (WB_MEM & (RegDest_MEM == Rm)))
                hazard = 1'b1;
        if (~move)
            if ((WB_EXE & (RegDest_EXE == Rn)) | (WB_MEM & (RegDest_MEM == Rn)))
                hazard = 1'b1;

    end

endmodule
