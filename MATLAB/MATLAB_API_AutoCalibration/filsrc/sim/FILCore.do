set SRCDIR C:/Users/jorda/Documents/MSU/Spring 2020/EELE 489R/capstone_synchronousIllumination/MATLAB/MATLAB_API_AutoCalibration/C:/Users/jorda/Documents/MSU/Spring 2020/EELE 489R/capstone_synchronousIllumination/MATLAB/MATLAB_API_AutoCalibration/filsrc
set SIMDIR C:/Users/jorda/Documents/MSU/Spring 2020/EELE 489R/capstone_synchronousIllumination/MATLAB/MATLAB_API_AutoCalibration/C:/Users/jorda/Documents/MSU/Spring 2020/EELE 489R/capstone_synchronousIllumination/MATLAB/MATLAB_API_AutoCalibration/filsrc/sim
set COMPILE vcom

set SIM vsim

vlib $SIMDIR/work
vmap work $SIMDIR/work

$COMPILE $SRCDIR/MWAJTAG.vhd
$COMPILE $SRCDIR/MWDPRAM.vhd
$COMPILE $SRCDIR/FILUDPCRC.vhd
$COMPILE $SRCDIR/FILPktMUX.vhd
$COMPILE $SRCDIR/FILCmdProc.vhd
$COMPILE $SRCDIR/MWAsyncFIFO.vhd
$COMPILE $SRCDIR/FILDataProc.vhd
$COMPILE $SRCDIR/MWPKTBuffer.vhd
$COMPILE $SRCDIR/MWUDPPKTBuilder.vhd
$COMPILE $SRCDIR/FILPktProc.vhd
$COMPILE $SRCDIR/FILCommLayer.vhd
$COMPILE $SRCDIR/mwfil_dpscram.vhd
$COMPILE $SRCDIR/mwfil_udfifo.vhd
$COMPILE $SRCDIR/mwfil_bus2dut.vhd
$COMPILE $SRCDIR/mwfil_chifcore.vhd
$COMPILE $SRCDIR/mwfil_controller.vhd
$COMPILE $SRCDIR/mwfil_dut2bus.vhd
$COMPILE $SRCDIR/fil_test_wrapper.vhd
$COMPILE $SRCDIR/mwfil_chiftop.vhd
$COMPILE $SRCDIR/FILCore.vhd
