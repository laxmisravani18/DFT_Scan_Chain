#!/bin/bash
# Simulate all three testbenches and run Yosys synthesis.  Usage: ./run.sh
# Needs: iverilog, vvp, yosys. Optional: gtkwave sim/scan_chain.vcd
set -e
mkdir -p sim results

for tb in scan_ff scan_chain fault_analysis; do
  echo "=== simulating ${tb}_tb ==="
  case $tb in
    scan_ff) SRC="rtl/scan_ff.v" ;;
    *)       SRC="rtl/scan_ff.v rtl/scan_chain.v" ;;
  esac
  iverilog -g2012 -Wall -s ${tb}_tb -o sim/${tb}_test $SRC tb/${tb}_tb.v
  vvp sim/${tb}_test
done

echo "=== Yosys synthesis ==="
yosys -p "read_verilog rtl/scan_ff.v rtl/scan_chain.v; hierarchy -top scan_chain; proc; opt; check; stat" | tee results/synthesis_report.txt
yosys -p "read_verilog rtl/scan_ff.v rtl/scan_chain.v; hierarchy -top scan_chain; proc; opt; write_verilog results/scan_chain_netlist.v"
