*******************************************************
** NEURON TESTBENCH – BASELINE + WORST-CASE + SHORT PULSE
** Signed encoding: -1=11, 0=00, +1=01, never use 10
** Weights for this run:
**   w00 = +1 = 2'b01
**   w10 = -1 = 2'b11
**   w20 =  0 = 3'b000
**
** y0 = x0 - x1     (since w20=0, w00=+1, w10=-1)
** ReLU: z = max(0, y0)
*******************************************************

.GLOBAL vss! vdd!
.TEMP 25.0
.OPTION
+    PROBE
+    CSHUNT=1e-18
+    ARTIST=2
+    INGOLD=2
+    PARHIER=LOCAL
+    PSF=2
+    HIER_DELIM=0
+    REDEFSUB=1
.options NUMDGT=8 measdgt=5 GMINDC=1e-18 DELMAX=1n method=gear INGOLD=2 POST=1

*******************************************************
** Include ASAP7 PDK models
*******************************************************
.INCLUDE "/cae/apps/data/asap7PDK-2022/asap7PDK_r1p7/models/hspice/7nm_TT_160803.pm"

*******************************************************
** Include NEURON netlist (PEX)
*******************************************************
.INCLUDE "NEURON.pex.netlist"

*******************************************************
** Power supplies
*******************************************************
VDD vdd! 0 0.9v
VSS vss! 0 0v

*******************************************************
** Fixed signed weights for this neuron:
**   w00 = +1 = 2'b01
**   w10 = -1 = 2'b11
**   w20 =  0 = 3'b000
*******************************************************

Vw00_0 w00<0> 0 0.9v     ** LSB of w00 = 1
Vw00_1 w00<1> 0 0v       ** MSB of w00 = 0 → +1

Vw10_0 w10<0> 0 0.9v     ** LSB of w10 = 1
Vw10_1 w10<1> 0 0.9v     ** MSB of w10 = 1 → -1

Vw20_0 w20<0> 0 0v       ** 000 = 0
Vw20_1 w20<1> 0 0v
Vw20_2 w20<2> 0 0v

*******************************************************
** INPUT STIMULI FOR NEURON
** Signed encoding: -1=11, 0=00, +1=01, never use 10
**
** BASELINE (0–9 ns): all valid (x0,x1) combinations
**  S0: 0–1ns   : x0=00, x1=00   (y0=0  → z=0)
**  S1: 1–2ns   : x0=00, x1=01   (y0=-1 → z=0)
**  S2: 2–3ns   : x0=00, x1=11   (y0=+1 → z>0  **HIGH**)
**  S3: 3–4ns   : x0=01, x1=00   (y0=+1 → z>0  **HIGH**)
**  S4: 4–5ns   : x0=01, x1=01   (y0=0  → z=0)
**  S5: 5–6ns   : x0=01, x1=11   (y0=+2 → z>0  **HIGH**)
**  S6: 6–7ns   : x0=11, x1=00   (y0=-1 → z=0)
**  S7: 7–8ns   : x0=11, x1=01   (y0=-2 → z=0)
**  S8: 8–9ns   : x0=11, x1=11   (y0=0  → z=0)
**
** WORST-CASE SIMULTANEOUS TRANSITIONS (9–12 ns):
**  S9:  9–10ns : x0=00, x1=01   (low)
**  S10: 10–11ns: x0=01, x1=11   (both x0 & x1 change; y0=+2 → z HIGH)
**  S11: 11–12ns: x0=11, x1=00   (both x0 & x1 change; y0=-1 → z LOW)
**
** SHORT PULSE (<1 ns) (12–13 ns):
**  S12: 12–12.5ns : x0=00, x1=01  (low)
**  S13: 12.5–12.7ns: x0=01, x1=00 (high: short z pulse)
**  S14: 12.7–13ns : x0=00, x1=01  (back low)
**
** Edges: each change uses 25 ps transitions:
**   t, oldV,  t+0.025ns, newV
*******************************************************

***************
** x0<1> – MSB of x0
** Sequence of x0<1> by state:
**  S0–S5: 0          (x0 = 00 or 01)
**  S6–S8: 1          (x0 = 11)
**  S9:    0          (x0 = 00)
**  S10:   0→1 (01)   at 10ns, simultaneous with x1 change
**  S11:   1          (11)
**  S12:   0          (00)
**  S13:   0          (01)
**  S14:   0          (00)
***************
* Changes at t = 6ns (0→1), 9ns (1→0), 10ns (0→1), 11ns (1→0), 12ns (0→0 again)
Vx0_1 x0<1> 0 pwl \
  0ns   0v      \
  6ns   0v      6.025ns 0.9v \
  9ns   0.9v    9.025ns 0v \
 10ns   0v     10.025ns 0v \
 11ns   0v      11.025ns 0.9v \
 12ns   0.9v     12.025ns 0v \
 13ns   0v

***************
** x0<0> – LSB of x0
** Sequence of x0<0> by state:
**  S0–S2: 0   (x0 = 00)
**  S3–S8: 1   (x0 = 01 or 11)
**  S9:    0   (x0 = 00)
**  S10–S14:1  (x0 = 01)
***************
* Changes at t = 3ns (0→1), 9ns (1→0), 10ns (0→1),
* and short-pulse edges at 12ns, 12.5ns, 12.7ns
Vx0_0 x0<0> 0 pwl \
  0ns    0v      \
  3ns    0v      3.025ns 0.9v \
  9ns    0.9v    9.025ns 0v \
 10ns    0v     10.025ns 0.9v \
 12ns    0.9v   12.025ns 0v \
 12.5ns  0v     12.525ns 0.9v \
 12.7ns  0.9v   12.725ns 0v \
 13ns    0v

***************
** x1<1> – MSB of x1
** Sequence of x1<1> by state:
**  S0–S1: 0   (x1 = 00 or 01)
**  S2:    1   (x1 = 11)
**  S3–S4: 0
**  S5:    1
**  S6–S7: 0
**  S8–S9: 1
**  S10–S11:0
**  S12–S14:0 (short pulse only in LSB here)
***************
* Changes at t = 2ns (0→1), 3ns (1→0), 5ns (0→1), 6ns (1→0),
* 8ns (0→1), 9ns (1→0), 10ns (0→1), 11ns (1→0)
Vx1_1 x1<1> 0 pwl \
  0ns   0v      \
  2ns   0v      2.025ns 0.9v \
  3ns   0.9v    3.025ns 0v \
  5ns   0v      5.025ns 0.9v \
  6ns   0.9v    6.025ns 0v \
  8ns   0v      8.025ns 0.9v \
  9ns   0.9v    9.025ns 0v \
 10ns   0v     10.025ns 0.9v \
 11ns   0.9v   11.025ns 0v \
 13ns   0v

***************
** x1<0> – LSB of x1
** Sequence of x1<0> by state:
**  S0:    0   (x1 = 00)
**  S1–S2: 1   (x1 = 01,11)
**  S3:    0   (x1 = 00)
**  S4–S5: 1   (x1 = 01,11)
**  S6:    0   (x1 = 00)
**  S7–S10:1   (x1 = 01,11,11,11)
**  S11:   0   (x1 = 00)
**  S12–S14:1  (x1 = 01 for short-pulse region)
***************
* Changes at t = 1ns (0→1), 3ns (1→0), 4ns (0→1),
* 6ns (1→0), 7ns (0→1), 11ns (1→0),
* 12ns (0→1), 12.5ns (1→0), 12.7ns (0→1)
Vx1_0 x1<0> 0 pwl \
  0ns   0v      \
  1ns   0v      1.025ns 0.9v \
  3ns   0.9v    3.025ns 0v \
  4ns   0v      4.025ns 0.9v \
  6ns   0.9v    6.025ns 0v \
  7ns   0v      7.025ns 0.9v \
 11ns   0.9v   11.025ns 0v \
 12ns   0v     12.025ns 0.9v \
 12.5ns 0.9v   12.525ns 0v \
 12.7ns 0v     12.725ns 0.9v \
 13ns   0.9v

*******************************************************
** Output loading – small caps on neuron outputs
*******************************************************
Cz0 z<0> 0 4f
Cz1 z<1> 0 4f
Cz2 z<2> 0 4f

.OP

*******************************************************
** Instantiate NEURON DUT
** Port order from NEURON.pex.netlist:
**   VSS W10<1> VDD X1<1> W00<1> W10<0> X0<1> X1<0> W00<0> X0<0>
**   W20<1> W20<0> W20<2> Z<2> Z<1> Z<0>
*******************************************************
XDUT vss! w10<1> vdd! x1<1> w00<1> w10<0> x0<1> x1<0> w00<0> x0<0>
+ w20<1> w20<0> w20<2> z<2> z<1> z<0> NEURON

*******************************************************
** Transient analysis
**  - 0–9ns   : baseline (all valid combos)
**  - 9–12ns  : worst-case simultaneous transitions
**  - 12–13ns : short high pulse then low
*******************************************************
.TRAN STEP=10p STOP=13n

*******************************************************
** Probe signals: inputs, outputs, power
*******************************************************
.PROBE TRAN v(x0<0>) v(x0<1>) v(x1<0>) v(x1<1>)
.PROBE TRAN v(w00<0>) v(w00<1>) v(w10<0>) v(w10<1>)
.PROBE TRAN v(w20<0>) v(w20<1>) v(w20<2>)
.PROBE TRAN v(z<0>) v(z<1>) v(z<2>)
.PROBE TRAN v(vdd!) v(vss!)


.end
