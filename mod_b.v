module mod_b(
    input clk, rst,
    input [7:0] data_in,
    output reg [7:0] data_out,
    output reg rd_enb
);

    // State encoding
    parameter idle       = 2'b00;
    parameter s1         = 2'b01;
    parameter data_state = 2'b10;

    reg [1:0] ps, ns;  // present state, next state

    // Sequential block: state update
    always @(posedge clk) begin
        if (rst)
            ps <= idle;
        else
            ps <= ns;
    end

    // Combinational block: next state logic + outputs
    always @(*) begin
        case (ps)
            idle: begin
                ns = data_state;
                rd_enb = 0;
            end
           /* s1: begin
                ns = data_state;
                rd_enb = 0;
            end*/
            data_state: begin
                ns = idle;
                rd_enb = 1;
                data_out = data_in;  // latch data when in data_state
            end
            default: begin
                ns = idle;
                rd_enb = 0;
                data_out = 0;
            end
        endcase
    end

endmodule
