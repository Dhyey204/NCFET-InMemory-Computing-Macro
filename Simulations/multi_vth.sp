*multi_vth
.control
pre_osdi bsim4_5t_mod.osdi
pre_osdi neg_cap_3t.osdi
.endc

.param my_vth = 0.3
.include "ncfet_32nm.lib"


Vdd Vdd_node 0 1.0
Vin Vin 0 0.0

X1 Vdd_node Vin 0 0 NCFET_NMOS

.control
foreach val 0.28 0.29 0.30 0.31 0.32 0.58 0.59 0.60 0.61 0.62 0.98 0.99 1.00 1.01 1.02 1.28 1.29 1.30 1.31 1.32 
      alterparam my_vth = $val
      reset
      
      dc Vin 0.0 2.5 0.01
end    
set color0=white
set color1=black
plot abs(dc1.Vdd#branch) abs(dc2.Vdd#branch) abs(dc3.Vdd#branch) abs(dc4.Vdd#branch) abs(dc5.Vdd#branch) abs(dc6.Vdd#branch) abs(dc7.Vdd#branch) abs(dc8.Vdd#branch) abs(dc9.Vdd#branch) abs(dc10.Vdd#branch) abs(dc11.Vdd#branch) abs(dc12.Vdd#branch) abs(dc13.Vdd#branch) abs(dc14.Vdd#branch) abs(dc15.Vdd#branch) abs(dc16.Vdd#branch) abs(dc17.Vdd#branch) abs(dc18.Vdd#branch) abs(dc19.Vdd#branch) abs(dc20.Vdd#branch) ylimit 10e-6 0.01 ylog title "Fig 1b Ids vs Vgs"
.endc
.end
