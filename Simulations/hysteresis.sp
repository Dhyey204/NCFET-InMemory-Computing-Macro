*hysteresis
.control
pre_osdi bsim4_5t_mod.osdi
pre_osdi neg_cap_3t.osdi
.endc

.param my_vth = 0.3558
.include "ncfet_32nm.lib"

Vdd Vdd_node 0 1.0

X1 Vdd_node Vg 0 0 NCFET_NMOS

Vg Vg 0 PULSE(-3 3 0 10u 10u 0.1 20u)

.control
tran 10n 20u
plot v(X1.G_int) vs v(Vg) title "NCFET hysteresis"
.endc
.end
