clear;


data1=csvread('ShortContext.csv');

C = linspecer(2);

for isub=1:1;
a=data1(isub,:);

x=[0.6:0.2:1.8];
y=a(:)';

modelFun = @(p,x) normcdf(x,p(1),p(2)); 
startingVals = [1.4 0.5];

try
coefEsts = nlinfit(x, y, modelFun, startingVals)
PSE(isub,1)=coefEsts(1);
SD(isub,1)=coefEsts(2);

subplot(1,3,isub);
xgrid = linspace(0,3,100);
line(xgrid, modelFun(coefEsts, xgrid), 'Color','k','LineWidth',2);
hold on;
plot(x, y, 'o','Color','k','MarkerSize',4);

xlim([0 3])
ylim([0 1.1])

set(gca,'FontSize',12);
set(gca,'Fontname', 'Arial')

catch
    PSE(isub)=0;
end
end;


data1=csvread('LongContext.csv');



for isub=1:1;
a=data1(isub,:);

x=[1:0.2:2.2];
y=a(:)';

modelFun = @(p,x) normcdf(x,p(1),p(2)); 
startingVals = [1.4 0.5];

try
coefEsts = nlinfit(x, y, modelFun, startingVals)
PSE(isub,2)=coefEsts(1);
SD(isub,2)=coefEsts(2);

subplot(1,3,isub);
xgrid = linspace(0,3,100);
line(xgrid, modelFun(coefEsts, xgrid), 'Color','k','LineWidth',1);

hold on;
plot(x, y, '^','Color','k','MarkerSize',4);

catch
    PSE(isub)=0;
end
end;


hold on;

data1=csvread('MergeContext.csv');



for isub=1:1;
a=data1(isub,:);

x=[0.6:0.2:2.2];
y=a(:)';

modelFun = @(p,x) normcdf(x,p(1),p(2)); 
startingVals = [1.4 0.5];

try
coefEsts = nlinfit(x, y, modelFun, startingVals)
PSE(isub,2)=coefEsts(1);
SD(isub,2)=coefEsts(2);

subplot(1,3,isub);
xgrid = linspace(0,3,100);
line(xgrid, modelFun(coefEsts, xgrid), 'Color',[0.7 0.7 0.7],'LineWidth',3);

hold on;
plot(x, y, '.','Color','k','MarkerSize',10);

catch
    PSE(isub)=0;
end
end;





