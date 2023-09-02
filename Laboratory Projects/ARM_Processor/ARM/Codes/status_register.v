module status_register(
    input clk, reset, Status_update,
    input [3 : 0]Status_bits_in,
    output reg[3 : 0]Status_bits_out
);
    
always @(negedge clk, posedge reset) begin
    if(reset)
       Status_bits_out = 4'b0;
    else if (Status_update)
       Status_bits_out = Status_bits_in;
    end

endmodule