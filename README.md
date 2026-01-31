# GCD Datapath & Controller – Verilog HDL

RTL implementation of a Greatest Common Divisor (GCD) computation unit using an iterative subtraction-based algorithm.

This project demonstrates algorithm-to-hardware mapping through a clean separation of datapath and controller, designed to be fully synthesizable and verified using RTL simulation.

## Algorithm Overview
- If A > B → A = A − B
- If B > A → B = B − A
- If A == B → GCD found

All iteration is handled in hardware using control logic.

## Design Overview
- Separate datapath and controller modules
- Comparator-driven conditional control
- Iterative sequencing using FSM-based logic
- Fully synthesizable RTL

## Repository Structure
rtl/ - Datapath and controller RTL modules
tb/ - Testbench
docs/ - Simulation waveforms 


## Verification
Verified using RTL simulation. Simulation confirms:
- Correct convergence to GCD value
- Proper conditional datapath operation
- Correct termination of algorithm

## Tools Used
- Icarus Verilog / Vivado Simulator
- GTKWave
- Vivado (RTL analysis)

## Author
Lokesh Kumar A
