module mod_a(
    input clk, rst,
    input [7:0] data_in,
    output reg [7:0] data_out,
    output reg wr_enb
);

    always @(posedge clk) begin
        if (rst) begin
            data_out <= 8'd0;
            wr_enb   <= 1'b0;
        end
        else begin
            data_out <= data_in;
            wr_enb   <= 1'b1;
        end
    end

endmodule
