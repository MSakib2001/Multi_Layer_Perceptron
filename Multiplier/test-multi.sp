** Test for 4-Input Multiplier
.GLOBAL vss! vdd!
.TEMP 25.0
.OPTION
+    ARTIST=2
+    INGOLD=2
+    PARHIER=LOCAL
+    PSF=2
+    HIER_DELIM=0
.options accurate=1 NUMDGT=8 measdgt=5 GMINDC=1e-18 DELMAX=1n method=gear INGOLD=2 POST=1

.INCLUDE "/cae/apps/data/asap7PDK-2022/asap7PDK_r1p7/models/hspice/7nm_TT_160803.pm"
.INCLUDE "Multiplier.sp"   

** Voltage sources with 25ps rise/fall time
v1 vdd! 0 0.9v  ** Supply voltage
v2 vss! 0 0v   ** Ground voltage

** Inputs (patterns: 0000, 0100, 1100, 0001, 0101, 1101, 0011, 0111, 1111)
v3 x1 0 pwl 0ns 0v   1ns 0v  1.025ns 0v  2ns 0v 2.025ns 0v  3.00ns 0v   3.025ns 0v 4.00ns 0v 4.025ns 0v 5.00ns 0v   5.025ns 0v 6.00ns 0v 6.025ns 0v 7.00ns 0v   7.025ns 0v 8.00ns 0v 8.025ns 0.9v 9.00ns 0.9v
v4 x0 0 pwl 0ns 0v   1ns 0v  1.025ns 0.9v  2ns 0.9v 2.025ns 0.9v  3.00ns 0.9v   3.025ns 0.9v 4.00ns 0.9v 4.025ns 0.9v 5.00ns 0.9v   5.025ns 0.9v 6.00ns 0.9v 6.025ns 0.9v 7.00ns 0.9v   7.025ns 0.9v 8.00ns 0.9v 8.025ns 0.9v 9.00ns 0.9v
v5 w1 0 pwl 0ns 0v   1ns 0v  1.025ns 0v  2ns 0v 2.025ns 0v  3.00ns 0v   3.025ns 0v 4.00ns 0v 4.025ns 0v 5.00ns 0v   5.025ns 0v 6.00ns 0v 6.025ns 0v 7.00ns 0v   7.025ns 0v 8.00ns 0v 8.025ns 0v 9.00ns 0v
v6 w0 0 pwl 0ns 0v   1ns 0v  1.025ns 0v  2ns 0v 2.025ns 0.9v  3.00ns 0.9v   3.025ns 0.9v 4.00ns 0.9v 4.025ns 0.9v 5.00ns 0.9v   5.025ns 0.9v 6.00ns 0.9v 6.025ns 0.9v 7.00ns 0.9v   7.025ns 0.9v 8.00ns 0.9v 8.025ns 0.9v 9.00ns 0.9v

** parasitic capacitance
COUT0 n<0> 0 4f
COUT1 n<1> 0 4f

.OP

** Transient Analysis to simulate input transitions
.TRAN STEP=10p STOP=9n

.end