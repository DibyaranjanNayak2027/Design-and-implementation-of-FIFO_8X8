module fifo_8_8 (
    input wire clk,
    input wire rst,
    input wire wr_en,
    input wire rd_en,
    input wire [7:0] data_in,
    output reg [7:0] data_out,
    output wire full,
    output wire empty
);

    reg [3:0] wr_ptr;
    reg [3:0] rd_ptr;
    reg [7:0] mem [0:7];

    integer i;

    always @(posedge clk) begin
        if (rst) begin
            wr_ptr <= 4'd0;
            for (i = 0; i < 8; i = i + 1)
                mem[i] <= 8'd0;
        end else if (wr_en && !full) begin
            mem[wr_ptr[2:0]] <= data_in; // Use lower 3 bits for memory address
            wr_ptr <= wr_ptr + 1'b1;
        end
    end

    always @(posedge clk) begin
        if (rst) begin
            rd_ptr <= 4'd0;
            data_out <= 8'd0;
        end else if (rd_en && !empty) begin
            data_out <= mem[rd_ptr[2:0]]; // Use lower 3 bits for memory address
            rd_ptr <= rd_ptr + 1'b1;
        end
    end

    assign empty = (wr_ptr == rd_ptr);

    // Full: MSBs differ (different lap), lower 3 bits are equal (same index)
    assign full  = (wr_ptr[3] != rd_ptr[3]) && (wr_ptr[2:0] == rd_ptr[2:0]);

endmodule
