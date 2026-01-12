** Test for XNOR_TG gate
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
.INCLUDE "XNOR_TG.sp"   ** Include the AND gate with fanout of 4

** Voltage sources with 25ps rise/fall time
v1 vdd! 0 0.9v  ** Supply voltage
v2 vss! 0 0v   ** Ground voltage
v3 x1 0 pwl 0ns 0v   1ns 0v  1.025ns 0v  2ns 0v 2.025ns 0.9v  3.00ns 0.9v   3.025ns 0.9v 4.00ns 0.9v
v4 w1 0 pwl 0ns 0v   1ns 0v  1.025ns 0.9v  2ns 0.9v 2.025ns 0.9v 3.00ns 0.9v   3.025ns 0v 4.00ns 0v


** parasitic capacitance
COUT OUT 0 4f 


.OP

** Transient Analysis to simulate input transitions (00, 01, 11, 10)
.TRAN STEP=10p STOP=4n

.end
