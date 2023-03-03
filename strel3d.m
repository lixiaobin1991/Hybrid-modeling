%% Generate 3D Spherical Structural Elements
function [se,n,rx,ry,rz] = strel3d(r)

% Determine the user input radius
if length(r)<2
    rx = r;
    ry = r;
    rz = r;
elseif length(r)>2
    rx = r(1);
    ry = r(2);
    rz = r(3);
else
    rx = r(1);
    ry = r(1);
    rz = r(2);
end

% Generate spherical binary image and get target index
[x,y,z] = meshgrid(-rx:rx,-ry:ry,-rz:rz);
[x,y,z] = find3d(sqrt(x.^2+y.^2+z.^2)<(r/1.6)); % עPay attention to the judgment method here
se = [x-rx-1,y-ry-1,z-rz-1];

n = size(se,1);

end