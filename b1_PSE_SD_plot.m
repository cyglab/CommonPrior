clear;


data1=csvread('ShortContext.csv');

shortM=mean(data1,1);
shortSE=std(data1,0,1)/sqrt(12);

for isub=1:12;
a=data1(isub,:);

x=[0.6:0.2:1.8];
y=a(:)';

modelFun = @(p,x) normcdf(x,p(1),p(2)); 
startingVals = [1.4 0.5];

try
coefEsts = nlinfit(x, y, modelFun, startingVals)
PSE(isub,1)=coefEsts(1);
SD(isub,1)=coefEsts(2);

xgrid = linspace(0,3,100);
line(xgrid, modelFun(coefEsts, xgrid), 'Color','k','LineWidth',2);
shortY(:,isub)=modelFun(coefEsts, xgrid);

catch
    PSE(isub)=0;
end
end;

data1=csvread('MergeContext.csv');

longM=mean(data1,1);
longSE=std(data1,0,1)/sqrt(12);

for isub=1:12;
a=data1(isub,:);

x=[0.6:0.2:2.2];
y=a(:)';

modelFun = @(p,x) normcdf(x,p(1),p(2)); 
startingVals = [1.4 0.5];

try
coefEsts = nlinfit(x, y, modelFun, startingVals)
PSE(isub,2)=coefEsts(1);
SD(isub,2)=coefEsts(2);

xgrid = linspace(0,3,100);
line(xgrid, modelFun(coefEsts, xgrid), 'Color','k','LineWidth',2);
longY(:,isub)=modelFun(coefEsts, xgrid);

catch
    PSE(isub)=0;
end
end;


data1=csvread('LongContext.csv');

longM=mean(data1,1);
longSE=std(data1,0,1)/sqrt(12);

for isub=1:12;
a=data1(isub,:);

x=[1:0.2:2.2];
y=a(:)';

modelFun = @(p,x) normcdf(x,p(1),p(2)); 
startingVals = [1.4 0.5];

try
coefEsts = nlinfit(x, y, modelFun, startingVals)
PSE(isub,3)=coefEsts(1);
SD(isub,3)=coefEsts(2);

xgrid = linspace(0,3,100);
line(xgrid, modelFun(coefEsts, xgrid), 'Color','k','LineWidth',2);
longY(:,isub)=modelFun(coefEsts, xgrid);

catch
    PSE(isub)=0;
end
end;




mPSE=mean(PSE,1);
sePSE=std(PSE,0,1)/sqrt(12);

mSD=mean(SD,1);
seSD=std(SD,0,1)/sqrt(12);

[h1,p1,ci1,stats1] = ttest(PSE(:,1),PSE(:,2));
[h2,p2,ci2,stats2] = ttest(SD(:,1),SD(:,2));


C = linspecer(2);

subplot(1,3,2);
x = [1 2 3];
y = mPSE;
se = sePSE;

errorbar(x,y,se,'o','linewidth',1.5,'Color','k', 'MarkerSize',0.1,...
   'MarkerEdgeColor','k','MarkerFaceColor','k');
hold on;

bar(y,0.4,'FaceColor','k')
xlim([0 4])
ylim([0 2.5])

set(gca,'FontSize',12);
set(gca,'Fontname', 'Arial')

subplot(1,3,3);
x = [1 2 3];
y = mSD;
se = seSD;

errorbar(x,y,se,'o','linewidth',1.5,'Color','k', 'MarkerSize',0.1,...
   'MarkerEdgeColor','k','MarkerFaceColor','k');
hold on;

bar(y,0.4,'FaceColor','k')
xlim([0 4])
ylim([0 0.7])

set(gca,'FontSize',12);
set(gca,'Fontname', 'Arial')






