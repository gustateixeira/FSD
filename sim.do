if {[file isdirectory work]} { vdel -all -lib work }
vlib work
vmap work work

vcom -work work dec_counter.vhd
vcom -work work temporizador.vhd
vcom -work work relogio_xadrez.vhd
vcom -work work tb.vhd

vsim -voptargs=+acc=lprn -t ps work.tb

set StdArithNoWarnings 1
set StdVitalGlitchNoWarnings 1

do wave.do 

run 26 us

