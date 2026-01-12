* HSPICE Testbench for AND2 Gate Characterization
* DUT: AND2
* Load: Fanout-of-4 (FO4)
* Corner: Typical-Typical (TT)

*======================================================================
* Transistor Model Files
*======================================================================
.INCLUDE "/cae/apps/data/asap7PDK-2022/asap7PDK_r1p7/models/hspice/7nm_TT_160803.pm"

*======================================================================
* Design Under Test (DUT) Subcircuit
*======================================================================
.INCLUDE "AND2.sp"
.INCLUDE "INV.sp" 

*======================================================================
* Simulation Parameters and Options
*======================================================================
.TEMP 25.0
.options artist=2 ingold=2 parhier=local psf=2 hier_delim=0 accurate=1
+ NUMDGT=8 measdgt=5 GMINDC=1e-18 DELMAX=1n method=gear INGOLD=2 POST=1

*======================================================================
* Testbench Circuit
*======================================================================
* 1. DUT Instantiation (AND2) - CORRECTED PIN ORDER
* Format: x<name> <port connections> <subcircuit_name>
xdut A B Y gnd vdd AND2

* 2. Power Supply
vdd vdd gnd 0.9v

* 3. Input Stimulus
* To test the A->Y path, input B is tied high.
vA A gnd PULSE(0v 0.9v 100ps 25ps 25ps 5ns 10ns)
vB B gnd 0.9v

* 4. Output Load
xload1 gnd vdd Y out1 INV
xload2 gnd vdd Y out2 INV
xload3 gnd vdd Y out3 INV
xload4 gnd vdd Y out4 INV

*======================================================================
* Analysis and Measurements
*======================================================================
* 1. Transient Analysis
.tr 10ps 20ns

* 2. Delay and Slew Measurements for A->Y Path
.MEASURE TRAN tLH_A_Y TRIG V(A) VAL=0.45V RISE=1 TARG V(Y) VAL=0.45V RISE=1
.MEASURE TRAN tHL_A_Y TRIG V(A) VAL=0.45V FALL=1 TARG V(Y) VAL=0.45V FALL=1
.MEASURE TRAN trise_Y_from_A TRIG V(Y) VAL=0.18V RISE=1 TARG V(Y) VAL=0.72V RISE=1
.MEASURE TRAN tfall_Y_from_A TRIG V(Y) VAL=0.72V FALL=1 TARG V(Y) VAL=0.18V FALL=1

.END
