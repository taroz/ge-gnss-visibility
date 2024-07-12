function mask = mask_fisheye(imfish, imopensky, diff_th, r)
% mask_fisheye: Computes obstacle areas from fisheye image
%    mask = mask_fisheye(imin, fov, camera, diff_th, r)
%
% Inputs:
%    imfish    : MxMx3, Input fisheye camera image
%    imopensky : MxMx3, Opensky fisheye camera image
%    diff_th   : 1x1, Threshold of difference from open sky image to extract mask, Default: 20
%    r         : 1x1, Radius to remove mask noise, Default: 3
%
% Outputs:
%    mask   : MxM, Obstacle area mask
%
% Author:
%    Taro Suzuki
%
arguments
    imfish
    imopensky
    diff_th = 25
    r = 3
end

% Compute difference between opensky image
imdiff = sum(abs(double(imfish)-double(imopensky)),3);

% Extract obstacle mask
mask = imdiff>diff_th;

% Remove small mask areas
se = strel("disk",r);
mask = ~imopen(~mask,se);
mask = imopen(mask,se);
