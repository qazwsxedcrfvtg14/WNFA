Fs = 44100 ; % 1000 samples 
lop=10;
t = 0:1/Fs:60*lop;
L = length(t);
f = 13333; % 100Hz
square_wave=square(2*pi*f*t);

year=2017;
month=10;
day=2;
hour=17;
minute=43;

for ii=1:lop
    input = [year month day hour minute]; % [year month date hour minute] 
    code = zeros(1,60);

    % minute
    temp = input(5);
    table = [40 20 10 1000 8 4 2 1];
    for i=1:8
        if temp>=table(i)
            code(1+i)=1;
            temp=temp-table(i);
        end
    end

    % hour
    temp = input(4);
    table = [20 10 1000 8 4 2 1];
    for i=1:7
        if temp>=table(i)
            code(12+i)=1;
            temp = temp-table(i);
        end
    end

    % day of year
    if mod(input(1),4)==0
        month_date = [0 31 60 91 121 152 182 213 244 274 305 335];
    else
        month_date = [0 31 59 90 120 151 181 212 243 273 304 334];
    end
    temp = month_date(input(2))+input(3);
    table = [200 100 1000 80 40 20 10 1000 8 4 2 1];
    for i=1:12
        if temp>=table(i)
            code(22+i)=1;
            temp = temp-table(i);
        end
    end

    % even parity of hours bits
    temp = 0;
    for i=13:19
        temp = temp+code(i);
    end
    code(37)=mod(temp,2);

    % even parity of minutes bits
    temp = 0;
    for i=2:9
        temp = temp+code(i);
    end
    code(38)=mod(temp,2);

    % year
    temp = mod(input(1),100);
    table = [80 40 20 10 8 4 2 1];
    for i=1:8
        if temp>=table(i)
            code(41+i) = 1;
            temp = temp-table(i);
        end
    end

    % mark
    code(1)=2;
    for i=1:6
        code(i*10) = 2;
    end
    disp(code);
    %pause();

    for k=1:60
        base=(ii-1)*Fs*60+(k-1)*Fs;
        %disp(base);
        for j=1:Fs/5
            square_wave(base+j)=square_wave(base+j)*0.999999;
        end
        for j=Fs/5+1:Fs/2
            if(code(k)<=1)
                square_wave(base+j)=square_wave(base+j)*0.999999;
            else
                square_wave(base+j)=square_wave(base+j)*0.0;
            end
        end
        for j=Fs/2+1:Fs*4/5
            if(code(k)<=0)
                square_wave(base+j)=square_wave(base+j)*0.999999;
            else
                square_wave(base+j)=square_wave(base+j)*0.0;
            end
        end
        for j=Fs*4/5+1:Fs
            square_wave(base+j)=square_wave(base+j)*0.0;
        end
    end
    minute = minute+1;
    if(minute>=60)
        minute=minute-60;
        hour=hour+1;
    end
    if(hour>=24)
        hour=hour-24;
        day=day+1;
    end
    %input = [year month day hour minute]; % [year month date hour minute] 
end
audiowrite('go.wav',square_wave,Fs);
