`timescale 1ns/1ps

module scan_chain (
    input wire clk,
    input wire se,
    input wire [3:0] d,
    input wire si,
    output wire [3:0] q,
    output wire so
);

    scan_ff ff0 (
        .clk(clk),
        .se(se),
        .d(d[0]),
        .si(si),
        .q(q[0])
    );

    scan_ff ff1 (
        .clk(clk),
        .se(se),
        .d(d[1]),
        .si(q[0]),
        .q(q[1])
    );

    scan_ff ff2 (
        .clk(clk),
        .se(se),
        .d(d[2]),
        .si(q[1]),
        .q(q[2])
    );

    scan_ff ff3 (
        .clk(clk),
        .se(se),
        .d(d[3]),
        .si(q[2]),
        .q(q[3])
    );

    assign so = q[3];

endmodule
