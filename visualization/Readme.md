# FlightGear Setup and Usage Guide

## Introduction
This guide will help you download and install FlightGear, a free and open-source flight simulator. To run the visualization,
1. Run`runVisualization.m`
2. Press play in Simulink

## Download and Install FlightGear

### Windows
1. Go to the [FlightGear download page](https://www.flightgear.org/download/).
2. Download the Windows installer.
3. Run the installer and follow the on-screen instructions. You may have to specify the path to the application's data folder the first time you run the program. This path will probably be in `C:\Program Files\FlightGear 2020.3\data`.
4. Verify the installation location of the binary is `C:\Program Files\FlightGear 2020.3\bin\fgfs.exe`.

### macOS
1. Go to the [FlightGear download page](https://www.flightgear.org/download/).
2. Download the macOS disk image.
3. Open the disk image and drag the FlightGear application to your Applications folder.
4. Verify the installation location of the binary is `/Applications/FlightGear.app/Contents/MacOS/fgfs`.

### Linux
1. Open a terminal.
2. Install FlightGear using your package manager. For example, on Ubuntu:
```sh
sudo apt-get update
sudo apt-get install flightgear
```

3. Verify the installation location of the binary is `/usr/bin/fgfs`.

## Adding the FlightGear F-16 Visualization
1. Launch Flightgear
2. Go to Aircraft from the main menu on the left
3. Click "Browse" on the top menu
4. Click "Add default hangar" if not added already
5. Click F-16
6. Click "Install"

## Running FlightGear with MATLAB Script

The `runFlightGear.m` script will launch FlightGear with specific options. Ensure the installation path in the script matches your system's installation path.

### Script Breakdown
- **Initial Conditions**: Set the initial latitude, longitude, and altitude of the aircraft.
- **Frame Rate**: Set the frame rate for the simulation. (frame rate may be a misnomer, but it feels right. It is 1 divided by the sample time in the FlightGear Preconfigured 6DoF Animation block.)
- **Options**: Configure various FlightGear options.
- **Scenery**: Enable TerraSync for automatic scenery downloading. Confirm that scenery is downloaded into the location specified in `runFlightGear.m`. Monitor internet connection bandwidth if you are having trouble downloading scenery.


## FlightGear Options/Flags

Here are the flags used in the script:

- `--fdm=null`: Use no flight dynamics model.
- `--native-fdm=socket,in,<frame_rate>,localhost,5502,udp`: Use a native flight dynamics model over a socket connection.
- `--aircraft=c172p`: Specify the aircraft model (Cessna 172P).
- `--fog-fastest`: Optimize fog rendering for performance.
- `--disable-clouds`: Disable cloud rendering.
- `--disable-sound`: Disable sound.
- `--in-air`: Start the aircraft in the air.
- `--lat=<latitude>`: Set the initial latitude.
- `--lon=<longitude>`: Set the initial longitude.
- `--altitude=<altitude>`: Set the initial altitude.
- `--enable-terrasync`: Enable TerraSync for automatic scenery downloading.
- `--terrasync-dir=<path>`: Specify the TerraSync directory.

### Additional Options (if enabled)
- `--airport=KEDW`: Set the starting airport to Edwards Air Force Base.
- `--runway=10L`: Set the starting runway.
- `--altitude=7224`: Set the starting altitude.
- `--offset-distance=4.72`: Set the offset distance from the previously specified scenery feature, such as runway (I think that's what this flag does).
- `--offset-azimuth=0`: Set the offset azimuth from the previously specified scenery feature, such as runway (I think that's what this flag does).