`timescale 1ns/1ps

module scan_ff_tb;

    reg clk;
    reg se;
    reg d;
    reg si;
    wire q;

    scan_ff dut (
        .clk(clk),
        .se(se),
        .d(d),
        .si(si),
        .q(q)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        $dumpfile("sim/scan_ff.vcd");
        $dumpvars(0, scan_ff_tb);

        se = 0;
        d  = 0;
        si = 0;

        #10;
        d = 1;

        #10;
        se = 1;
        si = 0;
        d = 1;

        #10;
        si = 1;

        #10;
        se = 0;
        d = 0;

        #10;
        $finish;
    end

    always @(posedge clk) begin
        #1;
        $display("time=%0t clk=%b se=%b d=%b si=%b q=%b",
                 $time, clk, se, d, si, q);
    end

endmodule
