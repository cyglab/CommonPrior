clear;

data=csvread('DataClean.csv');

sizdata=size(data);

    
for isub=1:12;
    j1=0; 
    j2=0;
    for itri=1:sizdata(1);
      if data(itri,1)==isub;
          j1=j1+1;
          data1(j1,:)=data(itri,:);
      end;
    end;
      
    
    values1=unique(data1(:,4));
    sizvalu1=size(values1);
    
    for iva=1:sizvalu1(1);
        m1(:)=find(data1(:,4)==values1(iva));
        mPvla1(isub,iva)=mean(data1(m1(:),5));
        clear m1;
    end;   
                                                                                
end;


csvwrite('MergeContext.csv',mPvla1);



