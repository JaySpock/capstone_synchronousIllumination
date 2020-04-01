load_package flow
project_new -overwrite fil_test_fil
set_global_assignment -name FAMILY  {Cyclone 10 LP}
set_global_assignment -name DEVICE  {10CL025YU256I7G}
set_global_assignment -name CYCLONEII_OPTIMIZATION_TECHNIQUE SPEED
set_global_assignment -name VHDL_FILE "C:/Users/jorda/Documents/MSU/Spring 2020/EELE 489R/capstone_synchronousIllumination/MATLAB/MATLAB_API_AutoCalibration/fil_test.vhd"
set_global_assignment -name USE_TIMEQUEST_TIMING_ANALYZER ON
set_global_assignment -name VHDL_FILE "C:/Users/jorda/Documents/MSU/Spring 2020/EELE 489R/capstone_synchronousIllumination/MATLAB/MATLAB_API_AutoCalibration/filsrc/MWClkMgr.vhd"
set_global_assignment -name VHDL_FILE "C:/Users/jorda/Documents/MSU/Spring 2020/EELE 489R/capstone_synchronousIllumination/MATLAB/MATLAB_API_AutoCalibration/filsrc/MWAJTAG.vhd"
set_global_assignment -name VHDL_FILE "C:/Users/jorda/Documents/MSU/Spring 2020/EELE 489R/capstone_synchronousIllumination/MATLAB/MATLAB_API_AutoCalibration/filsrc/MWDPRAM.vhd"
set_global_assignment -name VHDL_FILE "C:/Users/jorda/Documents/MSU/Spring 2020/EELE 489R/capstone_synchronousIllumination/MATLAB/MATLAB_API_AutoCalibration/filsrc/FILUDPCRC.vhd"
set_global_assignment -name VHDL_FILE "C:/Users/jorda/Documents/MSU/Spring 2020/EELE 489R/capstone_synchronousIllumination/MATLAB/MATLAB_API_AutoCalibration/filsrc/FILPktMUX.vhd"
set_global_assignment -name VHDL_FILE "C:/Users/jorda/Documents/MSU/Spring 2020/EELE 489R/capstone_synchronousIllumination/MATLAB/MATLAB_API_AutoCalibration/filsrc/FILCmdProc.vhd"
set_global_assignment -name VHDL_FILE "C:/Users/jorda/Documents/MSU/Spring 2020/EELE 489R/capstone_synchronousIllumination/MATLAB/MATLAB_API_AutoCalibration/filsrc/MWAsyncFIFO.vhd"
set_global_assignment -name VHDL_FILE "C:/Users/jorda/Documents/MSU/Spring 2020/EELE 489R/capstone_synchronousIllumination/MATLAB/MATLAB_API_AutoCalibration/filsrc/FILDataProc.vhd"
set_global_assignment -name VHDL_FILE "C:/Users/jorda/Documents/MSU/Spring 2020/EELE 489R/capstone_synchronousIllumination/MATLAB/MATLAB_API_AutoCalibration/filsrc/MWPKTBuffer.vhd"
set_global_assignment -name VHDL_FILE "C:/Users/jorda/Documents/MSU/Spring 2020/EELE 489R/capstone_synchronousIllumination/MATLAB/MATLAB_API_AutoCalibration/filsrc/MWUDPPKTBuilder.vhd"
set_global_assignment -name VHDL_FILE "C:/Users/jorda/Documents/MSU/Spring 2020/EELE 489R/capstone_synchronousIllumination/MATLAB/MATLAB_API_AutoCalibration/filsrc/FILPktProc.vhd"
set_global_assignment -name VHDL_FILE "C:/Users/jorda/Documents/MSU/Spring 2020/EELE 489R/capstone_synchronousIllumination/MATLAB/MATLAB_API_AutoCalibration/filsrc/FILCommLayer.vhd"
set_global_assignment -name VHDL_FILE "C:/Users/jorda/Documents/MSU/Spring 2020/EELE 489R/capstone_synchronousIllumination/MATLAB/MATLAB_API_AutoCalibration/filsrc/mwfil_dpscram.vhd"
set_global_assignment -name VHDL_FILE "C:/Users/jorda/Documents/MSU/Spring 2020/EELE 489R/capstone_synchronousIllumination/MATLAB/MATLAB_API_AutoCalibration/filsrc/mwfil_udfifo.vhd"
set_global_assignment -name VHDL_FILE "C:/Users/jorda/Documents/MSU/Spring 2020/EELE 489R/capstone_synchronousIllumination/MATLAB/MATLAB_API_AutoCalibration/filsrc/mwfil_bus2dut.vhd"
set_global_assignment -name VHDL_FILE "C:/Users/jorda/Documents/MSU/Spring 2020/EELE 489R/capstone_synchronousIllumination/MATLAB/MATLAB_API_AutoCalibration/filsrc/mwfil_chifcore.vhd"
set_global_assignment -name VHDL_FILE "C:/Users/jorda/Documents/MSU/Spring 2020/EELE 489R/capstone_synchronousIllumination/MATLAB/MATLAB_API_AutoCalibration/filsrc/mwfil_controller.vhd"
set_global_assignment -name VHDL_FILE "C:/Users/jorda/Documents/MSU/Spring 2020/EELE 489R/capstone_synchronousIllumination/MATLAB/MATLAB_API_AutoCalibration/filsrc/mwfil_dut2bus.vhd"
set_global_assignment -name VHDL_FILE "C:/Users/jorda/Documents/MSU/Spring 2020/EELE 489R/capstone_synchronousIllumination/MATLAB/MATLAB_API_AutoCalibration/filsrc/fil_test_wrapper.vhd"
set_global_assignment -name VHDL_FILE "C:/Users/jorda/Documents/MSU/Spring 2020/EELE 489R/capstone_synchronousIllumination/MATLAB/MATLAB_API_AutoCalibration/filsrc/mwfil_chiftop.vhd"
set_global_assignment -name VHDL_FILE "C:/Users/jorda/Documents/MSU/Spring 2020/EELE 489R/capstone_synchronousIllumination/MATLAB/MATLAB_API_AutoCalibration/filsrc/FILCore.vhd"
set_global_assignment -name VHDL_FILE "C:/Users/jorda/Documents/MSU/Spring 2020/EELE 489R/capstone_synchronousIllumination/MATLAB/MATLAB_API_AutoCalibration/filsrc/fil_test_fil.vhd"
source "C:/Users/jorda/Documents/MSU/Spring 2020/EELE 489R/capstone_synchronousIllumination/MATLAB/MATLAB_API_AutoCalibration/filsrc/fil_test_fil.qsf"
set_global_assignment -name SDC_FILE "C:/Users/jorda/Documents/MSU/Spring 2020/EELE 489R/capstone_synchronousIllumination/MATLAB/MATLAB_API_AutoCalibration/filsrc/fil_test_fil.sdc"
set_global_assignment -name USE_TIMEQUEST_TIMING_ANALYZER ON
set_global_assignment -name TOP_LEVEL_ENTITY fil_test_fil
execute_flow -compile
set sta_file "fil_test_fil.sta.rpt"
set timing_err ""
if { [catch {open $sta_file r} par_fid] } {
      set timing_err "Warning: Skipped timing check because STA report does not exist."
} else {
   set sta_str [read $par_fid]
   close $par_fid
   set result [regexp {Critical Warning.*: Timing requirements not met} $sta_str match]
   if {$result > 0} {
      set timing_err "Warning: Design does not meet all timing constraints.\nCheck STA report \"fil_test_fil.sta.rpt\" for details."
   }
}
project_close
set log ""
lappend log "\n\n------------------------------------"
lappend log "   FPGA-in-the-Loop build summary"
lappend log "------------------------------------\n"
set expected_file fil_test_fil.sof
set copied_file "C:/Users/jorda/Documents/MSU/Spring 2020/EELE 489R/capstone_synchronousIllumination/MATLAB/MATLAB_API_AutoCalibration/fil_test_fil.sof"
if [catch {file copy -force $expected_file ..}] {
   file delete ../$expected_file
   lappend log "Expected programming file not generated."
   lappend log "FPGA-in-the-Loop build failed.\n"
} else {
   if {[string length $timing_err] > 0} {
      lappend log "$timing_err\n"
      set warn_str " with warning"
   } else {
      set warn_str ""
   }
   lappend log "Programming file generated:"
   lappend log "$copied_file\n"
   lappend log "FPGA-in-the-Loop build completed$warn_str."
   lappend log "You may close this shell.\n"
}
foreach j $log {puts $j}
if { [catch {open fpgaproj.log w} log_fid] } {
} else {
    foreach j $log {puts $log_fid $j}
}
close $log_fid
