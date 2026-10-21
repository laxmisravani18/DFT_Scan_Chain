`timescale 1ns/1ps

module fault_analysis_tb;

    reg clk;
    reg se;
    reg [3:0] d;
    reg si;

    wire [3:0] q;
    wire so;

    reg fault_sa0;
    reg fault_sa1;
    wire faulty_so;

    scan_chain dut (
        .clk(clk),
        .se(se),
        .d(d),
        .si(si),
        .q(q),
        .so(so)
    );

    assign faulty_so = fault_sa0 ? 1'b0 :
                       fault_sa1 ? 1'b1 : so;

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        $dumpfile("sim/fault_analysis.vcd");
        $dumpvars(0, fault_analysis_tb);

        se = 1;
        d = 4'b0000;
        si = 0;
        fault_sa0 = 0;
        fault_sa1 = 0;

        // Shift in four zeros.
        #2;
        si = 0;
        #10;
        si = 0;
        #10;
        si = 0;
        #10;
        si = 0;

        #10;
        $display("Expected SO=0, actual SO=%b", so);

        // Test stuck-at-1.
        fault_sa1 = 1;
        #1;
        $display("SA1: expected SO=0, faulty SO=%b", faulty_so);

        fault_sa1 = 0;
        #1;

        // Shift in four ones.
        si = 1;
        #10;
        si = 1;
        #10;
        si = 1;
        #10;
        si = 1;

        #10;
        $display("Expected SO=1, actual SO=%b", so);

        // Test stuck-at-0.
        fault_sa0 = 1;
        #1;
        $display("SA0: expected SO=1, faulty SO=%b", faulty_so);

        $finish;
    end

endmodule
