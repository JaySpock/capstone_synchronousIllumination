%% Data Capture Process
%% Add tools to path
hdlsetuptoolpath('ToolName','Altera Quartus II','ToolPath','C:\intelFPGA_lite\18.1\quartus\bin64\quartus.exe');
%% Create Intel IP core
%generateFPGADataCaptureIP
%% Add code to VHDL top file. Follow MATLAB toolbox tutorial
%% Add project to path so MATLAB can access datacapture.m
%% DATA capture
% Sets up data capture object
  clear data_out;
  
  DataCaptureObj = datacapture;
  DataCaptureObj.TriggerPosition = 0;
  DataCaptureObj.NumCaptureWindows = 128; % This captures of a large number of windows. 
                                 % This is only used for debugging stages
                                 % as it takes too long and shows to much
                                 % data
                                 
%   setRunImmediateFlag(DataCaptureObj,'1')
%   setTriggerCondition(DataCaptureObj,'LED',true,5)
  setTriggerCondition(DataCaptureObj,'New_Frame',true,'rising edge') % data_out signal is the end of frame detection
  

  tic
  NumberOfSampledepth = 1;
  Sample_depth = 128;
  data_out =  int16(zeros(NumberOfSampledepth*Sample_depth, 1));
  for i=1: NumberOfSampledepth
    data_out( i*Sample_depth-(Sample_depth-1) :i*Sample_depth) = step(DataCaptureObj);
  end
  toc
  data_out = de2bi(data_out);
  
%% One frame color data capture
  DataCaptureObj.NumCaptureWindows = 1;

  data_last = 0;
  
  NumberOfSampledepth = 1;
  Sample_depth = 128;
  setTriggerCondition(DataCaptureObj,'New_Frame',true,'High');
%   setRunImmediateFlag(DataCaptureObj,'1');
  data_out =  int16(zeros(NumberOfSampledepth*Sample_depth, 1));
  while 1
%       toc
      evalc('data_out(Sample_depth-(Sample_depth-1) :Sample_depth) = step(DataCaptureObj)');
%       data_out = de2bi(data_out);
      if (data_out(1) == 7 && data_last ~= 7)
          data_last = 7;
          disp('red');
      elseif (data_out(1) == 8 && data_last ~= 8)
          data_last = 8;
          disp('green');
      elseif (data_out(1) == 9 && data_last ~= 9)
          data_last = 9;
          disp('blue');
      end;
%       tic
  end;
  %% Visualize
  figure(1)
  hold on
  plot(data_out(:,1), 'r')
  ylim([-0.2 1.2])
  plot(data_out(:,2), 'g')
  ylim([-0.2 1.2])
  plot(data_out(:,3), 'b')
  ylim([-0.2 1.2])
  
  %%
  figure(2)
  hold on
  subplot(3,1,1);
  plot(data_out(:,1), 'r')
  ylim([-0.2 1.2])
  subplot(3,1,2);
  plot(data_out(:,2), 'g')
  ylim([-0.2 1.2])
  subplot(3,1,3);
  plot(data_out(:,3), 'b')
  ylim([-0.2 1.2])
  