function rs=size_distribution1(num,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10)
if nargin==2
    r2=0;r3=0;r4=0;r5=0;r6=0;r7=0;r8=0;r9=0;r10=0;
    rs=r1.*ones(num,1);
elseif nargin==3
    r3=0;r4=0;r5=0;r6=0;r7=0;r8=0;r9=0;r10=0;
    rr=[r1,r2];
    rs=rr(ceil(2*rand(num,1)));
elseif nargin==4
    r4=0;r5=0;r6=0;r7=0;r8=0;r9=0;r10=0;
    rr=[r1,r2,r3];
    rs=rr(ceil(3*rand(num,1)));
elseif nargin==5
    r5=0;r6=0;r7=0;r8=0;r9=0;r10=0;
    rr=[r1,r2,r3,r4];
    rs=rr(ceil(4*rand(num,1)));
elseif nargin==6
    r6=0;r7=0;r8=0;r9=0;r10=0;
    rr=[r1,r2,r3,r4,r5];
    rs=rr(ceil(5*rand(num,1)));
elseif nargin==7
    r7=0;r8=0;r9=0;r10=0;
    rr=[r1,r2,r3,r4,r5,r6];
    rs=rr(ceil(6*rand(num,1)));
elseif nargin==8
    r8=0;r9=0;r10=0;
    rr=[r1,r2,r3,r4,r5,r6,r7];
    rs=rr(ceil(7*rand(num,1)));
elseif nargin==9
    r9=0;r10=0;
    rr=[r1,r2,r3,r4,r5,r6,r7,r8];
    rs=rr(ceil(8*rand(num,1)));
elseif nargin==10
    r10=0;
    rr=[r1,r2,r3,r4,r5,r6,r7,r8,r9];
    rs=rr(ceil(9*rand(num,1)));
elseif nargin==11
    rr=[r1,r2,r3,r4,r5,r6,r7,r8,r9,r10];
    rs=rr(ceil(10*rand(num,1)));
else
    error('Insufficient input parameters to calculate.');
end
end
    