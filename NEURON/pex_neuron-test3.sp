*******************************************************
** NEURON TESTBENCH – SINGLE TEST
** Signed encoding: -1=11, 0=00, +1=01, never use 10
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
.options NUMDGT=8 measdgt=5 GMINDC=1e-18 DELMAX=1n method=gear INGOLD=2 POST=1

*******************************************************
** Include ASAP7 PDK models
*******************************************************
.INCLUDE "/cae/apps/data/asap7PDK-2022/asap7PDK_r1p7/models/hspice/7nm_TT_160803.pm"

*******************************************************
** Include NEURON netlist
*******************************************************
.INCLUDE "NEURON.pex.netlist"

*******************************************************
** Power supplies
*******************************************************
VDD vdd! 0 0.9v
VSS vss! 0 0v

*******************************************************
** Fixed signed weights:
**   w00 = -1 = 2'b11
**   w10 =  0 = 2'b00
**   w20 = +1 = 3'b001
*******************************************************

Vw00_0 w00<0> 0 0.9v     ** LSB of w00 = 1
Vw00_1 w00<1> 0 0.9v     ** MSB of w00 = 1 → w00 = 11 (-1)

Vw10_0 w10<0> 0 0v       ** LSB of w10 = 0
Vw10_1 w10<1> 0 0v       ** MSB of w10 = 0 → w10 = 00 (0)

Vw20_0 w20<0> 0 0.9v     ** w20 = 001 (+1)
Vw20_1 w20<1> 0 0v
Vw20_2 w20<2> 0 0v

*******************************************************
** INPUT STIMULI
** Signed encoding: -1=11, 0=00, +1=01
**
** SINGLE TEST (0–3 ns):
**  0–1ns : x0=01 (+1), x1=11 (-1)  (setup)
**  1–3ns : x0=11 (-1), x1=11 (-1)  (x0 transitions 01→11)
**
** Edges: 25 ps transitions
*******************************************************

** x0<1> – MSB of x0
** 0–1ns: 0 (x0=01)
** 1–3ns: 1 (x0=11)
Vx0_1 x0<1> 0 pwl
+ 0ns 0v
+ 1ns 0v     1.025ns 0.9v
+ 3ns 0.9v

** x0<0> – LSB of x0
** Constant 1 (for both 01 and 11)
Vx0_0 x0<0> 0 0.9v

** x1<1> – MSB of x1
** Constant 1 (x1=11)
Vx1_1 x1<1> 0 0.9v

** x1<0> – LSB of x1
** Constant 1 (x1=11)
Vx1_0 x1<0> 0 0.9v

*******************************************************
** Instantiate NEURON DUT
** Port order from NEURON.pex.netlist:
**   VSS W10<1> VDD X1<1> W00<1> W10<0> X0<1> X1<0> W00<0> X0<0>
**   W20<1> W20<0> W20<2> Z<2> Z<1> Z<0>
*******************************************************
XDUT vss! w10<1> vdd! x1<1> w00<1> w10<0> x0<1> x1<0> w00<0> x0<0>
+ w20<1> w20<0> w20<2> z<2> z<1> z<0> NEURON

.OP

*******************************************************
** Transient analysis: 3ns total
**  - 0–1ns : setup (x0=01, x1=11)
**  - 1–3ns : after transition (x0=11, x1=11)
*******************************************************
.TRAN 10p 3n

*******************************************************
** Probe signals: inputs, outputs, power
*******************************************************
.PROBE TRAN v(x0<0>) v(x0<1>) v(x1<0>) v(x1<1>)
.PROBE TRAN v(w00<0>) v(w00<1>) v(w10<0>) v(w10<1>)
.PROBE TRAN v(w20<0>) v(w20<1>) v(w20<2>)
.PROBE TRAN v(z<0>) v(z<1>) v(z<2>)
.PROBE TRAN v(vdd!) v(vss!)

.END
