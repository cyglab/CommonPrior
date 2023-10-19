function ateplot( )
clear;

load('BayesKalman1.mat')

   
ate=squeeze(Bayes.ate);

for i=1:7;
mate(1,i)=mean(ate);
seate(1,i)=std(ate,0,1)/sqrt(12);
end;

x=[0.6:0.2:1.8];
plt.m=mate';
plt.se=seate';
plt.color='k';
plt.xrange=[0.25 2.5];
plt.yrange=[0.4 2.5];
plt.x=x;
d_plotpic2(plt);

hold on;

x=[1:0.2:2.2];
plt.m=mate';
plt.se=seate';
plt.color='k';
plt.xrange=[0.25 2.5];
plt.yrange=[0.4 2.5];
plt.x=x;
d_plotpic(plt);

hold on;



function d_plotpic(plt);
m=plt.m;
se=plt.se;
color=plt.color;
xrange=plt.xrange;
yrange=plt.yrange;
x=plt.x

y1=m-se;
y2=m+se;


[xx,yy]=fill2line(x,y1,y2);
h=fill(xx,yy,color,'EdgeColor',color,'FaceAlpha',0.3,'EdgeAlpha',0.3);
set(h,'edgecolor','white');
set(gca, 'ylim',yrange);      %[0.7, 1.0000001]
set(gca, 'xlim',xrange);            %[0, 24]

hold on;

plot(x,m,'-',...
                'LineWidth',1,...
                'Color',color)
            hold on;
hold on;

function d_plotpic2(plt);
m=plt.m;
se=plt.se;
color=plt.color;
xrange=plt.xrange;
yrange=plt.yrange;
x=plt.x

y1=m-se;
y2=m+se;


[xx,yy]=fill2line(x,y1,y2);
h=fill(xx,yy,color,'EdgeColor',color,'FaceAlpha',0.3,'EdgeAlpha',0.3);
set(h,'edgecolor','white');
set(gca, 'ylim',yrange);      %[0.7, 1.0000001]
set(gca, 'xlim',xrange);            %[0, 24]

hold on;

plot(x,m,'-',...
                'LineWidth',2,...
                'Color',color)
            hold on;
hold on;
            
function [xx,yy]=fill2line(x,y1,y2)


sizX=size(x);
xx(1:sizX(2))=x;
xx(sizX(2)+1:sizX(2)*2)=x(1,sizX(2):-1:1);

yy(1:sizX(2))=y1';
yy(sizX(2)+1:sizX(2)*2)=y2(sizX(2):-1:1,1);

