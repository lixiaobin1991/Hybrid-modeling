%Process-based digital core modeling%
%The lowest surface deposition, deposition resolution can be set%
%After the program runs, it is recommended to save the workspace data T%
clc;
clear;
t1=clock;                    %Program start time
%Basic parameter setting
num=1500;                       %Total number of grains to be deposited
a=2000;                       %Side length of deposition box
c=2000;                      %Deposition box height
pre=a/500;                   %Three-dimensional space division accuracy
cpa=0;                       %Compaction factor
%Selection of deposited grain radius
%rs=size_distribution1(num,40);   %Random selection of particle radius with equal probability
%rs=(size_distribution1(num,40,35,30,25,20,15,10,5))';%Use transposition for more than 2 kinds of particles
rs=(size_distribution2(num)./2)';%Select the particle size from the particle size distribution curve
typeN=2;                     %Number of types
r_min=95;                    %Minimum radius
step=5;                      %Ball change step
%rs=size_distribution3(num,typeN,r_min,step);%Evenly distribute the sphere radius

zs=zeros(num,1);
x=ones(num,1);
y=ones(num,1);
z=ones(num,1);
r=ones(num,1);

%Draw the first particle
t=linspace(0,pi,50); 
p=linspace(0,2*pi,50); 
[theta,phi]=meshgrid(t,p); 
X=unifrnd(rs(1),a-rs(1));    %Randomly land at x position
Y=unifrnd(rs(1),a-rs(1));    %Randomly land at y position
xx0=rs(1)*sin(theta).*sin(phi)+X;      
yy0=rs(1)*sin(theta).*cos(phi)+Y;
zz0=rs(1)*cos(theta)+rs(1)*(1-cpa); 
%fig;
surf(xx0,yy0,zz0);           %Draw the first deposited particle
shading interp
hidden off 
light
colormap([0,0.4,0.4]);
disp(0);
%axis([0,a,0,a,0,c]);        %Keep the coordinates displayed in proportion
%axis square;
%pause(0.05);                %The program pauses for 0.05 seconds and the result can be displayed

x(1)=X;y(1)=Y;z(1)=rs(1);r(1)=rs(1);
N=1;
hold on

%Draw the second particle
for i=1:1:N
    r(i)=r(i)+rs(2);
end
H=floor((a-2*rs(2))/pre)+1;  %Round down, the number of divisions of the three-dimensional coordinate grid
A=zeros(H);                  %Generate a zero matrix with H rows and H columns
p=1;    
for m=rs(2):pre:(a-rs(2))    %X coordinate value division
    q=1;
    for n=rs(2):pre:(a-rs(2))%Y coordinate value division
        j=1;
        for i=1:N       
            if (m-x(i))^2+(n-y(i))^2<=r(i)^2    %Areas that can collide with deposited particles
                zs(j)=z(i)+sqrt(r(i).^2-(m-x(i)).^2-(n-y(i)).^2); 
            else
                zs(j)=0;     %No collision
            end
            j=j+1;
        end
        A(p,q)=max(zs);      %Find the deposition position with the highest equilibrium position to avoid collisions with deposited particles
        q=q+1;
    end
    p=p+1;
end
   
min=A(1,1);row=1;col=1;
 
%Find the lowest gravitational potential energy deposition location that satisfies the particle balance
for k=1:(a-2*rs(2))/pre+1       %Represents the x-coordinate value
    for m=1:(a-2*rs(2))/pre+1   %Represents the y-coordinate value
        if A(k,m)<min
            min=A(k,m);
            row=k;
            col=m;
        end
    end
end
                
disp(min);
xs=(row-1)*pre+rs(2);
ys=(col-1)*pre+rs(2);
xx1=rs(2).*sin(theta).*sin(phi)+xs; 
yy1=rs(2).*sin(theta).*cos(phi)+ys;
zz1=(rs(2).*cos(theta)+rs(2)*(1-cpa)); 
surf(xx1,yy1,zz1); 
shading interp
hidden off 
light
colormap([0,0.4,0.4]);
hold on
%pause(0.05);

x(2)=xs;y(2)=ys;z(2)=rs(2);r(2)=rs(2);
N=N+1;                       %N particles have been deposited, where N is 2 
    
%Draw the remaining particles 
for t=3:1:num                %t represents particles that are about to be deposited, and N represents particles that have been deposited before
    %disp(t);                %Number of deposited particles
    for i=1:1:N-1
        r(i)=r(i)+rs(t)-rs(t-1);
    end
    r(N)=r(N)+rs(t);
    H=floor((a-2*rs(t))/pre)+1;
    A=zeros(H); 
    p=1;
    for m=rs(t):pre:(a-rs(t))
        q=1;
        for n=rs(t):pre:(a-rs(t))
            j=1;
            for i=1:N       
                if (m-x(i))^2+(n-y(i))^2<=r(i)^2  % r(i)=r(i)+rs(t)-rs(t-1);
                    zs(j)=z(i)+sqrt(r(i).^2-(m-x(i)).^2-(n-y(i)).^2);
                else
                    zs(j)=0;
                end
                j=j+1;
            end
            A(p,q)=max(zs);
            q=q+1;
        end
        p=p+1;
    end
    min=A(1,1);row=1;col=1;
    for k=1:(a-2*rs(t))/pre+1
        for m=1:(a-2*rs(t))/pre+1
            if A(k,m)<min
                min=A(k,m);
                row=k;
                col=m;
            end
        end
    end
    disp(min);
    if min==0                %The particles land on the first layer
        xs=(row-1)*pre+rs(t);
        ys=(col-1)*pre+rs(t);
        xxN=rs(t).*sin(theta).*sin(phi)+xs; 
        yyN=rs(t).*sin(theta).*cos(phi)+ys;
        zzN=(rs(t).*cos(theta)+rs(t)*(1-cpa));   
        surf(xxN,yyN,zzN); 
        shading interp
        hidden off 
        light
        colormap([0,0.4,0.4]);
        hold on
        %pause(0.05);
        x(N+1)=xs;y(N+1)=ys;z(N+1)=rs(t);r(N+1)=rs(t);
    else                     %The particles land on the surface of the deposited particles
        xs=(row-1)*pre+rs(t);
        ys=(col-1)*pre+rs(t);
        x(N+1)=xs;y(N+1)=ys;z(N+1)=min;r(N+1)=rs(t);
        if   ((z(N+1)+r(N+1))> (c*1.1)  || (z(N+1)-r(N+1))>c) && ((z(N)+rs(N))> (c*1.1)  || (z(N)-rs(N))>c)    %ÅÐ¶Ï¿ÅÁ£ÊÇ·ñÒç³ö
            break;
        end
        %Show deposited particles
        xxN=rs(t).*sin(theta).*sin(phi)+xs;
        yyN=rs(t).*sin(theta).*cos(phi)+ys;
        zzN=rs(t).*cos(theta)+min*(1-cpa);   
        surf(xxN,yyN,zzN); 
        shading interp
        hidden off 
        light
        colormap([0,0.4,0.4]);
        hold on
        %pause(0.05);  
    end
    N=N+1;
end 
axis([0,a,0,a,0,c]);         %Keep the coordinates displayed in proportion
axis square;
x1=x(1:N,1);y1=y(1:N,1);z1=z(1:N,1);r1=rs(1:N,1);
a1=ones(N,1);a1=a1*a;c1=ones(N,1);c1=c1*c;
T=[x1,y1,z1,r1,a1,c1];
save Grain data.txt T -ascii
 
t2=clock;                    %Program end time
Time_min=etime(t2,t1)/60;    %Total program running time
disp(['Time_min = ',num2str(Time_min)]);
