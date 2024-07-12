function write_kml_tour(file, lat, lon, alt, heading, fov, dt)
% write_kml_tour: Generate KML tour file for virtual fisheye image generation
%    write_kml_tour(file, lat, lon, alt, heading, fov, dt)
%
% Inputs:
%    file    : Output KML file namte
%    lat     : Nx1, Latitude of camera position (degree)
%    lon     : Nx1, Longitude of camera position (degree)
%    alt     : Nx1, Orthometric height (m) (NOT ellipsoid height)
%    heading : Nx1, Camera heading (degree), North direction is zero
%    fov     : 1x1, Field of view (degree), Default: 160 (elevation: 10-90 degree)
%    dt      : 1x1, Time interval (second), Default: 1 second
%
% Author:
%    Taro Suzuki
%
arguments
    file (1,:) char
    lat (:,1) double
    lon (:,1) double
    alt (:,1) double
    heading (:,1) double
    fov (1,1) = 160 % field of view
    dt double = 1.0 % time interval
end
%% Generate KML tour
fid = fopen(file,'w');

fprintf(fid,'<?xml version="1.0" encoding="UTF-8"?>\n');
fprintf(fid,'<kml xmlns="http://www.opengis.net/kml/2.2"\n');
fprintf(fid,'  xmlns:gx="http://www.google.com/kml/ext/2.2">\n');
fprintf(fid,'  <gx:Tour>\n');
fprintf(fid,'    <name>fisheye_%d</name>\n',fov);
fprintf(fid,'    <gx:Playlist>\n');

for i=1:length(lat)
    if i==1
        write_flyto(fid,lat(i),lon(i),alt(i),heading(i),fov,0); % first location
    else
        write_flyto(fid,lat(i),lon(i),alt(i),heading(i),fov,dt);
    end
end

fprintf(fid,'    </gx:Playlist>\n');
fprintf(fid,'  </gx:Tour>\n');
fprintf(fid,'</kml>\n');

fclose(fid);
end

%% Generate <gx:Flyto>
function write_flyto(fid,lat,lon,alt,heading,fov,dt)
fprintf(fid,'      <gx:FlyTo>\n');
fprintf(fid,'        <gx:duration>%f</gx:duration>\n',dt);
fprintf(fid,'        <gx:flyToMode>smooth</gx:flyToMode>\n');
fprintf(fid,'        <Camera>\n');
fprintf(fid,'          <longitude>%f</longitude>\n',lon);
fprintf(fid,'          <latitude>%f</latitude>\n',lat);
fprintf(fid,'          <altitude>%f</altitude>\n',alt);
fprintf(fid,'          <heading>%f</heading>\n',wrapTo360(heading+180)); % north is up when heading is zero
fprintf(fid,'          <tilt>180</tilt>\n'); % zenith direction
fprintf(fid,'          <roll>0</roll>\n');
fprintf(fid,'          <altitudeMode>absolute</altitudeMode>\n');
fprintf(fid,'          <gx:horizFov>%f</gx:horizFov>\n',fov);
fprintf(fid,'        </Camera>\n');
fprintf(fid,'      </gx:FlyTo>\n');
end