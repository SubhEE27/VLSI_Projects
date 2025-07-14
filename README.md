# 🧠 VLSI & Circuit Simulation Projects

Welcome to my collection of **VLSI design** and **analog circuit simulation** projects. This repository showcases digital logic designs implemented using **Verilog HDL** and analog/mixed-signal simulations using **LTspice**. Each project reflects hands-on application of core concepts in **Digital Design**, **CMOS Technology**, and **RTL Simulation**.

---

## 🛠️ Technologies & Tools Used
- **Languages:** Verilog HDL, C
- **EDA Tools:** Vivado, ModelSim, LTspice, MATLAB
- **Platforms:** Xilinx FPGA (Spartan Series), Arduino, ESP32

---

## 📁 Project List

### 🔷 Digital Design (Verilog HDL)

1. **16-bit RISC Processor**
   - Designed a 16-bit custom processor with ALU, register file, and control logic
   - Verified functionality through testbenches and waveform simulation

2. **UART Protocol Implementation**
   - Implemented UART communication with Baud Rate Generator, TX and RX modules
   - Verified using testbench and waveform simulation in ModelSim

3. **Vending Machine FSM**
   - Designed a Mealy FSM for coin-based vending logic
   - Simulated FSM response to different input sequences

4. **Sequence Detector**
   - Implemented 4-bit sequence detector using state machines
   - Simulated and tested for overlapping/non-overlapping sequences

---

### 🔶 Analog & CMOS Simulations (LTspice)

1. **CMOS Full Adder Simulation**
   - Simulated full adder using CMOS logic gates
   - Analyzed transient response, delay, and power consumption in LTspice

2. **CMOS Inverter Characteristics**
   - Studied VTC curve, noise margins, and propagation delay

---

## 📂 Repository Structure
/RTL_Design/
	├── RISC_Processor/
	├── UART/
	├── Vending_Machine/
	└── Sequence_Detector/

/LTspice_Simulations/
	├── Full_Adder_CMOS/
	└── Inverter_Characteristics/

---

## 🚀 Getting Started

### Requirements
- Vivado / ModelSim for RTL simulation
- LTspice XVII for analog circuit analysis

### How to Run
Each folder contains:
- `.v` Verilog source files
- `testbench.v` files
- `.asc` files for LTspice circuits
- Screenshots of simulation waveforms and timing diagrams

---

## 🧩 Learning Objectives
- RTL design and verification of digital systems
- FSM-based control logic design
- Hands-on CMOS-level understanding via LTspice
- Bridging analog and digital circuit perspectives
