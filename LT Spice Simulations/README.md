# CMOS Circuit Simulations using LTspice

Welcome to the CMOS Simulation Repository!  
This repository contains detailed LTspice simulations of various digital logic circuits designed using CMOS technology. The circuits are implemented using both **65nm** and **180nm** process technologies.

---

## 📁 Repository Contents

This repository includes the following circuit simulations:

| Circuit | Description |
|--------|-------------|
| **CMOS Inverter** | DC Transfer Characteristics, Noise Margins, and Power Dissipation |
| **CMOS NAND Gate** | 2-input NAND gate using CMOS topology |
| **CMOS NOR Gate** | 2-input NOR gate using CMOS topology |
| **Full Adder** | 1-bit Full Adder designed using CMOS gates |
| **Custom Logic Designs** | Any additional logic implemented as part of learning/practice |

Each of the above circuits is simulated in either **65nm** or **180nm** or both CMOS technologies.

---

## 🛠️ Tools Used

- **LTspice** – For circuit simulation and waveform analysis
- **CMOS Technology Files**
  - 65nm model files (`.model`, `.lib`)
  - 180nm model files

---

## 📐 Features Explored

- VTC (Voltage Transfer Characteristics)
- Static and dynamic power dissipation
- Propagation delay
- Noise margins
- Logical correctness of combinational circuits
- Comparison of behavior across 65nm and 180nm technologies

---

## 📂 Folder Structure

CMOS-Simulations/
├── CMOS-Inverter/
│ ├── 65nm/
│ │ └── inverter_65nm.asc
│ └── 180nm/
│ └── inverter_180nm.asc
├── CMOS-NAND/
├── CMOS-NOR/
├── CMOS-XOR/
├── Full-Adder/
├── Models/
│ ├── 65nm.lib
│ └── 180nm.lib
└── README.md

