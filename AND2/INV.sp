************************************************************************
* Design Name: INV
* File Name:   INV.sp
* Description: Standard 1x drive-strength inverter.
************************************************************************

.SUBCKT INV gnd vdd A Y

* PMOS Pull-up Transistor
mp0 Y A vdd vdd pmos_rvt w=81e-9 l=20e-9 nfin=3

* NMOS Pull-down Transistor
mn0 Y A gnd gnd nmos_rvt w=54e-9 l=20e-9 nfin=2

.ENDS INV
