module Val_2_Generator(
    input I, mem_read_or_write,
    input [11 : 0] shifter_operand,
    input [31 : 0] reg_2,
    output reg [31 : 0] Val_2
);
    
    wire [3:0] rotate_immediate;
    wire [7:0] immediate_8;
    wire [1:0] shift;
    wire [4:0] shift_immediate;
    wire [63:0]arithmatic_shift_bus, rotate_bus, immediate_rotate_bus;

    assign rotate_immediate = shifter_operand[11 : 8];
    assign immediate_8 = shifter_operand[7 : 0];
    assign shift_immediate = shifter_operand[11 : 7];
    assign shift = shifter_operand[6 : 5];
    assign arithmatic_shift_bus = {{32{reg_2[31]}}, reg_2};
    assign rotate_bus = {2{reg_2}};
    assign immediate_rotate_bus = {2{{24'b0}, immediate_8}};

    always @* begin
        Val_2 = 32'b0;
        if (mem_read_or_write) begin: STR_LDR // Load Store
            Val_2 = {20'b0, shifter_operand};
        end
        else if (I) begin: immediate
            Val_2 = immediate_rotate_bus[ 31 + (rotate_immediate << 1) -: 32];
        end
        else begin
            case (shift)
                2'b00: begin: LSL // Logical Shift Left
                    Val_2 = reg_2 << shift_immediate;
                end
                2'b01: begin: LSR // Logical Shift Right
                    Val_2 = reg_2 >> shift_immediate;
                
                end
                2'b10: begin: ASR // Arithmatic Shift Right
                    Val_2 = arithmatic_shift_bus[31 + shift_immediate -: 32];
                end
                2'b11: begin: ROR // Rotate Right
                    Val_2 = rotate_bus[31 + shift_immediate -: 32];
                end
            endcase
        end
    end

endmodule