file_name='team9_v10_^.bin.mp4';
junk_frame=3;
v = VideoReader(file_name);
mx=[];
mxv=99999999999;
cnt=0;
while hasFrame(v)
    video = readFrame(v);
    signal = sum(rgb2gray(video),2);
    cnt=cnt+1;
    if cnt<junk_frame
        continue;
    end
    if sum(signal)==0
        continue;
    end
    if sum(signal)<mxv
        mxv=sum(signal);
        mx=signal;
    end
end

v = VideoReader(file_name);
init=0;
output=[];
gap=-100000;
gmx1=-9999999;
gmi1=9999999;
gmx2=-9999999;
gmi2=9999999;
cnt=0;
while hasFrame(v)
    video = readFrame(v);
    signal = sum(rgb2gray(video),2);
    cnt=cnt+1;
    if cnt<junk_frame
        continue;
    end
    if sum(signal)==0
        continue;
    end
    signal=signal-mx;
    if sum(signal)<100000000
        init=1;
    end
    if init==0
        continue;
    else
        gmx1=max(signal(1),gmx1);
        gmx2=max(signal(end),gmx2);
        gmi1=min(signal(1),gmi1);
        gmi2=min(signal(end),gmi2);
    end
end

v = VideoReader(file_name);
init=0;
output=[];
%gap=(gmx+gmi+gmi)/3;
gap1=(gmx1+gmi1)/2;
gap2=(gmx2+gmi2)/2;
%gap=5000;
%disp(["gap1=",gap1]);
%disp(["gap2=",gap2]);
cnt=0;
while hasFrame(v)
    video = readFrame(v);
    signal = sum(rgb2gray(video),2);
    cnt=cnt+1;
    if cnt<junk_frame
        continue;
    end
    if sum(signal)==0
        continue;
    end
    signal=signal-mx;
    if signal(1)<gap1 && signal(end)<gap2
        init=1;
    end
    if init==0
        continue;
    else
        output=[output,signal(1)>gap1];
        output=[output,signal(end)>gap2];
        %disp([signal(1)>gap1,signal(end)>gap2])
    end 
    %plot(signal);
    %axis([0, 1200, -1000000, 1000000]);
    %pause();
end
%disp(output);
while 1
    ok=1;
    for i = 1:16
        if output(i*2-1) ~= output(i*2)
            ok=0;
        end
    end
    for i = 1:8
        if output(i*4-2) == output(i*4-1)
            ok=0;
        end
    end
    if ok==0 || output(1) ~= 0
        output = output(2:end);
    else
        break;
    end
end
output = output(5:end);
bin=[];
for i = 1:8
    bin=[bin,output(i*4)];
end
bin=fliplr(bin);
disp(bin);
disp(char(bi2de(bin)));