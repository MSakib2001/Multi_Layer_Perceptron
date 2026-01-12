** Generated for: hspiceD
** Generated on: Nov 21 02:06:49 2025
** Design library name: ECE555_shared_library
** Design cell name: MUX2_1_3bit
** Design view name: schematic


** Library name: ECE555_shared_library
** Cell name: INV
** View name: schematic
.subckt INV a vdd vss y
mp1 y a vdd vdd pmos_rvt w=81e-9 l=20e-9 nfin=3
mn0 y a vss vss nmos_rvt w=54e-9 l=20e-9 nfin=2
.ends INV
** End of subcircuit definition.

** Library name: ECE555_shared_library
** Cell name: AND2
** View name: schematic
.subckt AND2 a b y vdd vss
mn7 vss b net15 vss nmos_rvt w=54e-9 l=20e-9 nfin=2
mn6 net15 a net2 vss nmos_rvt w=54e-9 l=20e-9 nfin=2
mn5 y net2 vss vss nmos_rvt w=54e-9 l=20e-9 nfin=2
mn4 net15 b vss vss nmos_rvt w=54e-9 l=20e-9 nfin=2
mn3 net2 a net15 vss nmos_rvt w=54e-9 l=20e-9 nfin=2
mp2 y net2 vdd vdd pmos_rvt w=81e-9 l=20e-9 nfin=3
mp1 net2 b vdd vdd pmos_rvt w=81e-9 l=20e-9 nfin=3
mp0 net2 a vdd vdd pmos_rvt w=81e-9 l=20e-9 nfin=3
.ends AND2
** End of subcircuit definition.

** Library name: asap7_TechLib
** Cell name: TIELOx1_ASAP7_75t_R
** View name: schematic
.subckt TIELOx1_ASAP7_75t_R l vdd vss
mpm1 net9 l vdd vdd pmos_rvt w=27e-9 l=20e-9 nfin=1
mnm2 l net9 vss vss nmos_rvt w=54e-9 l=20e-9 nfin=2
.ends TIELOx1_ASAP7_75t_R
** End of subcircuit definition.

** Library name: ECE555_shared_library
** Cell name: MUX2_1_3bit
** View name: schematic
.subckt MUX2_1_3bit a_2 a_1 a_0 vdd vss y_2 y_1 y_0
xi9 a_2 vdd vss net2 INV
xi12 net2 a_0 y_0 vdd vss AND2
xi11 net2 a_1 y_1 vdd vss AND2
xi13 y_2 vdd vss TIELOx1_ASAP7_75t_R
.ends MUX2_1_3bit