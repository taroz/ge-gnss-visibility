%% generate_kml_static.m
% Generate KML file to capture images from Google Earth in static dataset
% Author: Taro Suzuki

clear; close all; clc;

addpath ./functions
datapath = "./data/static/";

%% Reference position
llh = [35.667387 139.791677 2.0]; % camera position
pos = gt.Gpos(llh,"llh");

% camera heading (degree), north is up when heading is zero
head = 0; % for static data, set to zero

%% Generate KML tour
% field of view (degree), 160 degrees corresponds to an elevation angle of 10-90 degrees
fov = 160;

% generate KML file
write_kml_tour(datapath+"ge_fov"+string(fov)+".kml",...
    pos.lat,...
    pos.lon,...
    pos.orthometric,... % input orthometric height, not ellipsoid height
    head, ...
    fov);