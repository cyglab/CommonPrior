clear;

subplot(2,3,1);

load('BayesKalman1.mat');

ate=squeeze(Bayes.ate);
mate=mean(ate,1);
seate=std(ate,0,1)/sqrt(12);


x=[1 2];

errorbar(x,[mate mate],[seate seate],'o-','linewidth',1.5,'Color','k', 'MarkerSize',5,...
   'MarkerEdgeColor','k','MarkerFaceColor',[1,1,1]);

set(gca,'FontSize',12);
set(gca,'Fontname', 'Arial')
xlim([0 3])
ylim([0 3])
hold on;

%================
subplot(2,3,2);

sizdata=size(Bayes.vts);



for isub=1:sizdata(3);
        for icontex=1:sizdata(2);
             valuTs(:,icontex,isub)=unique(Bayes.vts(:,icontex,isub));
             sizvalu=size(valuTs(:,icontex,isub));
             
             for iva=1:sizvalu(1);
                 m=find(Bayes.vts(:,icontex,isub)==valuTs(iva,icontex,isub));
                 mte(iva,icontex,isub)=mean(Bayes.vte(m,icontex,isub));
             end;
        end;
end;
                 
    


vte=mean(mte,3);
mvte=squeeze(mean(vte,4));
sevte=squeeze(std(vte,0,4)/sqrt(12));

x=[0:0.1:3];
y=x;
plot(x,y,'k--');
hold on;



x=[0.6:0.2:1.8];
y=mvte(:,1);
se=sevte(:,1);
errorbar(x,y,se,'o-','linewidth',1.5,'Color','k', 'MarkerSize',5,...
   'MarkerEdgeColor','k','MarkerFaceColor','k');

hold on;

plot(x,y,'k-','LineWidth',2);
hold on;
plot(x,y,'ko','MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',5);


hold on;
x=[1:0.2:2.2];
y=mvte(:,2);

se=sevte(:,2);
errorbar(x,y,se,'^-','linewidth',1,'Color','k', 'MarkerSize',0.1,...
   'MarkerEdgeColor','k','MarkerFaceColor','k');
hold on;

plot(x,y,'k-','LineWidth',1);
hold on;
plot(x,y,'k^','MarkerEdgeColor','k','MarkerSize',9);
hold on;

xlim([0 3])
ylim([0 3])
set(gca,'FontSize',12);
set(gca,'Fontname', 'Arial')

%==========================
subplot(2,3,3);

e3_BayesKalmanPlot2;

%==========================

subplot(2,3,4);

load('BayesKalman2.mat');


ate=squeeze(mean(Bayes.ate,1));
mate=mean(ate,2);
seate=std(ate,0,2)/sqrt(12);


x=[1 2];

errorbar(x,mate,seate,'o-','linewidth',1.5,'Color','k', 'MarkerSize',5,...
   'MarkerEdgeColor','k','MarkerFaceColor',[1,1,1]);

set(gca,'FontSize',12);
set(gca,'Fontname', 'Arial')
xlim([0 3])
ylim([0 3])
hold on;

%================
subplot(2,3,5);

sizdata=size(Bayes.vts);



for isub=1:sizdata(3);
        for icontex=1:sizdata(2);
             valuTs(:,icontex,isub)=unique(Bayes.vts(:,icontex,isub));
             sizvalu=size(valuTs(:,icontex,isub));
             
             for iva=1:sizvalu(1);
                 m=find(Bayes.vts(:,icontex,isub)==valuTs(iva,icontex,isub));
                 mte(iva,icontex,isub)=mean(Bayes.vte(m,icontex,isub));
             end;
        end;
end;
                 
    


vte=mean(mte,3);
mvte=squeeze(mean(vte,4));
sevte=squeeze(std(vte,0,4)/sqrt(12));

x=[0:0.1:3];
y=x;
plot(x,y,'k--');
hold on;



x=[0.6:0.2:1.8];
y=mvte(:,1);
se=sevte(:,1);
errorbar(x,y,se,'o-','linewidth',1.5,'Color','k', 'MarkerSize',5,...
   'MarkerEdgeColor','k','MarkerFaceColor','k');

hold on;

plot(x,y,'k-','LineWidth',2);
hold on;
plot(x,y,'ko','MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',5);


hold on;
x=[1:0.2:2.2];
y=mvte(:,2);

se=sevte(:,2);
errorbar(x,y,se,'^-','linewidth',1,'Color','k', 'MarkerSize',0.1,...
   'MarkerEdgeColor','k','MarkerFaceColor','k');
hold on;

plot(x,y,'k-','LineWidth',1);
hold on;
plot(x,y,'k^','MarkerEdgeColor','k','MarkerSize',9);
hold on;

xlim([0 3])
ylim([0 3])
set(gca,'FontSize',12);
set(gca,'Fontname', 'Arial')

%==========================
subplot(2,3,6);

e3_BayesKalmanPlot3;

%==========================
