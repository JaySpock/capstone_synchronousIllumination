% Automatically generated script to launch FPGA Data Capture App
% Instantiate FPGA Data Capture System object
if ~exist('fpgadc_obj','var') || ~isa(fpgadc_obj,'datacapture') || ~isprop(fpgadc_obj,'TimeStamp') || ~strcmpi(fpgadc_obj.TimeStamp,'02-Mar-2020 21:45:58')
    fpgadc_obj = datacapture;
end
fpgadc_obj.launchApp;
