`timescale 1ns/1ps

module scan_chain_tb;

    reg clk;
    reg se;
    reg [3:0] d;
    reg si;

    wire [3:0] q;
    wire so;

    scan_chain dut (
        .clk(clk),
        .se(se),
        .d(d),
        .si(si),
        .q(q),
        .so(so)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        $dumpfile("sim/scan_chain.vcd");
        $dumpvars(0, scan_chain_tb);

        se = 1;
        d  = 4'b0000;
        si = 0;

        #10 si = 1;
        #10 si = 0;
        #10 si = 1;
        #10 si = 1;
        #10 si = 0;

        se = 0;
        d = 4'b1010;

        #10;
        #10;

        $finish;
    end

    always @(posedge clk) begin
        #1;
        $display("time=%0t se=%b si=%b q=%b so=%b",
                 $time, se, si, q, so);
    end

endmodule
