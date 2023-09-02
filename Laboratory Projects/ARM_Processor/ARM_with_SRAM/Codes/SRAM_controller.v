module SRAM_controller(
    clk, reset, w_en, r_en, address, write_data, ready, SRAM_UB_N, SRAM_LB_N, SRAM_WE_N,
    SRAM_CE_N, SRAM_OE_N,SRAM_ADDR, read_data, SRAM_DQ);

    input clk, reset, w_en, r_en;
    input [31 : 0] address, write_data;
    output reg ready;
    output SRAM_UB_N, SRAM_LB_N, SRAM_CE_N, SRAM_OE_N;
    output reg SRAM_WE_N;
    output reg [17 : 0] SRAM_ADDR;
    output reg [31 : 0] read_data;
    inout [15 : 0] SRAM_DQ;
    
    reg [15 : 0] DQ; 
    
    reg [2 : 0] ps, ns, counter;
    reg init, count_en, ldu, ldd;
    
    wire co;
    
    assign {SRAM_UB_N, SRAM_LB_N, SRAM_CE_N, SRAM_OE_N} = 4'd0;
    
    always @(posedge clk, posedge reset) begin
      if(reset)
        ps <= 0;
      else
        ps <= ns;
    end
    
    
    always @(ps, w_en, r_en, co) begin
      case(ps)
        0: ns = (r_en) ? 1 : (w_en) ? 4 : 0;
        1: ns = 2;
        2: ns = 3;
        3: ns = 6;
        4: ns = 5;
        5: ns = 6;
        6: ns = (co) ? 7 : 6;
        7: ns = 0;
      endcase
    end
    
    assign SRAM_DQ = DQ;
    
    always @(ps, w_en, r_en) begin
      ready = 0; init = 0; DQ = 16'bz; count_en = 0; SRAM_WE_N = 1; ldu = 0; ldd = 0; SRAM_ADDR = 0;
      case(ps)
        0: begin 
             ready = 1; 
             if(w_en || r_en) begin init = 1; ready = 0; end
        end
        1: begin
             SRAM_WE_N = 1; count_en = 1;
             SRAM_ADDR = (address - 32'd1024) >> 1;
             ldd = 1;
        end
        2: begin
             SRAM_WE_N = 1; count_en = 1;
             SRAM_ADDR = ((address - 32'd1024) >> 1 )+ 1;
             ldu = 1;
        end
        3: begin
             count_en = 1;
        end
        4: begin
             SRAM_WE_N = 0;
             SRAM_ADDR = (address - 32'd1024) >> 1;
             DQ = write_data[15 : 0];
             count_en = 1;
        end
        5: begin
             SRAM_WE_N = 0;
             SRAM_ADDR = ((address - 32'd1024) >> 1 )+ 1;
             DQ = write_data[31 : 16];
             count_en = 1;
        end
        6: count_en = 1;
        7: ready = 1;
      endcase
    end
    
    always @(posedge clk, posedge reset) begin
      if(reset)
        read_data = 0;
      else if(ldd)
        read_data[15 : 0] = SRAM_DQ;
      else if(ldu)
        read_data[31 : 16] = SRAM_DQ;   
    end
     

    always@(posedge clk, posedge reset) begin
        if (reset)
          counter = 3'b0;
        else if(init) 
           counter = 3'b0;  
        else if (count_en)
           counter = counter + 3'd1;    
    end
    
    assign co = (counter == 3'd3) ? 1 : 0;
    
endmodule
