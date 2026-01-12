** Library name: ECE555
** Cell name: AND2
** View name: schematic

.SUBCKT AND2 A B Y vss vdd

mp2 y net2 vdd! vdd! pmos_rvt w=81e-9 l=20e-9 nfin=3
mp1 net2 b vdd! vdd! pmos_rvt w=81e-9 l=20e-9 nfin=3
mp0 net2 a vdd! vdd! pmos_rvt w=81e-9 l=20e-9 nfin=3
mn5 y net2 vss! vss! nmos_rvt w=54e-9 l=20e-9 nfin=2
mn4 net15 b vss! vss! nmos_rvt w=108e-9 l=20e-9 nfin=4
mn3 net2 a net15 vss! nmos_rvt w=108e-9 l=20e-9 nfin=4

.ENDS AND2
