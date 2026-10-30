# Scan Chain Design and Stuck-at Fault Analysis

## 1. Project Overview

This project implements a 4-bit scan chain using Verilog HDL. It demonstrates scan-based Design for Testability (DFT), functional operation, serial test-data shifting, basic stuck-at fault modeling, and generic RTL synthesis.

## 2. Objectives

- Design a scan flip-flop with functional and scan modes.
- Connect four scan flip-flops into a serial scan chain.
- Verify functionality using Icarus Verilog.
- Inspect simulation waveforms using GTKWave.
- Demonstrate simplified stuck-at-0 and stuck-at-1 output fault models.
- Synthesize the RTL using Yosys and inspect the generated netlist.

## 3. Tools Used

- Verilog HDL
- Icarus Verilog
- GTKWave
- Yosys
- Ubuntu Linux

## 4. Design Description

### Scan Flip-Flop

The scan flip-flop has a clock input, functional data input (`d`), scan input (`si`), scan enable (`se`), and output (`q`).

- `se = 0`: the flip-flop captures functional input `d` on the rising clock edge.
- `se = 1`: the flip-flop captures scan input `si` on the rising clock edge.

### Four-Bit Scan Chain

Four scan flip-flops are connected in series. The output of each stage feeds the scan input of the next stage. The final stage output acts as the serial scan output (`so`).

## 5. Simulation and Fault Modeling

The RTL and testbenches are simulated using Icarus Verilog. Waveforms are saved as VCD files and can be viewed using GTKWave.

A separate testbench demonstrates simplified output-level stuck-at-0 and stuck-at-1 fault models. This is a demonstration of fault effects, not a complete stuck-at fault simulation or fault-coverage analysis of the internal scan chain.

## 6. Synthesis Results

Generic synthesis is performed using Yosys.

The reported design hierarchy contains:
- 4 generic D flip-flop cells (`$dff`)
- 4 generic multiplexer cells (`$mux`)
- 0 problems reported by the Yosys structural check

These are generic synthesis cells, not technology-mapped standard cells.

## 7. Project Structure

- `rtl/` — RTL design files
- `tb/` — simulation testbenches
- `sim/` — simulation executables and VCD waveforms
- `results/` — synthesis reports and generated netlist
- `run.sh` — runs all simulations and Yosys synthesis

## 8. Future Improvements

- Implement internal scan-chain stuck-at fault injection.
- Calculate fault coverage using test patterns.
- Add automated self-checking testbenches.
- Perform technology mapping using a standard-cell library.
- Extend the design to longer scan chains.

## 9. How to Run

Install the tools on Ubuntu: `sudo apt install -y iverilog gtkwave yosys`. Then run `./run.sh` from the project root. It simulates the three testbenches (VCD waveforms go to `sim/`) and writes the Yosys report and netlist to `results/`. View a waveform with `gtkwave sim/scan_chain.vcd`.
