%% Add tools to path
hdlsetuptoolpath('ToolName','Altera Quartus II','ToolPath','C:\intelFPGA_lite\18.1\quartus\bin64\quartus.exe');
%%
h = aximaster('Intel');
% I have setup 3 main memory locations for us to use
% 0x0000 - 0x3fff (0 - 16383) is the on chip RAM - This we can store what
% ever we need in this. The fpga never updates this memory.
% 0x4000 - 0x400f (16384 - 16399) is the "Buttons". This controls what mode
% we are in:
% 0 - No light on (this will be start of calibration as well)
% 3 - Blue calibration (blue on 1 frame/ all off 2 frames)
% 5 - Green calibration
% 6 - Red calibration
% 7 - Regular run mode
% 0x4010 - 0x401f (16400 - 16415) is the "Data_out". This lets us know what
% current LED is turned on. Reading data:
% 0 - all leds off
% 1 - red led calibration
% 2 - all leds off after red calibration
% 3 - green led calibration
% 4 - all leds off after green calibration
% 5 - blue led calibration
% 6 - all leds off after blue calibration
% 7 - red led normal run mode
% 8 - green led normal run
% 9 - blue led normal run
% 10 - if my code breaks it will show a 10 and no leds on
%%
for i = 0:1:150
    x = readmemory(h,16400,1);
    if (x == 7)
        disp('red');
    elseif (x==8)
        disp('green');
    elseif (x == 9)
        disp('blue');
    end;
end
%%
writememory(h,16384,0);
writememory(h,16384,7);
disp('Calibrate')
tic
for i = 0:1:150
    x = readmemory(h,16400,1);
    if (x == 1)
        disp('red');
    elseif (x==2)
        disp('red off');
    elseif (x==3)
        disp('green');
    elseif (x==4)
        disp('green off');   
    elseif (x == 5)
        disp('blue');
    elseif (x == 6)
        disp('blue off');
    elseif (x >6)
        disp('regular run');
    end;
   
end
toc