function rs=size_distribution3(num,typeN,r_min,step)
rs=ones(num,1); 
for i=1:typeN:num             % Evenly distribute the sphere radius 
    Rnow=r_min;
    for j=i:i+typeN-1
        rs(j)=Rnow;
        Rnow=Rnow+step;
    end        
end
end