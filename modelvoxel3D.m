%Digitization of 3D model%
%Import T %Save voxel1 after the program runs
%clc;
t1=clock;                    %Start time
%data import
[N,M]=size(T);
a1=T(1,5);c1=T(1,6);
x1=T(:,1);y1=T(:,2);z1=T(:,3);r1=T(:,4);

%Parameter setting
width=1600;                   %The size of the intercepted area cannot be greater than a1
pointnum=200;                %size
acu=width/pointnum*2^(1/2)/2;%Skeleton thickness
cpa=0;                       %Compaction factor
cemt=0;                      %Growth factor
z1=z1*(1-cpa);
r1=r1*(1+cemt);

[xx,yy,zz]=meshgrid(linspace(a1/2-width/2,a1/2+width/2,pointnum),linspace(a1/2-width/2,a1/2+width/2,pointnum),linspace(c1/2-width/2,c1/2+width/2,pointnum));
voxel1=zeros(size(xx));      %Granular entity voxels, matrix allocation memory, array all 0,
%voxel2=zeros(size(xx));     
voxel3=zeros(size(xx));      

%Find the voxel in the deposited grain
for m1=1:N
    nnn1=find((xx-x1(m1)).^2+(yy-y1(m1)).^2+(zz-z1(m1)).^2<=r1(m1)^2);   %Find the voxel space position in the ball
    voxel1(nnn1)=1;          %The pixel in the sphere is 1
end

%Find out the pores
voxel2=1-voxel1;

%Find the skeleton
%for m2=1:N
%    nnn2=find(((xx-x1(m2)).^2+(yy-y1(m2)).^2+(zz-z1(m2)).^2<=(r1(m2)^2+acu))&((xx-x1(m2)).^2+(yy-y1(m2)).^2+(zz-z1(m2)).^2>=(r1(m2)^2-acu)));   %寻找位于球体颗粒表面的体素空间位置
%    voxel3(nnn2)=1;
%end

t2=clock ;                   %Program end time
Time_min=etime(t2,t1)/60;    %Total program running time
disp(['Time_min = ',num2str(Time_min)]);
