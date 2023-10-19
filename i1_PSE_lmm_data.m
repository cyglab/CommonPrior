load('prePSE.mat');
load('preAte.mat')
num=0;
for ii=1:12;
    for jj=1:7;
        num=num+1;
        lmmPSE1(1,num)=ii;
        lmmPSE1(2,num)=1;
        lmmPSE1(3,num)=prePSE.vlau1(jj);
        lmmPSE1(4,num)=prePSE.PSE1(ii,jj);
        lmmPSE1(5,num)=preAte.mate1(ii,jj);
    end;
end;

num=0;
for ii=1:12;
    for jj=1:7;
        num=num+1;
        lmmPSE2(1,num)=ii;
        lmmPSE2(2,num)=2;
        lmmPSE2(3,num)=prePSE.vlau2(jj);
        lmmPSE2(4,num)=prePSE.PSE2(ii,jj);
        lmmPSE2(5,num)=preAte.mate2(ii,jj);
    end;
end;

lmmPSE0=[lmmPSE1 lmmPSE2]';

nam0=[1 2 3 4 5];
lmmPSE=[nam0;lmmPSE0];

csvwrite('lmmPSEaTe.csv',lmmPSE);
