module fifo_top(
    input clk, rst,
    input [7:0] data_top,
    output [7:0] data_out_top
);

    // Internal wires
    wire [7:0] data_out_temp;
    wire wr_enb, rd_enb;
    wire full, empty;
    wire [7:0] data_out_fifo;

    // Instantiate mod_a (data register + write enable)
    mod_a mod1 (
        .clk(clk),
        .rst(rst),
        .data_in(data_top),
        .data_out(data_out_temp),
        .wr_enb(wr_enb)
    );

    // Instantiate FIFO (8x8 buffer)
    fifo_8_8 fifo (
        .clk(clk),
        .rst(rst),
        .wr_en(wr_enb),
        .rd_en(rd_enb),
        .data_in(data_out_temp),
        .data_out(data_out_fifo),
        .full(full),
        .empty(empty)
    );

    // Instantiate mod_b (FSM controller)
    mod_b mod2 (
        .clk(clk),
        .rst(rst),
        .data_in(data_out_fifo),
        .data_out(data_out_top),
        .rd_enb(rd_enb)
    );

endmodule
