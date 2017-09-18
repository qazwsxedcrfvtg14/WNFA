t = tcpclient('mvnl.csie.ntu.edu.tw', 7770);
while(t.BytesAvailable==0)end
A = read(t);
disp(char(A));
write(t,[uint8('Q'),10]);
while(t.BytesAvailable==0)end
B = read(t);
disp(char(B));
data = sscanf(char(B),'%d %d');
disp(data(2))
while(t.BytesAvailable==0)end
A = read(t);


%disp(char(A));
write(t,uint8('A'));
write(t,uint8(int2str(sum(data))));
while(t.BytesAvailable==0)end
flag = read(t);
disp(char(flag));
















rng default; % For reproducibility
X = [randn(100,2)*0.75+ones(100,2);
    randn(100,2)*0.5-ones(100,2)];

figure;
plot(X(:,1),X(:,2),'.');
title 'Randomly Generated Data';

opts = statset('Display','final');
[idx,C] = kmeans(X,2,'Distance','cityblock',...
    'Replicates',5,'Options',opts);

figure;
plot(X(idx==1,1),X(idx==1,2),'r.','MarkerSize',12)
hold on
plot(X(idx==2,1),X(idx==2,2),'b.','MarkerSize',12)
plot(C(:,1),C(:,2),'kx',...
     'MarkerSize',15,'LineWidth',3)
disp(C(:,1))
disp(C(:,2))
legend('Cluster 1','Cluster 2','Centroids',...
       'Location','NW')
title 'Cluster Assignments and Centroids'
hold off