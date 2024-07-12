%% satellite_visibility_kinematic.m
% Fisheye images are generated from Google Earth captured images and 
% satellite visibility is determined with the kemetaic dataset
% Author: Taro Suzuki

clear; close all; clc;

addpath ./functions
datapath = "./data/kinematic/";

%% Read data
gefile = "ge_fov160.mov"; % input capture file from Google Earth
fov = 160; % field of view (degree)
camera = readstruct("fishcam.xml"); % fisheye camera model
obs = gt.Gobs(datapath+"rover.obs"); % RINEX observation
nav = gt.Gnav(datapath+"rover.nav"); % RINEX navigation

ref = readmatrix(datapath+"reference.csv"); % vehicle reference trajectory
pos = gt.Gpos(ref(:,3:5),"llh"); % camera position
head = ref(:,11); % caemra heading (degree)

imopensky = imread("fisheye_opensky.png"); % opensky fisheye image

CNR_mask = 35; % CNR mask for plot satellite (dB-Hz)
obs.mask(obs.L1.S<CNR_mask); % CNR mask
col = double(gt.C.SYSCOL); % colormap for plot
pos.plotMap % plot trajectory

%% Compute satellite position
sat = gt.Gsat(obs,nav);
sat.setRcvPos(pos); % set camera position
sat.plotSky % plot satellite constellation

%% Generate fisheye image
v = VideoReader(datapath+gefile); % read captured image from video

f = figure;
f.Position(3:4) = [600 600];
set(gca,'Position',get(gca,'OuterPosition'));

for i=1:v.NumFrames
    if i==1; gifappend = false; else; gifappend = true; end % GIF setting
    
    %% convert to fisheye image
    im = readFrame(v);
    imfish = im2fisheye(im,fov,camera);

    %% plot fisheye image
    hold off
    image(imfish);
    hold on;
    
    % show current time on image
    timestr = string(obs.time.t(i)).split((" "));
    text(10,550,timestr(1),"FontSize",20,"Color","w","Fontname","Consolas","FontWeight","bold")
    text(20,575,timestr(2),"FontSize",20,"Color","w","Fontname","Consolas","FontWeight","bold")
    
    % save to GIf
    exportgraphics(gcf,datapath+"fisheye.gif","Append",gifappend,"Resolution",96); % 96dpi

    %% plot satellite position
    % compute satellite position on fisheye image
    [px, py, inidx] = proj_fisheye(sat.az(i,:)-head(i), sat.el(i,:), camera);

    % plot satellite
    clear obj
    for j=1:length(inidx)
        c = col(obs.sys(inidx(j)),:); % marker color
        obj(j) = plot(px(j),py(j),'o','MarkerSize',14,'linewidth',2.5,'color',c);
        plot(px(j),py(j),'.','MarkerSize',14,'linewidth',2.5,'color',c);
        text(px(j)+5,py(j)+5,obs.satstr(inidx(j)),'HorizontalAlignment','left','VerticalAlignment','top','FontSize',12,'color',c,'Fontname','Consolas');
    end
    % show number of satellite system
    sys = obs.sys(inidx);
    text(502,460,"  G:"+num2str(nnz(sys==gt.C.SYS_GPS)),"FontSize",20,"Color",col(gt.C.SYS_GPS,:),"Fontname","Consolas","FontWeight","bold");
    text(502,482,"  R:"+num2str(nnz(sys==gt.C.SYS_GLO)),"FontSize",20,"Color",col(gt.C.SYS_GLO,:),"Fontname","Consolas","FontWeight","bold");
    text(502,506,"  E:"+num2str(nnz(sys==gt.C.SYS_GAL)),"FontSize",20,"Color",col(gt.C.SYS_GAL,:),"Fontname","Consolas","FontWeight","bold");
    text(502,529,"  C:"+num2str(nnz(sys==gt.C.SYS_CMP)),"FontSize",20,"Color",col(gt.C.SYS_CMP,:),"Fontname","Consolas","FontWeight","bold");
    text(502,552,"  Q:"+num2str(nnz(sys==gt.C.SYS_QZS)),"FontSize",20,"Color",col(gt.C.SYS_QZS,:),"Fontname","Consolas","FontWeight","bold");
    text(502,575,"ALL:"+num2str(length(sys)),"FontSize",20,"Color","w","Fontname","Consolas","FontWeight","bold");

    % save to GIf
    exportgraphics(gcf,datapath+"fisheye_satellite.gif","Append",gifappend,"Resolution",96); % 96dpi

    %% plot LOS/NLOS satellite
    % compute obstacle mask
    immask = mask_fisheye(imfish, imopensky);

    % show obstacle mask
    oim = image(255*immask);
    oim.AlphaData = 0.2;

    % determine satellite visibility
    idx = sub2ind(size(immask),round(py),round(px));
    nlos = immask(idx);

    % change satellite marker if NLOS
    set(obj(nlos),"Marker","x");

    % save to GIf
    exportgraphics(gcf,datapath+"fisheye_satellite_nlos.gif","Append",gifappend,"Resolution",96); % 96dpi
end
