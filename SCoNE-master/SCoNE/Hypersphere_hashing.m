function [hash_values] = Hypersphere_hashing(data, psi, k, t)

[sn,~]=size(data{1});
[n,~]=size(data{1});

for vi = 1:length(data)
    hash_values{vi} = [];
end
c=0:psi+1:(n-1)*(psi+1);

for i = 1:t
    % sampling    
    CurtIndex = datasample(1:sn, psi, 'Replace', false);

    for vi = 1:length(data)

        Ndata = data{vi}(CurtIndex,:);
        [D,~] = pdist2(Ndata,Ndata,'minkowski',2,'Smallest',2);   
        R=D(2,:);  % radius
        
        % identify kNN ball for each point    
        [D,I] = pdist2(Ndata,data{vi},'minkowski',2,'Smallest',k);
        I(D>R(I))=psi+1; % outside ball
        
        z=zeros(psi+1,n);
        z(I+c)=1;  
        hash_values{vi}=[hash_values{vi} (z)'];   

    end
end
end