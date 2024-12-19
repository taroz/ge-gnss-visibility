function [px, py, inidx] = proj_fisheye(az, el, camera, scale)
% mask_fisheye: Computes obstacle areas from fisheye image
%    mask = mask_fisheye(imin, fov, camera, diff_th, r)
%
% Inputs:
%    az     : Nx1, Azimuth angle of input points (North direction is zero)
%    el     : Nx1, Elevation angle of imput points
%    camera : 1x1, Fisheye camera struct defined fishcam.xml
%    scale  : 1x1, Output image scale, Default: 1.0
%
% Outputs:
%    px     : Mx1, X in image coordinate (Zero is top left of image)
%    py     : Mx1, Y in image coordinate (Zero is top left of image)
%    inidx  : Mx1, Index of input points projected inside the image
%
% Author:
%    Taro Suzuki
%
arguments
    az
    el
    camera
    scale double = 1.0
end

% Convert elevation angle to distance from image center
p = polyfit(str2num(camera.el), str2num(camera.r), camera.degree);
r = scale*polyval(p, el); % distance from image center (pixcel)

% Convert to image coordinate
mx = r.*cosd(-az+90) + scale*camera.xc;
my = scale*camera.hight - (r.*sind(-az+90) + scale*camera.yc);

% Check inside of image or not
inidx = find(mx>=0 & mx<scale*camera.width & my>=0 & my<scale*camera.hight);
px = mx(inidx);
py = my(inidx);
