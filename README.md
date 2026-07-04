Design and Simulation of an NCFET-Based In-Memory Computing MAC Macro

This repository contains the design, characterization, and Ngspice simulation of a highly efficient Analog In-Memory Computing (IMC) Multiply-Accumulate (MAC) macro utilizing 32nm Negative Capacitance Field-Effect Transistors (NCFETs).

This project explores analog crossbar architectures for accelerating Vector-Matrix Multiplications (VMM) in deep neural networks, addressing the traditional Von Neumann memory bottleneck.

Project Overview

Modern Artificial Intelligence (AI) and Deep Neural Networks (DNNs) are heavily bottlenecked by the continuous shuttling of massive weight matrices between memory and processing units.

This project addresses this by implementing an Analog In-Memory Computing (IMAC) architecture. By mapping neural network weights to the threshold voltage ($V_{th}$) of NCFET devices and encoding input activations as time-based voltage pulses, VMM is executed natively within the memory crossbar utilizing Ohm's Law and Kirchhoff's Current Law.

Key Features & Contributions

NCFET Voltage Amplification: Leveraged the Landau-Khalatnikov (L-K) thermodynamic model to simulate the electrostatic capacitance coupling in 32nm ferroelectric gate stacks, achieving steep subthreshold switching.

Source-Follower Accumulation: Designed a 1FeFET-1R MAC cell utilizing a source-follower accumulation capacitor to execute discrete MAC operations without power-hungry Op-Amps.

"Absolute Zero" Leakage Mitigation: Solved zero-weight leakage in the analog array by introducing a hardware-aware absolute-zero anchor state ($V_{th}$ = 1.7V), clamping erroneous capacitor charging.

Hardware-Aware Weight Calibration: Identified array-level source degeneration non-linearities in a 3x3 crossbar and neutralized them using an iterative, non-uniform threshold voltage calibration technique (0.9V, 1.2V, 1.3V, 1.7V) to ensure reliable Analog-to-Digital (ADC) read margins.

Known Limitations & Toolchain Constraints

A core objective of this project was navigating the realities of open-source Electronic Design Automation (EDA) workflows. As such, this simulation contains deliberate architectural abstractions and known shortfalls:

OpenVAF vs. The Preisach Model: Initial attempts were made to simulate realistic, smooth domain-switching hysteresis using a highly accurate behavioral Preisach model. However, current open-source Verilog-A compilers (OpenVAF) lack robust support for the internal array allocations required to track domain history. Consequently, we reverted to the L-K thermodynamic model, which assumes a macroscopic crystal and introduces abrupt, non-ideal capacitance "snapping."

The FeFET/NCFET Simulation Paradox: Due to the aforementioned open-source workflow challenges, the device simulated in this array is an idealized architectural abstraction. It mathematically merges the hyper-fast sub-60mV/dec switching speed of an NCFET (which requires operating on the unstable energy peak) with the non-volatile memory retention of a FeFET (which requires sitting in the stable energy valleys) via local Gate Voltage Shifting. A physical FeFET array would exhibit noticeably more sluggish transient charging.

Imperfect Linearity: While the hardware-aware weight pre-distortion ($V_{th}$ calibration) successfully mitigated severe source degeneration and choke-out in the 3x3 array, perfect analog linearity was not achieved. The inherent physical nature of the L-K model's polarization dynamics dictates that a degree of residual analog bending remains present at the bitline outputs.

Repository Structure

/simulations/ - Contains all Ngspice .sp control scripts and netlists (Single-cell MAC, Hysteresis sweeps, 3x3 Array).

/models/ - Contains the 32nm NCFET Verilog-A compiled .osdi files and SPICE .lib parameters.

/images/ - Transient output plots and circuit schematics.

Simulation Results

1. 3x3 Crossbar Array Transient Output

The following plot demonstrates the parallel accumulation of the 3x3 crossbar bitline capacitors executing Vector-Matrix Multiplication. Notice the calibrated read margins at the 25ns sampling edge, correcting for physical source degeneration.

[3x3 Array Output](https://github.com/Dhyey204/NCFET-InMemory-Computing-Macro/blob/main/images/Screenshot%202026-07-04%20113133.png)

2. "Absolute Zero" Leakage Mitigation

Comparison of standard zero-weight states vs. the artificially elevated $V_{th}$ anchor state, proving a flat 0.0V noise floor under maximum input activation.

[Leakage Mitigation](https://github.com/Dhyey204/NCFET-InMemory-Computing-Macro/blob/main/images/Screenshot%202026-07-04%20002947.png)

How to Run the Simulations

Prerequisites:
You must have Ngspice installed along with OpenVAF support enabled to read the .osdi compact models.

Clone the repository:

git clone https://github.com/Dhyey204/NCFET-InMemory-Computing-Macro.git


Navigate to the simulations folder:

cd NCFET-InMemory-Computing-Macro/simulations


Run the specific testbench in Ngspice:

ngspice mac_3x3.sp


References

T. Soliman, S. Chatterjee, N. Laleni et al., "First demonstration of in-memory computing crossbar using multi-level Cell FeFET," Nature Communications, 2023.

K. Ni and M. S. E. Khan, "Ferroelectric FET Model," nanoHUB, Purdue University.

OpenVAF Compiler Framework, semimod.de
