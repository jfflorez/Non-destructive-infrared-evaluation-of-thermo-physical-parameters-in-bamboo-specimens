function [b,a,r2]=model_sel(Texp)

    G_model={'KB1_20','KB1_14','KB1_13','KB1_12','KB1_11','KB0_13','KB0_12','KB0_11'};

    r2=[];
    for i=1:length(G_model)
        load(sprintf('%s.mat',G_model{i}))

        Tavg=mean(Texp);
        Tpre=reshape(T(center(2),center(1),:),size(T,3),1,1);

        SStot=sum((Texp-Tavg).^2);
        SSres=sum((Texp-Tpre).^2);
        r2(i)=1-SSres/SStot; 
    end
    [~,i]=max(r2);
    load(sprintf('%s.mat',G_model{i}))
end

