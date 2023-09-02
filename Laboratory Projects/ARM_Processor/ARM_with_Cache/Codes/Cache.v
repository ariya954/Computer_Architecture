module cache(
    input clk, reset, write_enable, read_enable, cache_write, sram_ready,
    input [31:0] address, write_data,
    output hit, freeze_arm,
    output SRAM_w_en, SRAM_r_en,
    output [31:0] SRAM_ADDR,
    output [31:0] read_data,
    output [31:0] SRAM_W_DQ,
    input [31:0] SRAM_DQ
);
    integer i;
    wire hit_way_0, hit_way_1;
    wire [2:0] offset;
    wire [5:0] index;
    wire [8:0] tag;
    wire [63:0] way_data;
    reg least_used_block [63:0];
    reg valid_block_0 [63:0];
    reg valid_block_1 [63:0];
    reg [8:0] tag_block_0 [63:0];
    reg [8:0] tag_block_1 [63:0];
    reg [63:0] data_block_0 [63:0];
    reg [63:0] data_block_1 [63:0];

    assign offset = address[2:0];
    assign index = address[8:3];
    assign tag = address[10:2];
    assign hit_way_0 = (tag_block_0[index] == tag) & valid_block_0[index];
    assign hit_way_1 = (tag_block_1[index] == tag) & valid_block_1[index];
    assign hit = hit_way_0 | hit_way_1;
    assign freeze_arm = (hit & ~write_enable) | sram_ready;
    assign SRAM_w_en = write_enable;
    assign SRAM_r_en = (~hit & read_enable);
    assign SRAM_ADDR = address;
    assign way_data = hit_way_0? data_block_0[index] : (hit_way_1? data_block_1[index] : 64'bz);
    assign read_data = offset[2]? way_data[63:32] : way_data[31:0];
    assign SRAM_W_DQ = write_data;

    always @(posedge clk, posedge reset) begin: write_to_cache
        if (reset) begin
            for (i=0;i<64;i=i+1) begin
                valid_block_0[i] = 1'b0;
                valid_block_1[i] = 1'b0;
                tag_block_0[i] = 9'b0;
                tag_block_1[i] = 9'b0;
                least_used_block[i] = 1'b0;
            end
        end
        if (cache_write)
            if (least_used_block[index]) begin: write_to_way_1
                valid_block_1[index] = 1'b1;
                tag_block_1[index] = tag;
                if (offset[2])
                    data_block_1[index][63:32] = SRAM_DQ;
                else
                    data_block_1[index][31:0] = SRAM_DQ;
            end
            else begin: write_to_way_0
                valid_block_0[index] = 1'b1;
                tag_block_0[index] = tag;
                if (offset[2])
                    data_block_0[index][63:32] = SRAM_DQ;
                else
                    data_block_0[index][31:0] = SRAM_DQ;
            end
        if (sram_ready & write_enable) begin
            if (hit_way_0)
                valid_block_0[index] = 1'b0;
            if (hit_way_1)
                valid_block_1[index] = 1'b0;
        end
        if (sram_ready & read_enable) begin
            if (hit_way_0)
                least_used_block[index] = 1'b1;
            if (hit_way_1)
                least_used_block[index] = 1'b0;
        end
    end


endmodule
