* =====================================================================
* test_opt2_fixed.sp — Robust Testbench for Optimized 3-bit MUX
* =====================================================================

.global vdd vss
.include "/cae/apps/data/asap7PDK-2022/asap7PDK_r1p7/models/hspice/7nm_TT_160803.pm"
.INCLUDE "MUX2_1_3bit.sp"

.TEMP 25
.option post=2

* Power rails
VDD vdd 0 0.9
VSS vss 0 0

* ------------------------------------------------
* Input Stimulus
* Using PULSE for sharp digital edges (20ps rise/fall)
* ------------------------------------------------

* A2 (MSB) - The Sign Bit
* Logic: Low for first 40ns, High for next 40ns.
* PULSE(V1 V2 Delay Rise Fall Width Period)
VA2 a_2 vss PULSE(0 0.8 40ns 20p 20p 40ns 80ns)

* A1 - Toggles every 20ns
* Logic: 00110011 pattern
* Delay 20ns to match your original PWL intent (starts low, goes high at 20)
VA1 a_1 vss PULSE(0 0.8 20ns 20p 20p 20ns 40ns)

* A0 (LSB) - Toggles every 5ns
* Logic: 01010101 pattern
* Delay 5ns (starts low, goes high at 5)
VA0 a_0 vss PULSE(0 0.8 5ns 20p 20p 5ns 10ns)

* ------------------------------------------------
* DUT (Optimized MUX)
* ------------------------------------------------
XDUT a_2 a_1 a_0 vdd vss y_2 y_1 y_0 MUX2_1_3bit

* ------------------------------------------------
* Simulation
* ------------------------------------------------
.tran 1p 80ns

.probe tran v(a_2) v(a_1) v(a_0) v(y_2) v(y_1) v(y_0)

.END