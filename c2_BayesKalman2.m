function BayesKalman(  );

clear;

%read data from xlsx files
data=csvread('DataClean.csv');

intCOEF=csvread('MergCOEF.csv');

k.intPSE=intCOEF(:,1);
k.intSD=intCOEF(:,2);

sizData=size(data);
data(:,4)=data(:,4)/1000;


for isub=1:12;
    
k.isub=isub;
    
sizData=size(data);
j=0;
for i=1:sizData(1);
    if data(i,1)==isub;
        j=j+1;
        data1sub(j,:)=data(i,:);
    end;
end;

sizData=size(data1sub);
    
k.data1sub=data1sub;
k.context(:,:,isub)=[data1sub(1,2) data1sub(sizData(1),2)];
k.prepost(:,:,isub)=[data1sub(1,7) data1sub(sizData(1),7)];

[a1]=fitModel(k);
[E output]=fitFun(a1,k);

Bayes.ats(:,:,isub)=output.ats;
Bayes.asTs(:,:,isub)=output.asTs;




sizevts=size(output.vts);
if k.context(1,1,isub)==1 && k.prepost(1,1,isub)==1; % pre section is short context
Bayes.resp(:,1,isub)=output.resp(1:sizevts(1)/2,:);    
Bayes.resp(:,2,isub)=output.resp(sizevts(1)/2+1:sizevts(1),:);    

Bayes.ate(:,1,isub)=output.ate(1:sizevts(1)/2,:);    
Bayes.ate(:,2,isub)=output.ate(sizevts(1)/2+1:sizevts(1),:);

Bayes.aSe(:,1,isub)=output.aSe(1:sizevts(1)/2,:);
Bayes.aSe(:,2,isub)=output.aSe(sizevts(1)/2+1:sizevts(1),:);

Bayes.vts(:,1,isub)=output.vts(1:sizevts(1)/2,:);
Bayes.vts(:,2,isub)=output.vts(sizevts(1)/2+1:sizevts(1),:);

Bayes.vsTs(:,1,isub)=output.vsTs(1:sizevts(1)/2,:);
Bayes.vsTs(:,2,isub)=output.vsTs(sizevts(1)/2+1:sizevts(1),:);

Bayes.vte(:,1,isub)=output.vte(1:sizevts(1)/2,:);
Bayes.vte(:,2,isub)=output.vte(sizevts(1)/2+1:sizevts(1),:);

Bayes.vSe(:,1,isub)=output.vSe(1:sizevts(1)/2,:);
Bayes.vSe(:,2,isub)=output.vSe(sizevts(1)/2+1:sizevts(1),:);

Bayes.p(:,1,isub)=output.p(1:sizevts(1)/2,:);
Bayes.p(:,2,isub)=output.p(sizevts(1)/2+1:sizevts(1),:);

else if k.context(1,1,isub)==2 && k.prepost(1,1,isub)==1; 

    Bayes.resp(:,2,isub)=output.resp(1:sizevts(1)/2,:);    
    Bayes.resp(:,1,isub)=output.resp(sizevts(1)/2+1:sizevts(1),:);  
      
    Bayes.ate(:,2,isub)=output.ate(1:sizevts(1)/2,:);    
    Bayes.ate(:,1,isub)=output.ate(sizevts(1)/2+1:sizevts(1),:);

    Bayes.aSe(:,2,isub)=output.aSe(1:sizevts(1)/2,:);
    Bayes.aSe(:,1,isub)=output.aSe(sizevts(1)/2+1:sizevts(1),:);        
        
        
    Bayes.vts(:,2,isub)=output.vts(1:sizevts(1)/2,:);
    Bayes.vts(:,1,isub)=output.vts(sizevts(1)/2+1:sizevts(1),:);

    Bayes.vsTs(:,2,isub)=output.vsTs(1:sizevts(1)/2,:);
    Bayes.vsTs(:,1,isub)=output.vsTs(sizevts(1)/2+1:sizevts(1),:);

    Bayes.vte(:,2,isub)=output.vte(1:sizevts(1)/2,:);
    Bayes.vte(:,1,isub)=output.vte(sizevts(1)/2+1:sizevts(1),:);

    Bayes.vSe(:,2,isub)=output.vSe(1:sizevts(1)/2,:);
    Bayes.vSe(:,1,isub)=output.vSe(sizevts(1)/2+1:sizevts(1),:);

    Bayes.p(:,2,isub)=output.p(1:sizevts(1)/2,:);
    Bayes.p(:,1,isub)=output.p(sizevts(1)/2+1:sizevts(1),:);

    end;
end;

Bayes.para(:,:,isub)=output.para;
Bayes.E(:,:,isub)=output.E;

end;

Bayes.context=k.context;
Bayes.prepost=k.prepost;

savepath='./';
save(strcat(savepath,'BayesKalman2.mat'),'Bayes');
clear Bayes;




function [a1]=fitModel(k);

% begin to fit data

options=optimset('fminsearch');
options.TolX=0.001;
options.Display='final';
            
r0=rand(1,3)*0.01;
c0=[0.2 0.2 0.2]; 
c1=c0+r0;
            
[a1,sfval,sexit,soutput]=fminsearch(@fitFun,c1,options,k);
            
               

function [E output]=fitFun(a1,k);

k.data=k.data1sub;

[output1] = estiE(a1,k);

E=output1.E;

output.resp(:,1)=output1.resp;

output.ats(:,1)=output1.ats;
output.asTs(:,1)=output1.asTs;

output.ate(:,1)=output1.ate;
output.aSe(:,1)=output1.aSe;

output.vts(:,1)=output1.vts;
output.vsTs(:,1)=output1.vsTs;

output.vte(:,1)=output1.vte;
output.vSe(:,1)=output1.vSe;

output.p(:,1)=output1.p;

clear k.data;


output.para(:,1)=a1';
output.E(:,1)=E;







function [output] = estiE(a1,k);

t0=0.03;
vSig2m=a1(1)^2;
q=abs(a1(2));
aSig2m=a1(3)^2;

aTs=k.intPSE(k.isub);

data=k.data;

vTs=data(:,4);
resp=data(:,5);

vsTs=log(1+vTs/t0);
asTs=log(1+aTs/t0);
sizdat=size(vsTs);

sig2Pri0=0.2;
mPri0=0.6;

ik=0;
for ii=1:sizdat(1);
    % auditory standard duration======
    % update prior 
       ki = (sig2Pri0 + q)/(sig2Pri0 + q + aSig2m);
       sig2Pri = ki * aSig2m;
       mPri = (1 - ki) * mPri0 + ki * asTs;
            
     % Bayesion estimation 
       w = sig2Pri/(sig2Pri + aSig2m);
       aSe(ii,1) = w * asTs + (1-w) * mPri;
       aSig2Pos(ii,1) = sig2Pri * aSig2m/(sig2Pri + aSig2m);
       
       ik=ik+1;
       kValue(ik)=ki;
       
       sig2Pri0=sig2Pri;
       mPri0=mPri;       
       
    % visual compare duration=======
       ki = (sig2Pri0 + q)/(sig2Pri0 + q +vSig2m);
       sig2Pri = ki * vSig2m;
       mPri = (1 - ki) * mPri0 + ki * vsTs(ii);
       
       w = sig2Pri/(sig2Pri + vSig2m);
       vSe(ii,1) = w * vsTs(ii) + (1 -w)*mPri;      
       vSig2Pos(ii,1) = sig2Pri * vSig2m/(sig2Pri + vSig2m);

       ik=ik+1;
       kValue(ik)=ki; 
       
       sig2Pri0=sig2Pri;
       mPri0=mPri;
       
end;

zscore=(vSe-aSe)./(sqrt(vSig2Pos+aSig2Pos));

probs=normcdf(zscore,0,1);

output.p=probs;

sizts=size(probs);
for ii=1:sizts(1);
    if resp(ii)==0;
        probs(ii)=1-probs(ii);
    end;
end;

logPro=-log(probs);

E=sum(logPro);

%=================================
%=================================
output.resp(:,1)=resp;

output.ats(:,1)=aTs;
output.asTs(:,1)=asTs;

output.ate(:,1)=(exp(aSe)-1)*t0;

output.aSe(:,1)=aSe;

output.vts(:,1)=vTs;
output.vsTs(:,1)=vsTs;

output.vte(:,1)=(exp(vSe)-1)*t0;
output.vSe(:,1)=vSe;

output.E(:,1)=E;


