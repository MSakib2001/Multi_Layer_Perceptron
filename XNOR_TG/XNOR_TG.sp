** Generated for: hspiceD
** Generated on: Nov  5 15:20:34 2025
** Design library name: ECE555
** Design cell name: XNOR_TG
** Design view name: schematic


** Library name: ECE555
** Cell name: XNOR_TG
** View name: schematic
mn7 net1 x1 vss! vss! nmos_rvt w=27e-9 l=20e-9 nfin=1
mn1 net1 net2 out vss nmos_rvt w=27e-9 l=20e-9 nfin=1
mn0 x1 w1 out vss nmos_rvt w=27e-9 l=20e-9 nfin=1
mp6 net1 x1 vdd! vdd! pmos_rvt w=27e-9 l=20e-9 nfin=1
mp4 net2 w1 vdd! vdd! pmos_rvt w=27e-9 l=20e-9 nfin=1
mp2 net1 w1 out vdd pmos_rvt w=27e-9 l=20e-9 nfin=1
mp3 x1 net2 out vdd pmos_rvt w=27e-9 l=20e-9 nfin=1
mn5 net2 w1 vss! vss! nmos_lvt w=27e-9 l=20e-9 nfin=1
.END