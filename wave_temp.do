onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/reset
add wave -noupdate /tb/ck
add wave -noupdate /tb/load
add wave -noupdate /tb/enable
add wave -noupdate -radix hexadecimal /tb/init_time
add wave -noupdate -radix hexadecimal /tb/cont
add wave -noupdate -divider {sinais internos}
add wave -noupdate -radix hexadecimal /tb/contador1/minH
add wave -noupdate -radix hexadecimal /tb/contador1/minL
add wave -noupdate -radix hexadecimal /tb/contador1/segH
add wave -noupdate -radix hexadecimal /tb/contador1/segL
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {63641164 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 2
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits us
update
WaveRestoreZoom {0 ps} {25 us}
