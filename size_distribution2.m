%%%%%Calculate the actual particle diameter and size to generate a particle size distribution curve%%%%%%
    %r is the actual particle diameter, m is the total number of particles corresponding to different particle sizes%
function rs=size_distribution2(n) 
%r=[ 10 25 50 70 80 90 105 110 120 140 148 150 160 170 180 185 215 235 250 265 270 280 290 325 365 385 420 450 480 515 555 580 635 675 730 760 810 845 895 930 975 ];
%m=[ 1 3 7 13 17 20 25 29 34 41 45 48 53 59 62 65 67 65 62 58 55 49 44 39 35 32 27 26 23 18 15 12 9 8 7 7 6 4 3 2 1 ];
%r=[ 10 25 50 70 80 90 105 110 120 140 148 150 160 170 180 195 215 235 250 265 270 280 290 325 365 385 420 450 480 ];
%m=[ 1 3 7 13 17 20 25 29 34 41 45 48 50 47 45 42 37 34 29 26 23 18 14 10  8 6  4 3  1 ];
r=60:5:210;
m=[1 1 3 5 15 30 48 60 70 80 101 118 128 150 155 160 158 148 126 112 98 87 70 55 30 20 13 5 3 2 1];
z=size(r,2);
totalm=sum(m); %Total number of particles
P=m/totalm;    %Percentage of each particle
Q=cumsum(P);   %Cumulative percentage of various particles

rs=zeros(1,n);
for i=1:n
    p=rand;
    if p<=Q(1)
        rs(i)=r(1);
    else
        for k=2:z
            if p>Q(k-1)&&p<=Q(k)
                rs(i)=r(k);
            end
        end
    end  
end
%p2=P*100;
%q2=Q*100;

%Draw a graph of particle size distribution 
% fig;    %Particle size distribution curve
% plot(r,p2,'ok','MarkerFaceColor','k')  %,LineWidth',2,'MarkerSize',10);
% hold on
% plot(r,p2,'-r','LineWidth',2,'MarkerSize',10);
% axis([0,1000,0,6]);
% title('Particle size distribution curve','FontSize',12,'FontWeight','Bold')
% xlabel('Particle diameter/¦Ìm','FontSize',12) %'FontWeight','Bold')
% ylabel('Volume percentage%','FontSize',12) %'FontWeight','Bold') 
% 
% fig;  %Distribution probability curve of particle size composition
% plot(r,q2,'ok','MarkerFaceColor','k') ;
% hold on
% plot(r,q2,'-r','LineWidth',2,'MarkerSize',10);
% axis([0,1000,0,100]);
% title('Cumulative distribution curve of particle size composition','FontSize',12,'FontWeight','Bold')
% xlabel('Particle diameter/¦Ìm','FontSize',12) %'FontWeight','Bold')
% ylabel('Cumulative volume percentage%','FontSize',12) %,'FontWeight','Bold') 

end