*1MAC operation
.control
pre_osdi bsim4_5t_mod.osdi
pre_osdi neg_cap_3t.osdi
.endc

.param my_vth = 0.3
.param in_amp = 1.6
.include "ncfet_32nm.lib"

Vdd Vdd_node 0 1.0

R_load Vdd_node Drain_node 1Meg

X1 Drain_node Gate_node Cap_node 0 NCFET_NMOS
C_accum Cap_node 0 64f

.ic v(Cap_node)=0.0
Vin Gate_node 0 PULSE(0 {in_amp} 0.5n 0.1n 15n 20n)

.control
destroy all

foreach in_val 0.7 1.0 1.3 1.5
    alterparam in_amp =$in_val
    foreach w_val 0.9 1.2 1.3 1.7
        alterparam my_vth = $w_val
        reset
    
        tran 0.1n 16n uic
    end
end
set color0=white
set color1=black


let id1_w1 = abs(tran1.Cap_node)
let in1_w2 = abs(tran2.Cap_node)
let in1_w3 = abs(tran3.Cap_node)
let in1_w4 = abs(tran4.Cap_node)
plot in1_w1 in1_w2 in1_w3 in1_w4 title "graph 1: input state 1 (0.7V)" ylabel "Vcap"

let in2_w1 = abs(tran5.Cap_node)
let in2_w2 = abs(tran6.Cap_node)
let in2_w3 = abs(tran7.Cap_node)
let in2_w4 = abs(tran8.Cap_node)
plot in2_w1 in2_w2 in2_w3 in2_w4 title "graph 2: input state 2 (1.0V)" ylabel "Vcap"

let in3_w1 = abs(tran9.Cap_node)
let in3_w2 = abs(tran10.Cap_node)
let in3_w3 = abs(tran11.Cap_node)
let in3_w4 = abs(tran12.Cap_node)
plot in3_w1 in3_w2 in3_w3 in3_w4 title "graph 3: input state 3 (1.3V)" ylabel "Vcap"

let in4_w1 = abs(tran13.Cap_node)
let in4_w2 = abs(tran14.Cap_node)
let in4_w3 = abs(tran15.Cap_node)
let in4_w4 = abs(tran16.Cap_node)
plot in4_w1 in4_w2 in4_w3 in4_w4 title "graph 4: input state 4 (1.5V)" ylabel "Vcap"

.endc
.end 
