clear;

load('BayesKalman2.mat')

   
for isub=1:12;
   
    
    values=unique(Bayes.vts(:,1,isub));
    sizvalus=size(values);
    
    for ivaPre=1:sizvalus(1);
        idPre(:)=find(Bayes.vts(:,1,isub)==values(ivaPre));
        sizidPre=size(idPre); 
        idPre=idPre+1;
        for ivaPos=1:sizvalus(1);
            idPos(:)=find(Bayes.vts(:,1,isub)==values(ivaPos));
            sizidPos=size(idPos); 
            
            idInter=intersect(idPre,idPos);
            mPerct1(ivaPre,ivaPos,isub)=mean(Bayes.resp(idInter,1,isub));
        end;
    end;   
                                                                                
end;

vlau1=values;

for isub=1:12;
   
    
    values=unique(Bayes.vts(:,2,isub));
    sizvalus=size(values);
    
    for ivaPre=1:sizvalus(1);
        idPre(:)=find(Bayes.vts(:,2,isub)==values(ivaPre));
        sizidPre=size(idPre); 
        idPre=idPre+1;
        for ivaPos=1:sizvalus(1);
            idPos(:)=find(Bayes.vts(:,2,isub)==values(ivaPos));
            sizidPos=size(idPos); 
            
            idInter=intersect(idPre,idPos);
            mPerct2(ivaPre,ivaPos,isub)=mean(Bayes.resp(idInter,2,isub));
        end;
    end;   
                                                                                
end;

vlau2=values;

LongRespPreData.vlau1=vlau1;
LongRespPreData.vlau2=vlau2;

LongRespPreData.mPerct1=mPerct1;
LongRespPreData.mPerct2=mPerct2;

savepath='./';
save(strcat(savepath,'LongRespPreData.mat'),'LongRespPreData');