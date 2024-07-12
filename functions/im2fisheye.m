function imfish = im2fisheye(imin, fov, camera)
% im2fisheye: Convert pinhole camera image to fisheye camera image
%    imout = im2fisheye(imin, fov, camera)
%
% Inputs:
%    imin   : MxMx3, Input pinhole camera image
%    fov    : 1x1, Field of view of input image (degree)
%    camera : 1x1, Fisheye camera struct defined fishcam.xml
%
% Outputs:
%    imfish : (camera.hight)x(camera.width)x3, Output fisheye camera image
%
% Author:
%    Taro Suzuki
%
arguments
    imin (:,:,3)
    fov (1,1) double
    camera struct
end

imin = imresize(imin,2,"nearest");
[m,n,~] = size(imin);
if m~=n
    error("The height and width of the input image must be the same");
end
imrout = zeros(camera.hight,camera.width,"uint8"); % R
imgout = zeros(camera.hight,camera.width,"uint8"); % G
imbout = zeros(camera.hight,camera.width,"uint8"); % B

[x,y] = meshgrid(1:n,1:n);
x = x-n/2;
y = y-n/2;
r = sqrt(x.^2+y.^2);

f = n/2/tan(deg2rad(fov/2)); % pixel
el = 90-atand(r/f);  % elevation angle (degree)
az = atan2d(y,x)+90; % azimuth angle (degree)

% Convert to fisheye camera image
[px, py] = proj_fisheye(az, el, camera);

ind = sub2ind(size(imrout),ceil(py(:)),ceil(px(:)));
imrout(ind) = imin(:,:,1); % R
imgout(ind) = imin(:,:,2); % G
imbout(ind) = imin(:,:,3); % B

imfish = cat(3,imrout,imgout,imbout);
imfish = fliplr(imfish); % east to the right, west to the left