clear;

load('BayesKalman1.mat')
E1=squeeze(Bayes.E);
clear Bayes;

 load('BayesKalman2.mat')
E2=squeeze(Bayes.E);
clear Bayes;

AIC(:,1)=2*E1+2*3;
AIC(:,2)=2*E2+2*3;
AIC(:,3)=AIC(:,1)-AIC(:,2);

N=12;
AICm=mean(AIC,1);
AICSE = std(AIC,0,1)/sqrt(N);
tCI95 = tinv([0.975], N-1);
AICci95up = AICm + AICSE.*tCI95;
AICci95low = AICm - AICSE.*tCI95;


