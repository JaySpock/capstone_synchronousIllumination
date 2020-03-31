%% Add tools to path
hdlsetuptoolpath('ToolName','Altera Quartus II','ToolPath','C:\intelFPGA_lite\18.1\quartus\bin64\quartus.exe');
%%
h = aximaster('Intel');
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