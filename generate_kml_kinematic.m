%% generate_kml_kinematic.m
% Generate KML file to capture images from Google Earth in kinematic dataset
% Author: Taro Suzuki

clear; close all; clc;

addpath ./functions
datapath = "./data/kinematic/";

%% Reference position of vehicle
ref = readmatrix(datapath+"reference.csv");

% camera position
pos = gt.Gpos(ref(:,3:5),"llh");
pos.plotMap

% camera heading (degree), north direction is zero
heading = ref(:,11);

%% Generate KML tour
% field of view (degree), 160 degrees corresponds to an elevation angle of 10-90 degrees
fov = 160;

% generate KML file
write_kml_tour(datapath+"ge_fov"+string(fov)+".kml",...
    pos.lat,...
    pos.lon,...
    pos.orthometric,... % input orthometric height, not ellipsoid height
    heading, ...
    fov,...
    1.0); % time interval (s)