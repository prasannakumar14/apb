vlog  top.sv +incdir+C:/questasim64_10.7c/verilog_src/uvm-1.1c/src
set      fp [open "testfile.txt" r]
while { [gets $fp testname]>=0 } {
variable time         [format "%s" [clock format [clock seconds] -format %m%d_%H%M]]
set log_f "$testname\_$time\.log" 
set ucdb_f "$testname\.ucdb"

#optimization
vopt top +cover=fcbest -o $testname

#elaboration
vsim -novopt -suppress 12110 -coverage $testname -sv_lib C:/questasim64_10.7c/uvm-1.2/win64/uvm_dpi +UVM_TESTNAME=$testname -l $log_f 
#save coverage database
coverage save -onexit $ucdb_f
run -all
}

