file_name='team9_v10_que.bin.mp4';
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
gmx=-9999999;
gmi=9999999;
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
        gmx=max(signal(1),gmx);
        gmx=max(signal(end),gmx);
        gmi=min(signal(1),gmi);
        gmi=min(signal(end),gmi);
    end
end

v = VideoReader(file_name);
init=0;
output=[];
gap=(gmx+gmi)/3;
%gap=5000;
%disp(["gap=",gap]);
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
    if signal(1)<gap && signal(end)<gap
        init=1;
    end
    if init==0
        continue;
    else
        output=[output,signal(1)>gap];
        output=[output,signal(end)>gap];
        %disp([signal(1)>gap,signal(end)>gap])
    end 
    %plot(signal);
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
while 1
    if output(1) == output(3)
        output = output(3:end);
    else
        break
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