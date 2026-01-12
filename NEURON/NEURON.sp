H
.subckt INV a vdd! vss! y
mp1 y a vdd! vdd! pmos_rvt w=81e-9 l=20e-9 nfin=3
mp0 y a vss! vss! nmos_rvt w=54e-9 l=20e-9 nfin=2
.ends INV
** End of subcircuit definition.

** Library name: ECE555_shared_library
** Cell name: XNOR_TG
** View name: schematic
.subckt XNOR_TG in0 in1 out vdd! vss!
mn7 net1 in1 vss! vss! nmos_rvt w=54e-9 l=20e-9 nfin=2
mn5 net2 in0 vss! vss! nmos_rvt w=54e-9 l=20e-9 nfin=2
mn1 net1 net2 out vss! nmos_rvt w=54e-9 l=20e-9 nfin=2
mn0 in1 in0 out vss! nmos_rvt w=54e-9 l=20e-9 nfin=2
mp6 net1 in1 vdd! vdd! pmos_rvt w=81e-9 l=20e-9 nfin=3
mp4 net2 in0 vdd! vdd! pmos_rvt w=81e-9 l=20e-9 nfin=3
mp2 net1 in0 out vdd! pmos_rvt w=81e-9 l=20e-9 nfin=3
mp3 in1 net2 out vdd! pmos_rvt w=81e-9 l=20e-9 nfin=3
.ends XNOR_TG
** End of subcircuit definition.

** Library name: ECE555_shared_library
** Cell name: NOR2
** View name: schematic
.subckt NOR2 a b vdd! vss! y
mn1 vss! b y vss! nmos_rvt w=54e-9 l=20e-9 nfin=2
mn0 y a vss! vss! nmos_rvt w=54e-9 l=20e-9 nfin=2
mp5 vdd! b net1 vdd! pmos_rvt w=81e-9 l=20e-9 nfin=3
mp4 net1 a y vdd! pmos_rvt w=81e-9 l=20e-9 nfin=3
mp2 y a net1 vdd! pmos_rvt w=81e-9 l=20e-9 nfin=3
mp3 net1 b vdd! vdd! pmos_rvt w=81e-9 l=20e-9 nfin=3
.ends NOR2
** End of subcircuit definition.

** Library name: ECE555_shared_library
** Cell name: NAND2
** View name: schematic
.subckt NAND2 a b vdd! vss! y
mn3 net1 a y vss! nmos_rvt w=54e-9 l=20e-9 nfin=2
mn2 vss! b net1 vss! nmos_rvt w=54e-9 l=20e-9 nfin=2
mn1 y a net1 vss! nmos_rvt w=54e-9 l=20e-9 nfin=2
mn0 net1 b vss! vss! nmos_rvt w=54e-9 l=20e-9 nfin=2
mp5 vdd! b y vdd! pmos_rvt w=81e-9 l=20e-9 nfin=3
mp4 y a vdd! vdd! pmos_rvt w=81e-9 l=20e-9 nfin=3
.ends NAND2
** End of subcircuit definition.

** Library name: ECE555_shared_library
** Cell name: Multiplier
** View name: schematic
.subckt Multiplier n<1> n<0> vdd! vss! w0 w1 x0 x1
xi1 net4 vdd! vss! n<0> INV
xi2 x1 w1 net10 vdd! vss! XNOR_TG
xi3 net4 net10 vdd! vss! n<1> NOR2
xi0 x0 w0 vdd! vss! net4 NAND2
.ends Multiplier
** End of subcircuit definition.

** Library name: ECE555_shared_library
** Cell name: AND2
** View name: schematic
.subckt AND2 a b y vdd! vss!
mn7 vss! b net15 vss! nmos_rvt w=54e-9 l=20e-9 nfin=2
mn6 net15 a net2 vss! nmos_rvt w=54e-9 l=20e-9 nfin=2
mn5 y net2 vss! vss! nmos_rvt w=54e-9 l=20e-9 nfin=2
mn4 net15 b vss! vss! nmos_rvt w=54e-9 l=20e-9 nfin=2
mn3 net2 a net15 vss! nmos_rvt w=54e-9 l=20e-9 nfin=2
mp2 y net2 vdd! vdd! pmos_rvt w=81e-9 l=20e-9 nfin=3
mp1 net2 b vdd! vdd! pmos_rvt w=81e-9 l=20e-9 nfin=3
mp0 net2 a vdd! vdd! pmos_rvt w=81e-9 l=20e-9 nfin=3
.ends AND2
** End of subcircuit definition.

** Library name: ECE555_shared_library
** Cell name: XOR
** View name: schematic
.subckt XOR a b vdd! vss! y
xi10 net1 b vdd! vss! net9 NAND2
xi11 net9 net13 vdd! vss! y NAND2
xi12 a net17 vdd! vss! net13 NAND2
xi9 a vdd! vss! net1 INV
xi13 b vdd! vss! net17 INV
.ends XOR
** End of subcircuit definition.

** Library name: ECE555_shared_library
** Cell name: Adder_2bit
** View name: schematic
.subckt Adder_2bit a<1> a<0> b<1> b<0> s<2> s<1> s<0> vdd! vss!
xi38 net5 vdd! vss! s<2> INV
xi36 s<0> s<1> net4 vdd! vss! AND2
xi35 a<1> b<1> net1 vdd! vss! AND2
xi34 a<0> b<0> net2 vdd! vss! AND2
xi37 net4 net1 vdd! vss! net5 NOR2
xi33 net2 net3 vdd! vss! s<1> XOR
xi32 a<1> b<1> vdd! vss! net3 XOR
xi31 a<0> b<0> vdd! vss! s<0> XOR
.ends Adder_2bit
** End of subcircuit definition.

** Library name: ECE555_shared_library
** Cell name: Adder_3bit
** View name: schematic
.subckt Adder_3bit a<2> a<1> a<0> b<2> b<1> b<0> s<2> s<1> s<0> vdd! vss!
xi22 net28 net9 vdd! vss! s<1> XOR
xi21 net19 net15 vdd! vss! s<2> XOR
xi20 a<2> b<2> vdd! vss! net15 XOR
xi19 a<1> b<1> vdd! vss! net9 XOR
xi18 a<0> b<0> vdd! vss! s<0> XOR
xi25 net28 net9 net45 vdd! vss! AND2
xi24 a<1> b<1> net40 vdd! vss! AND2
xi23 a<0> b<0> net28 vdd! vss! AND2
xi26 net45 net40 vdd! vss! net50 NOR2
xi27 net50 vdd! vss! net19 INV
.ends Adder_3bit
** End of subcircuit definition.

** Library name: ECE555_shared_library
** Cell name: TIELOx1
** View name: schematic
.subckt TIELOx1 l vdd! vss!
mpm1 net9 l vdd! vdd! pmos_rvt w=27e-9 l=20e-9 nfin=1
mpm2 l net9 vss! vss! nmos_rvt w=54e-9 l=20e-9 nfin=2
.ends TIELOx1
** End of subcircuit definition.

** Library name: ECE555_shared_library
** Cell name: MUX2_1_3bit
** View name: schematic
.subckt MUX2_1_3bit a<2> a<1> a<0> vdd! vss! y<2> y<1> y<0>
xi9 a<2> vdd! vss! net1 INV
xi12 a<0> net1 y<0> vdd! vss! AND2
xi11 a<1> net1 y<1> vdd! vss! AND2
xi14 y<2> vdd! vss! TIELOx1
.ends MUX2_1_3bit
** End of subcircuit definition.

** Library name: ECE555_shared_library
** Cell name: NEURON
** View name: schematic
xi1 net12<0> net12<1> vdd! vss! w10<0> w10<1> x1<0> x1<1> Multiplier
xi0 net5<0> net5<1> vdd! vss! w00<0> w00<1> x0<0> x0<1> Multiplier
xi2 net5<0> net5<1> net12<0> net12<1> net17<0> net17<1> net17<2> vdd! vss! Adder_2bit
xi3 net17<0> net17<1> net17<2> w20<2> w20<1> w20<0> net22<0> net22<1> net22<2> vdd! vss! Adder_3bit
xi4 net22<0> net22<1> net22<2> vdd! vss! z<2> z<1> z<0> MUX2_1_3bit
.END
