function ango = wrapTo360(angi)
%% Implementation of wrapTo360 without the Mapping Toolbox
% Author: Taro Suzuki

ango = mod(angi,360);