clear;


load('BayesKalman1.mat')
mParB1=abs(squeeze(Bayes.para)');

N=12;
B1m=mean(mParB1,1);
ySEM = std(mParB1,0,1)/sqrt(N);
tCI95 = tinv([0.975], N-1);
B1ci95up = B1m + ySEM.*tCI95;
B1ci95low = B1m - ySEM.*tCI95;

clear Bayes ySEM CI95;


load('BayesKalman2.mat')
mParB2=abs(squeeze(Bayes.para)');

N=12;
B2m=mean(mParB2,1);
ySEM = std(mParB2,0,1)/sqrt(N);
tCI95 = tinv([0.975], N-1);
B2ci95up = B2m + ySEM.*tCI95;
B2ci95low = B2m - ySEM.*tCI95;

clear Bayes ySEM CI95;



