clear;


data1=csvread('MergeContext.csv');

C = linspecer(2);

for isub=1:12;
a=data1(isub,:);

x=[0.6:0.2:2.2];
y=a(:)';

modelFun = @(p,x) normcdf(x,p(1),p(2)); 
startingVals = [1.4 0.5];

try
coefEsts = nlinfit(x, y, modelFun, startingVals)
PSE(isub,1)=coefEsts(1);
SD(isub,1)=coefEsts(2);

subplot(2,6,isub);
xgrid = linspace(0,3,100);
line(xgrid, modelFun(coefEsts, xgrid),  'Color','k','LineWidth',2);
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

COEF(:,1)=PSE;
COEF(:,2)=SD;

csvwrite('MergCOEF.csv',COEF);



