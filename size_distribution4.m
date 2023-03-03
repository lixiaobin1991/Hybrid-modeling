function rs=size_distribution4(num)
r=[40 35 30 25 25 25 20];
k=size(r,2);
rs=ones(num,1); 
m=0;
for i=1:k:num
    for j=i:i+k-1
        rs(j)=r(j-k*m);  
    end
    m=m+1;
end
end