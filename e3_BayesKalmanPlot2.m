function fig1c( );

sdata=csvread('ShortContext.csv');
ldata=csvread('LongContext.csv');

x=[0.6:0.2:1.8];
m=mean(sdata,1);
se=std(sdata,0,1)/sqrt(12);

errorbar(x,m,se,'o','linewidth',1.5,'Color','k', 'MarkerSize',5,...
   'MarkerEdgeColor','k','MarkerFaceColor','k');
hold on;

x=[1:0.2:2.2];
m=mean(ldata,1);
se=std(ldata,0,1)/sqrt(12);

errorbar(x,m,se,'^','linewidth',1,'Color','k', 'MarkerSize',7,...
   'MarkerEdgeColor','k','MarkerFaceColor',[1,1,1]);

set(gca,'FontSize',12);
set(gca,'Fontname', 'Arial')
hold on;


load('BayesKalman1.mat')

sizdata=size(Bayes.vts);



for isub=1:sizdata(3);
        for icontex=1:sizdata(2);
             valuTs(:,icontex,isub)=unique(Bayes.vts(:,icontex,isub));
             sizvalu=size(valuTs(:,icontex,isub));
             
             for iva=1:sizvalu(1);
                 m=find(Bayes.vts(:,icontex,isub)==valuTs(iva,icontex,isub));
                 mp(iva,icontex,isub)=mean(Bayes.p(m,icontex,isub));
             end;
        end;
end;
                 
    
mvp=squeeze(mean(mp,3));
sevp=squeeze(std(mp,0,3)/sqrt(12));



x=[0.6:0.2:1.8];

plt.m=mvp(:,1);
plt.se=sevp(:,1);
plt.color='k';
plt.xrange=[0 2];
plt.yrange=[0 1.2];
plt.x=x;
d_plotpic2(plt);

hold on;

x=[1:0.2:2.2];

plt.m=mvp(:,2);
plt.se=sevp(:,2);
plt.color='k';
plt.xrange=[0.25 2.5];
plt.yrange=[0 1.1];
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
            