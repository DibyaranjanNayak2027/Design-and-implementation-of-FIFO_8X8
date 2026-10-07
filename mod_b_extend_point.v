module mod_b (
    input  wire       clk,
    input  wire       rst,
    input  wire       fifo_empty, // FIFO status flag
    input  wire [7:0] data_in,    // FIFO data output
    output reg  [7:0] data_out,   // Module B processed data output
    output reg        rd_enb      // FIFO read enable
);

    // State encoding
    localparam IDLE      = 1 me;
    localparam READ_WAIT = 1'b1; // Wait cycle for FIFO output register

    reg state;

    // FSM State Machine + Read Enable Logic
    always @(posedge clk) begin
        if (rst) begin
            state    <= IDLE;
            rd_enb   <= 1'b0;
            data_out <= 8'd0;
        end else begin
            case (state)
                IDLE: begin
                    // Trigger read only if FIFO has data
                    if (!fifo_empty) begin
                        rd_enb <= 1'b1;
                        state  <= READ_WAIT;
                    end else begin
                        rd_enb <= 1'b0;
                        state  <= IDLE;
                    end
                end

                READ_WAIT: begin
                    rd_enb   <= 1'b0;        // Deassert read enable
                    data_out <= data_in;     // Safely capture data output from FIFO
                    state    <= IDLE;
                end

                default: state <= IDLE;
            endcase
        end
    end

endmodule
