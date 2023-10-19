clear;
load('LongRespPreData.mat');

nsub=1;
vlau1=LongRespPreData.vlau1
vlau2=LongRespPreData.vlau2
m1=mean(LongRespPreData.mPerct1,3);
se1=std(LongRespPreData.mPerct1,0,3)/sqrt(12);

m2=mean(LongRespPreData.mPerct2,3);
se2=std(LongRespPreData.mPerct2,0,3)/sqrt(12);

% C = linspecer(7)
C(1,:) = [0 63 92]/255;
C(2,:) = [55 76 128]/255;
C(3,:) = [122 81 149]/255;
C(4,:) = [188 80 144]/255;
C(5,:) = [239 86 117]/255;
C(6,:) = [255 118 74]/255;
C(7,:) = [255 166 0]/255;

%C(1,:) = [1 1 1]*0.1;
%C(2,:) = [1 1 1]*0.3;
%C(3,:) = [1 1 1]*0.4;
%C(4,:) = [1 1 1]*0.5;
%C(5,:) = [1 1 1]*0.6;
%C(6,:) = [1 1 1]*0.7;
%C(7,:) = [1 1 1]*0.8;

for iva=1:7;
 subplot(2,2,1)   
%plot(LongRespPreData.vlau1,m1(iva,:),'-o','Linewidth',2,'Color',C(iva,:))
errorbar(vlau1,m1(iva,:),se1(iva,:),'-o','linewidth',2,'Color',C(iva,:), 'MarkerSize',3,...
   'MarkerEdgeColor',C(iva,:),'MarkerFaceColor',C(iva,:));
hold on;

end;

%set(gca, 'xlim', [1, 2.3]);
%set(gca, 'ylim', [1, 2.2]);
set(gca,'FontSize',10);
set(gca,'Fontname', 'Arial')

for iva=1:7;
 subplot(2,2,2)   
%plot(LongRespPreData.vlau2,m2(iva,:),'-o','Linewidth',2,'Color',C(iva,:))
errorbar(vlau2,m2(iva,:),se2(iva,:),'-o','linewidth',2,'Color',C(iva,:), 'MarkerSize',3,...
   'MarkerEdgeColor',C(iva,:),'MarkerFaceColor',C(iva,:));
hold on;

end;

%set(gca, 'xlim', [1, 2.3]);
%set(gca, 'ylim', [1, 2.2]);
set(gca,'FontSize',10);
set(gca,'Fontname', 'Arial')
    
