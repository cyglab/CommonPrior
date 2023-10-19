clear;

data=csvread('DataClean.csv');

sizdata=size(data);

    
for isub=1:12;
    j1=0; 
    j2=0;
    for itri=1:sizdata(1);
      if data(itri,1)==isub && data(itri,2)==1;
          j1=j1+1;
          data1(j1,:)=data(itri,:);
      end;

      if data(itri,1)==isub && data(itri,2)==2;
          j2=j2+1;
          data2(j2,:)=data(itri,:);
      end;
    end;
    
    values1=unique(data1(:,4));
    sizvalu1=size(values1);
    
    for iva=1:sizvalu1(1);
        m1(:,iva)=find(data1(:,4)==values1(iva));
        mPvla1(isub,iva)=mean(data1(m1(:,iva),5));
    end;

    
   
    
    values2=unique(data2(:,4));
    sizvalu2=size(values2);
    

    for iva=1:sizvalu2(1);    
        m2(:,iva)=find(data2(:,4)==values2(iva));
        mPvla2(isub,iva)=mean(data2(m2(:,iva),5));
    end;    
                                                                                
end;


csvwrite('ShortContext.csv',mPvla1);
csvwrite('LongContext.csv',mPvla2);


