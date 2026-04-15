module fifo_8_8(
    input clk, rst, wr_en, rd_en,
    input [7:0] data_in,
    output reg [7:0] data_out,
    output full, empty
    );

    reg [2:0] wr_ptr = 0;   // write pointer
    reg [2:0] rd_ptr = 0;   // read pointer
    reg [7:0] mem [0:7];    // 8x8 memory array

    integer i;

    always @(posedge clk) begin
        if (rst) begin
            wr_ptr <= 0;
            rd_ptr <= 0;
            data_out <= 0;
            for (i = 0; i < 8; i = i + 1)
                mem[i] <= 0;
        end
        if (wr_en && !full) begin
            mem[wr_ptr] <= data_in;
            wr_ptr <= wr_ptr + 1'b1;
        end
        if (rd_en && !empty) begin
            data_out <= mem[rd_ptr];
            rd_ptr <= rd_ptr + 1'b1;
        end
    end

    // Status signals
    assign full  = ((wr_ptr + 1'b1) == rd_ptr);
    assign empty = (wr_ptr == rd_ptr);

endmodule
