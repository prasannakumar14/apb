vlog top.sv
#vsim top
vsim -novopt -suppress 12110 top -assertdebug 
add wave -position insertpoint sim:/top/vif/*
add wave /top/sel_en
run -all
