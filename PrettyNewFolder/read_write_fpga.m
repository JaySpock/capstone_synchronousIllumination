%% Add tools to path
hdlsetuptoolpath('ToolName','Altera Quartus II','ToolPath','C:\intelFPGA_lite\18.1\quartus\bin64\quartus.exe');
%%
h = aximaster('Intel');
% I have setup 3 main memory locations for us to use
% 0x0000 - 0x3fff (0 - 16383) is the on chip RAM - This we can store what
% ever we need in this. The fpga never updates this memory.
% 0x4000 - 0x400f (16384 - 16399) is the "Buttons". This controls what mode
% we are in:
% 0 - No light on 
% 1 - Run calibration in loop
% 2 - Run Regular mode
% 0x4010 - 0x401f (16400 - 16415) is the "Data_out". This lets us know what
% current LED is turned on. Reading data:
% 0 - all leds off
% 1 - red led calibration
% 2 - red led turning off
% 3 - all leds staying off
% 4 - green led calibration
% 5 - green leds turning off
% 6 - all leds staying off
% 7 - blue led calibration
% 8 - blue led turning off
% 9 - all leds staying off
% 10 - red led normal run mode
% 11 - green led normal run
% 12 - blue led normal run
% 13 - if my code breaks it will show a 13 and no leds on
%%
writememory(h,16384,2);
for i = 0:1:500
    x = readmemory(h,16400,1);
    if (x == 10)
        disp('red');
    elseif (x==11)
        disp('green');
    elseif (x == 12)
        disp('blue');
    end;
end
writememory(h,16384,0);
%%
writememory(h,16384,1);
disp('Calibrate');
tic
for i = 0:1:500
    x = readmemory(h,16400,1);
    if (x == 1)
        disp('red');
    elseif (x==2)
        disp('red off (1st)');
    elseif (x==3)
        disp('red off (2nd)');
    elseif (x==4)
        disp('green');
    elseif (x==5)
        disp('green off (1st)');
    elseif (x==6)
        disp('green off (2nd)');
    elseif (x == 7)
        disp('blue');
    elseif (x==8)
        disp('blue off (1st)');
    elseif (x==9)
        disp('blue off (2nd)');
    elseif (x > 10)
        disp('regular run');
    end;
   
end
toc
writememory(h,16384,0);