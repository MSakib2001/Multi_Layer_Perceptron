** Generated for: hspiceD
** Generated on: Nov  5 18:39:57 2025
** Design library name: ECE555
** Design cell name: Multiplier
** Design view name: schematic



** Library name: ECE555
** Cell name: NAND2
** View name: schematic
.subckt NAND2 in0 in1 out vdd! vss!
mp1 vdd! in1 out vdd! pmos_rvt w=81e-9 l=20e-9 nfin=3
mp0 out in0 vdd! vdd! pmos_rvt w=81e-9 l=20e-9 nfin=3
mn7 net11 in1 vss! vss! nmos_rvt w=54e-9 l=20e-9 nfin=2
mn6 out in0 net11 vss! nmos_rvt w=54e-9 l=20e-9 nfin=2
mn3 net11 in1 vss! vss! nmos_rvt w=54e-9 l=20e-9 nfin=2
mn2 out in0 net11 vss! nmos_rvt w=54e-9 l=20e-9 nfin=2
.ends NAND2
** End of subcircuit definition.

** Library name: ECE555
** Cell name: INV
** View name: schematic
.subckt INV in out vdd! vss!
mp1 out in vdd! vdd! pmos_rvt w=81e-9 l=20e-9 nfin=3
mn0 out in vss! vss! nmos_rvt w=54e-9 l=20e-9 nfin=2
.ends INV
** End of subcircuit definition.

** Library name: ECE555
** Cell name: XNOR_TG
** View name: schematic
.subckt XNOR_TG in0 in1 out vdd! vss!
mn7 net1 in1 vss! vss! nmos_rvt w=27e-9 l=20e-9 nfin=1
mn1 net1 net2 out vss! nmos_rvt w=27e-9 l=20e-9 nfin=1
mn0 in1 in0 out vss! nmos_rvt w=27e-9 l=20e-9 nfin=1
mp6 net1 in1 vdd! vdd! pmos_rvt w=27e-9 l=20e-9 nfin=1
mp4 net2 in0 vdd! vdd! pmos_rvt w=27e-9 l=20e-9 nfin=1
mp2 net1 in0 out vdd! pmos_rvt w=27e-9 l=20e-9 nfin=1
mp3 in1 net2 out vdd! pmos_rvt w=27e-9 l=20e-9 nfin=1
mn5 net2 in0 vss! vss! nmos_rvt w=27e-9 l=20e-9 nfin=1
.ends XNOR_TG
** End of subcircuit definition.

** Library name: ECE555
** Cell name: NOR
** View name: schematic
.subckt NOR in0 in1 out vdd! vss!
mn1 out in0 vss! vss! nmos_rvt w=81e-9 l=20e-9 nfin=3
mn0 out in1 vss! vss! nmos_rvt w=81e-9 l=20e-9 nfin=3
mp3 net2 in1 vdd! vdd! pmos_rvt w=162e-9 l=20e-9 nfin=6
mp2 out in0 net2 vdd! pmos_rvt w=162e-9 l=20e-9 nfin=6
.ends NOR
** End of subcircuit definition.

** Library name: ECE555
** Cell name: Multiplier
** View name: schematic
xi0 x0 w0 net3 vdd! vss! NAND2
xi1 net3 n<0> vdd! vss! INV
xi2 x1 w1 net12 vdd! vss! XNOR_TG
xi3 net3 net12 n<1> vdd! vss! NOR
.END