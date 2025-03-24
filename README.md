# GNSS satellite visibility simulation from Google Earth
- This project generates virtual fisheye zenith images from Google Earth at arbitrary locations and automatically determines GNSS visibility
- This can be used to evaluate GNSS multipath in urban areas and as a reference for LOS/NLOS satellites

<img width="600" src="https://github.com/taroz/Misc/blob/master/data/ge-gnss-visibility/static.png?raw=true">

<img width="600" src="https://github.com/taroz/Misc/blob/master/data/ge-gnss-visibility/fisheye_merge.gif?raw=true">

# Vehicle Driving Data
- Virtual fisheye video generated from GNSS data mounted on the vehicle included in the dataset

Virtual fisheye image

https://github.com/user-attachments/assets/2763cd03-9e3a-4305-b6f8-2b7850cdd04a

Virtual fisheye image with GNSS satellites

https://github.com/user-attachments/assets/844e4be2-c8af-4471-b917-f9183cc6178c

Virtual fisheye image with LOS/NLOS determination

https://github.com/user-attachments/assets/1669d099-7bd0-4dbc-af50-b5861e4ec837

# Requirements
- MATLAB (>R2022a)
  - Image Processing Toolbox (for satellite_visibility_xxx.m) 
- [Google Earth Pro](https://www.google.com/earth/about/versions/#earth-pro)
- [MatRTKLIB](https://github.com/taroz/MatRTKLIB)

# How to use
## Setup
- Install [Google Earth Pro](https://www.google.com/earth/about/versions/#earth-pro)
- Clone or download [MatRTKLIB](https://github.com/taroz/MatRTKLIB) and add to path in MATLAB
- Clone or download **ge-gnss-visibility**

## Fisheye Image Generation
### 1. Run `generate_kml_kinematic.m` or `generate_kml_static.m`
- `ge_fov160.kml` is generated

### 2. Open `ge_fov160.kml` in Google Earth Pro
- Check `Photorealistic` and `Terrain` in Layers
- **Note: To start Movie Maker, you must exit the tour mode. Please press the X button on the slider in the lower left to exit tour mode.**

<img width="600" src="https://github.com/taroz/Misc/blob/master/data/ge-gnss-visibility/cap1.jpg?raw=true">

### 3. Tools->Movie Maker
- Select tour `fisheye_fov160`
- Enter the name of the file to save to
- Video parameter: `Custom`
- Picture size: `1200 x 1200`
- Frames per second: `1.0`
- Output configuration
  - For kinematic data: `MJPEG (.mov)`
  - For static data: `JPEG image sequence (.jpg)`

![](https://github.com/taroz/Misc/blob/master/data/ge-gnss-visibility/cap2.jpg?raw=true) 

### 4. Click `Create Movie`
- Usually this process takes quite a while!
  - In my experience, running Google Earth in a Linux (Ubuntu) environment is much faster than running it in Windows
  - On Windows, it is faster to use OpenGL instead of DirectX as the graphics mode for Google Earth
  - The type of graphics card you have can also affect performance

![](https://github.com/taroz/Misc/blob/master/data/ge-gnss-visibility/cap3.jpg?raw=true) 

### 5. Run `satellite_visibility_kinematic.m` or `satellite_visibility_static.m`
- Virtual fisheye image/movie is generated

# Citation
If you use this project in your research or paper, please cite the following article \[[link](https://github.com/taroz/Misc/blob/master/data/ge-gnss-visibility/IONPNT2015.pdf?raw=true)\].
```
@inproceedings{suzuki2015simulation,
  title={Simulation of GNSS satellite availability in urban environments using Google Earth},
  author={Suzuki, Taro and Kubo, Nobuaki},
  booktitle={Proceedings of the ION 2015 Pacific PNT Meeting},
  pages={1069--1079},
  year={2015}
}
```
