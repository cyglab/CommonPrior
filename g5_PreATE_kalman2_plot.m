function ateplot( )
clear;

load('BayesKalman2.mat')

   
for isub=1:12;
   
    
    values=unique(Bayes.vts(:,1,isub));
    sizvalus=size(values);
    
    for iva=1:sizvalus(1);
        indexs(:,1)=find(Bayes.vts(:,1,isub)==values(iva));
        sizindx=size(indexs);
        if indexs(sizindx(1))<560;
        mate1(isub,iva)=mean(Bayes.ate((indexs(:,1)+1),1,isub));
        else mate1(isub,iva)=mean(Bayes.ate((indexs(1:(sizindx(1)-1),1)+1),1,isub));
        clear indexs;
    end;   
                                                                                
end;
end;
vlau1=values;

for isub=1:12;
   
    
    values=unique(Bayes.vts(:,2,isub));
    sizvalus=size(values);
    
    for iva=1:sizvalus(1);
        indexs(:,1)=find(Bayes.vts(:,2,isub)==values(iva));
        sizindx=size(indexs);
        if indexs(sizindx(1))<560;
        mate2(isub,iva)=mean(Bayes.ate((indexs(:)+1),2,isub));
        else mate2(isub,iva)=mean(Bayes.ate((indexs(1:(sizindx(1)-1),1)+1),2,isub));
        clear indexs;
    end;   
                                                                                
end;
end;

vlau2=values;

preAte.vlau1=vlau1;
preAte.vlau2=vlau2;
preAte.mate1=mate1;
preAte.mate2=mate2;

savepath='./';
save(strcat(savepath,'preAte.mat'),'preAte');

m1=mean(mate1,1);
se1=std(mate1,0,1)/sqrt(12);

m2=mean(mate2,1);
se2=std(mate2,0,1)/sqrt(12);

% C = linspecer(7)

x=vlau1';
plt.m=m1';
plt.se=se1';
plt.color='k';
plt.xrange=[0.25 2.5];
plt.yrange=[0.4 2.5];
plt.x=x;
d_plotpic2(plt);

hold on;

x=vlau2';
plt.m=m2';
plt.se=se2';
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

