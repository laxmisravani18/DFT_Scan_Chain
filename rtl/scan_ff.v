`timescale 1ns/1ps
module scan_ff (
    input wire clk,
    input wire se,
    input wire d,
    input wire si,
    output reg q
);

    always @(posedge clk) begin
        if (se == 1'b1)
            q <= si;
        else
            q <= d;
    end

endmodule
