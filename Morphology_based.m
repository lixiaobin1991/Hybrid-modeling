%3D Image Mathematical Morphological Processing
%4 functions, namely dilate3d, erode3d, strel3d, find3d
%Import 3D data before running the program
%clc
t1=clock;                    %Program run start time
%Import Image (3D)
im=voxel1;                   %Initial model
%The skeleton is 1, and s is added after the name
%im=imfill(im,'holes');      %Unconnected pore filling
[L,M,N]=size(im);            %Image size

%Structural element size can be set in strel3d
n1=5;n2=5;
n3=3*n1+5*n1*n2;
disp(['Total:',num2str(n3),'models']);%The calculation progress
for ii=1:n1
    t2=clock;                %Cycle start time  
    disp(['Starting number',num2str(ii),'cycle']);%Look at the calculation progress
    %Save the data
    name1=ii;name3=10;       
    name4=100*ii+name3;
    
    %Four basic operations
    im1=dilate3d(im,ii);      %Dilation to achieve cementation - uniformity
    im2=erode3d(im,ii);       %Corrosion to achieve solution-uniformity
    %im3=dilate3d(im2,ii);     %Opening operation
    im4=erode3d(im1,ii);      %Close operation to achieve cementation - throat
    save(['disu000',num2str(name4),'.mat'],'im2');%These do not require determining the size of the throat position
    save(['cemu000',num2str(name4),'.mat'],'im1');
    save(['cemt000',num2str(name4),'.mat'],'im4');
    
    %Dissolving - Throat, throat evenly dissolving
    B=im4-im;                
    for ii1=1:n2
        B1=dilate3d(B,ii1);  %Uniform expansion of throat position
        B5=im-B1;
        for i=1:L
            for j=1:M
                for k=1:N
                    if B5(i,j,k)==-1;
                        B5(i,j,k)=0;%Final model
                    end
                end
            end
        end
        name4=100*ii1+name3;
        save(['dist0',num2str(name1),'0',num2str(name4),'.mat'],'B5');
    end
    
    %Dissolution - pore, uniform dissolution at pore location
    for ii1=1:n2
        C=erode3d(im4,ii1);
        C5=zeros(L,M,N);
        for i=1:L
            for j=1:M
                for k=1:N
                    if im(i,j,k)==1 && C(i,j,k)==1;
                        C5(i,j,k)=1;%Final model
                    end 
                end
            end
        end
        name4=100*ii1+name3;
        save(['disp0',num2str(name1),'0',num2str(name4),'.mat'],'C5');
    end
    
    %Cementation - throat, the position of small throat is preferred to cementation
    D=im4-im;                
    for ii1=1:n2
        D1=dilate3d(D,ii1); 
        D5=zeros(L,M,N);
        for i=1:L
            for j=1:M
                for k=1:N
                    if im(i,j,k)==1 || D1(i,j,k)==1;
                        D5(i,j,k)=1;%Final model
                    end
                end
            end
        end
        name4=100*ii1+name3;
        save(['cemtt0',num2str(name1),'0',num2str(name4),'.mat'],'D5');
    end
    
    %Cementation - pore, pore position is uniform cementation
    E=1-im4;
    for ii1=1:n2
        E1=erode3d(E,ii1);
        E2=E-E1;
        E3=zeros(L,M,N);
        for i=1:L
            for j=1:M
                for k=1:N
                    if im(i,j,k)==1 || E2(i,j,k)==1;
                        E3(i,j,k)=1;
                    end    
                end
            end
        end
        E4=erode3d(E3,ii1);  %corrosion
        E5=dilate3d(E4,ii1); %Final model
        name4=100*ii1+name3;
        save(['cemp0',num2str(name1),'0',num2str(name4),'.mat'],'E5');
    
        E6=zeros(L,M,N);
        for i=1:L
            for j=1:M
                for k=1:N
                    if im(i,j,k)==1 || E5(i,j,k)==1;
                        E6(i,j,k)=1;%Final result
                    end
                end
            end
        end
        name4=100*ii1+name3;
        save(['cempp0',num2str(name1),'0',num2str(name4),'.mat'],'E6');
    end
    t3=clock;
    Time=etime(t3,t2)/60;    %Program cycle time
    disp(['Time_min = ',num2str(Time)]);
end
t4=clock;                    %Program end time
Time=etime(t4,t1)/60;        %Total program running time
disp(['Time_min = ',num2str(Time)]);

