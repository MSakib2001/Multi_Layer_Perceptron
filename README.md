# Multi-Layer Perceptron (MLP) Design for Human Activity Recognition (ECE 555)

## Overview
This project implements a **simplified Multi-Layer Perceptron (MLP)** for **Human Activity Recognition (HAR)** using **custom digital hardware design targeting 7 nm technology**. The network classifies two activities: **SIT** and **RUN**, based on input from a **1D accelerometer** and a **stretch sensor**.  

Unlike typical projects that instantiate pre-built blocks, **every module in this design was custom-designed at the transistor level and laid out for 7 nm nodes**, giving hands-on experience with **high-performance, area-optimized digital design**.

---

## Project Motivation
- **Deep learning in hardware:** Understand how neural networks can be implemented in cutting-edge silicon technology.
- **Custom layout design:** Learn how to optimize transistors, routing, and metal layers for area, delay, and power.
- **Modular methodology:** Design neurons → hidden layers → full MLP, while fully customizing each building block.
- **System-level integration:** Combine transistor-level blocks to create a functional MLP for classification.

---

## Design Methodology
The MLP is implemented with **fully custom building blocks**, each designed, simulated, and laid out for 7 nm technology.

### Custom Components:
1. **Multiplier** – simplified 2-bit signed multiplication designed from scratch.
2. **2-bit Adder**
3. **3-bit Adder**
4. **3-bit 2-to-1 Multiplexer (MUX)**

### Neuron Design:
- Each neuron performs a **multiply-accumulate (MAC)** operation followed by a **custom activation function**:
  - If input < 0 → output = 0  
  - If input ≥ 0 → output = input
- Input nodes **pass raw sensor data**.
- Hidden nodes **compute inner products and apply activation**.
- Output node **produces classification** based on threshold:  
  - `z_out > 1 → SIT`  
  - `z_out ≤ 1 → RUN`

### Example:
| Input | Hidden Layer | Output | Activity |
|-------|--------------|--------|----------|
| x0 = 0, x1 = 3 | y0 = 2, y1 = 2 | z_out = 3 | SIT |

---

## Implementation Steps
1. **Custom schematic design:**  
   - Each block designed at transistor-level for 7 nm.
   - Functional simulations verified correct behavior.
2. **Custom layout design:**  
   - Layout optimized for **area and timing**.
   - Ensured **DRC/LVS clean** design.
3. **Parasitic extraction & timing verification:**  
   - Extracted parasitic effects and re-simulated for real performance.
4. **MLP integration:**  
   - Combined custom layouts to form **neurons → hidden layer → output**.
   - Maintained modularity while ensuring **minimal interconnect delay**.

---

## Project Features
- **Fully custom 7 nm layouts** for all modules (no pre-made blocks).
- **Modular and scalable design** for multiple layers.
- **Quantized 2-bit inputs and weights** for efficient hardware implementation.
- **Simplified multiplier** avoids complex multipliers but is fully transistor-level.
- **End-to-end forward pass** implementation of an MLP in hardware.
- Focus on **operating frequency, area optimization, and parasitic-aware design**.

---

## Tools Used
- **Cadence Virtuoso** – schematic and layout design
- **7 nm PDK** – transistor-level design rules
- **Simulation** – pre-layout and post-layout verification
- **DRC/LVS** – layout verification
- **Parasitic extraction (PEX)** – timing and delay characterization

---

## Learning Outcomes
- Hands-on experience in **7 nm custom digital design**.
- Design and layout of **datapath components from scratch**.
- Modular integration of **neurons into hidden and output layers**.
- Evaluation of designs based on **frequency, area, and performance metrics**.
- Understanding trade-offs in **modern process nodes** for AI accelerators.

---

## Notes
- Only **forward pass** is implemented; weights are **pre-trained**.
- **Binary classification** only (SIT/RUN).
- Input and weight values are **2-bit signed numbers**.
- Design methodology can scale to **higher-bit precision and deeper networks** for real HAR applications.

---

**Team:** M Sadman Sakib, Rex White, Munasib Ilham, Kyle Bartel  
**Course:** ECE 555 – DIGITAL CIRCUITS AND COMPONENTS; [Professor Umit Ogras]
**Institution:** [University of Wisconsin-Madison]
