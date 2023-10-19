clear;

load('LongRespPreData.mat');
vlau1=LongRespPreData.vlau1;
mPerct1=LongRespPreData.mPerct1;

for isub=1:12;
    for iva=1:7;
        x=vlau1';
        y=mPerct1(iva,:,isub);

modelFun = @(p,x) normcdf(x,p(1),p(2)); 
startingVals = [1.3 0.5];

try
coefEsts = nlinfit(x, y, modelFun, startingVals)
PSE(isub,iva)=coefEsts(1);
SD(isub,iva)=coefEsts(2);


catch
    PSE(isub)=0;
end
end;
end;

for i=1:12;
    for j=1:7;
        if PSE(i,j)>10;
            PSE(i,j)=(PSE(i,j-1)+PSE(i,j+1))/2;
        end;
    end;
end;


m1=mean(PSE,1);
se1=std(PSE,0,1)/sqrt(12);
PSE1=PSE;


hold on;

vlau2=LongRespPreData.vlau2;
mPerct2=LongRespPreData.mPerct2;

for isub=1:12;
    for iva=1:7;
        x=vlau2';
        y=mPerct2(iva,:,isub);

modelFun = @(p,x) normcdf(x,p(1),p(2)); 
startingVals = [1.7 0.5];

try
coefEsts = nlinfit(x, y, modelFun, startingVals)
PSE(isub,iva)=coefEsts(1);
SD(isub,iva)=coefEsts(2);


catch
    PSE(isub)=0;
end
end;
end;

for i=1:12;
    for j=1:7;
        if PSE(i,j)==0;
            if j==1;
            PSE(i,j)=PSE(i,j+1);
            else if j==7;
                    PSE(i,j)=PSE(i,j-1);
                else PSE(i,j)=(PSE(i,j-1)+PSE(i,j+1))/2;
                end;
            end;
        end;
    end;
end;

PSE(3,3)=(PSE(3,2)+PSE(3,4))/2;
m2=mean(PSE,1);
se2=std(PSE,0,1)/sqrt(12);
PSE2=PSE;



prePSE.vlau1=vlau1;
prePSE.vlau2=vlau2;
prePSE.PSE1=PSE1;
prePSE.PSE2=PSE2;

savepath='./';
save(strcat(savepath,'prePSE.mat'),'prePSE');

% C = linspecer(7);

errorbar(vlau1,m1,se1,'o','linewidth',1.5,'Color','k', 'MarkerSize',5,...
   'MarkerEdgeColor','k','MarkerFaceColor','k');
hold on;

errorbar(vlau2,m2,se2,'^','linewidth',1,'Color','k', 'MarkerSize',5,...
   'MarkerEdgeColor','k','MarkerFaceColor','w');