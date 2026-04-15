`timescale 1ns/1ps

module top_fifo_tb;

    reg clk, rst;
    reg [7:0] data_in;
    wire [7:0] data_out;

    // Instantiate DUT
    fifo_top dut (
        .clk(clk),
        .rst(rst),
        .data_top(data_in),
        .data_out_top(data_out)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // 10ns clock period
    end

    // Stimulus
    initial begin
        // Initialize signals
        {clk, rst, data_in} = 0;

        // Apply reset
        rst = 1;
        #12;
        rst = 0;

        // Drive input data
        data_in = 8'd5;   #10;
        data_in = 8'd10;  #10;
        data_in = 8'd15;  #10;
        data_in = 8'd20;  #10;

        // End simulation
        #200;
        $finish;
    end

    // Monitor outputs
    initial begin
        $monitor("Time=%0t | data_in=%d | data_out=%d",
                  $time, data_in, data_out);
    end

endmodule
