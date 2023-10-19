
g4_LongRespPrevDataPlot1;

subplot(2,2,3);

g5_PreATE_kalman1_plot;
hold on
g5_PrePSE_plot;

%set(gca, 'xlim', [1, 2.3]);
set(gca, 'ylim', [1, 2.2]);
set(gca,'FontSize',10);
set(gca,'Fontname', 'Arial')


subplot(2,2,4);

g5_PreATE_kalman2_plot;
hold on
g5_PrePSE_plot;

%set(gca, 'xlim', [1, 2.3]);
set(gca, 'ylim', [1, 2.2]);
set(gca,'FontSize',10);
set(gca,'Fontname', 'Arial')

