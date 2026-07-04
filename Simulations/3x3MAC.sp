*3x3 MAC
.control
pre_osdi bsim4_5t_mod.osdi
pre_osdi neg_cap_3t.osdi
.endc

.param my_vth = 0.9 
.include "ncfet_32nm.lib"

Vdd Vdd_node 0 1.0

C_BL1 BL1 0 64f
C_BL2 BL2 0 64f
C_BL3 BL3 0 64f

.ic v(BL1)=0.0 v(BL2)=0.0 v(BL3)=0.0

Vin_R1 WL1 0 PULSE(0 1.5 0.5n 0.1n 0.1n 25n 30n)
Vin_R2 WL2 0 PULSE(0 1.5 0.5n 0.1n 0.1n 25n 30n)
Vin_R3 WL3 0 PULSE(0 1.5 0.5n 0.1n 0.1n 25n 30n)

*Cell 1,1 W-3
R_11 Vdd_node D11 1Meg
Vshift_11 WL1 G11 DC 0.0
X_11 D11 G11 BL1 0 NCFET_NMOS

*Cell 1,2 W-0
R_12 Vdd_node D12 1Meg
Vshift_12 WL1 G12 DC 0.8
X_12 D12 G12 BL2 0 NCFET_NMOS

*Cell 1,3 W-2
R_13 Vdd_node D13 1Meg
Vshift_13 WL1 G13 DC 0.3
X_13 D13 G13 BL3 0 NCFET_NMOS

*Cell 2,1 W-1
R_21 Vdd_node D21 1Meg
Vshift_21 WL2 G21 DC 0.4
X_21 D21 G21 BL1 0 NCFET_NMOS

*Cell 2,2 W-1
R_22 Vdd_node D22 1Meg
Vshift_22 WL2 G22 DC 0.4
X_22 D22 G22 BL2 0 NCFET_NMOS

*Cell 2,3 W-0
R_23 Vdd_node D23 1Meg
Vshift_23 WL2 G23 DC 0.8
X_23 D23 G23 BL3 0 NCFET_NMOS

*Cell 3,1 W-0
R_31 Vdd_node D31 1Meg
Vshift_31 WL3 G31 DC 0.8
X_31 D31 G31 BL1 0 NCFET_NMOS

*Cell 3,2 W-1
R_32 Vdd_node D32 1Meg
Vshift_32 WL3 G32 DC 0.4
X_32 D32 G32 BL2 0 NCFET_NMOS

*Cell 3,3 W-1
R_33 Vdd_node D33 1Meg
Vshift_33 WL3 G33 DC 0.4
X_33 D33 G33 BL3 0 NCFET_NMOS

.control
destroy all
tran 0.1n 30n uic
set color0=white
set color1=black
plot v(BL1) V(BL2) v(BL3) xlimit 10n 30n ylimit 400m 550m title "3x3 array" ylabel "Bitline Voltage"
.endc
.end
