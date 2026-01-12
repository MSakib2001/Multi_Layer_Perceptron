# Multi-Layer Perceptron (MLP) Design for Human Activity Recognition (ECE 555)

## Overview
This project implements a **simplified Multi-Layer Perceptron (MLP)** for **Human Activity Recognition (HAR)** using **custom digital hardware design**. The goal is to classify two activities: **SIT** and **RUN**, based on input from **1D accelerometer measurements** and a **stretch sensor**.  

The project focuses on **inference (forward pass)** using **pre-trained weights**, allowing students to practice **modular hardware design**, **datapath design**, and **layout skills** on a fundamental building block of deep learning architectures.

---

## Project Motivation
- **Deep learning in hardware:** Understand how neural networks can be implemented in silicon.
- **Modular design methodology:** Start from neurons → hidden layers → full network.
- **Datapath fundamentals:** Implement and optimize components such as adders, shifters, multipliers, and multiplexers.
- **System-level integration:** Combine building blocks to create a functional MLP.

---

## Design Methodology
The MLP is implemented with **modular digital blocks**, each tested individually before integration.  

### Components:
1. **Multiplier** – simplified 2-bit signed multiplication based on given constraints.
2. **2-bit Adder**
3. **3-bit Adder**
4. **3-bit 2-to-1 Multiplexer (MUX)**

### Neuron Design:
- Each neuron performs a **multiply-accumulate (MAC)** operation followed by a **custom activation function**:
  - If input < 0 → output = 0  
  - If input ≥ 0 → output = input
- Input nodes **pass information directly** from sensors.
- Hidden layer nodes **compute inner products** and apply activation.
- Output node **produces classification** based on threshold:  
  - `z_out > 1 → SIT`  
  - `z_out ≤ 1 → RUN`

### Example:
| Input | Hidden Layer | Output | Activity |
|-------|--------------|--------|----------|
| x0 = 0, x1 = 3 | y0 = 2, y1 = 2 | z_out = 3 | SIT |

---

## Implementation Steps
1. **Schematic design:**  
   - Capture each building block in Cadence.
   - Simulate to verify functionality.
2. **Layout design:**  
   - Create layout for each block.
   - Ensure LVS/DRC clean design.
3. **Parasitic extraction & simulation:**  
   - Extract parasitics.
   - Resimulate to verify timing and functionality.
4. **MLP assembly:**  
   - Integrate blocks into a single neuron schematic.
   - Replicate for hidden and output layers.

---

## Project Features
- Fully **modular and parameterized design** for scalability.
- **Quantized 2-bit inputs and weights** for low-complexity hardware.
- **Simplified multiplier** avoids full multiplication logic.
- **End-to-end forward pass** implementation of MLP in hardware.
- Focus on **operating frequency and area optimization**.
  
---

## Tools Used
- **Cadence Virtuoso** – schematic capture and layout
- **Simulation** – pre-layout and post-layout verification
- **DRC/LVS** – layout verification
- **Parasitic extraction (PEX)** – timing characterization

---

## Learning Outcomes
- Hands-on experience in **digital hardware design** for machine learning.
- Design and layout of **datapath components**.
- Modular integration of **neurons into hidden layers and output layers**.
- Evaluation of designs based on **frequency, area, and performance metrics**.

---

## References
- ECE 555 Course Materials – Instructor Project Brief
- Cadence Virtuoso Design Suite Documentation

---

## Notes
- Only **forward pass** is implemented; weights are **pre-trained**.
- **Binary classification** only (SIT/RUN).
- Input and weight values are **2-bit signed numbers**.
- Higher-bit precision and additional layers can be implemented for **real-world HAR applications**.

---

**Team:** M Sadman Sakib, Rex White, Munasib Ilham, Kyle Bartel  
**Course:** ECE 555 – Advanced Digital Design [Professor Umit Ogras] 
**Institution:** [University of Wisconsin-Madison]
