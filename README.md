<p>
    <img src="README_Images/optimAero.png" alt="optimAero Logo" width="350"/>
</p>

https://www.optim.aero

info@optim.aero

# optimAero PX4 Simulink SIL Overview

This repository houses a software in the loop (SIL) simulation for an aircraft using the PX4 controller and a Simulink-based physics plant, sensor, and environmental model. The purpose of this SIL is to provide the user with an example of how to connect the PX4 flight controller to a Simulink plant model. The flight controller used in this SIL is a modified PX4 autopilot (V1.14.0). The SIL (`VehicleSilSimulation.slx`) is located in the root directory of the repo. The plant (`VehiclePlant.slx`) is also housed in the root directory. Currently the default plant model is of an F-16 aircraft based on the model provided in <em>Aircraft Control and Simulation THIRD EDITION (STEVENS, LEWIS, JOHNSON)</em>. A custom plant/aircraft can be added by following the instructions below in the <strong> Adding Custom Vehicle Configuration </strong> section. **All simulink models were created using MATLAB 2024a Update 6**.


## Windows installation instructions (NOTE: this will fail on Mac, as Matlab does not support Mac for all required toolboxes):

1. In git bash:

```
git clone (https)
cd PX4SIL
git submodule update --init --recursive
```
If working on slow internet/computer use `--depth 1` tag  `git submodule update --init --recursive --depth 1`. The depth 1 tag may be required on slow connections. This will pull the PX4 repository as well. (NOTE: compilation of PX4 will be slow if the PX4 repo is checked out on the Windows partition. To speed it up, check the repo out into the WSL root directory on the Linux partition.)

2. From an elevated cmd prompt (e.g., run cmd as administrator or use Powershell): 

Type: 

`ipconfig` 

to get the get L/WAN IP (e.g. 192.168.12.104).  You will use this IP in step 3.

Then, install WSL (Note: the SIL has only been tested using Ubuntu <strong>22.04.3 LTS</strong>): 

`wsl --install`


3. In WSL: 
Type:

`ifconfig`

to get eth0's IP (e.g., 192.168.125.73). You will use this IP in step 4. 

Set the environment variable for the PX4 hostname with the WSL IP you found in step 2: 

`export PX4_SIM_HOSTNAME=192.168.12.104`

4. In QGC:
QGC may  be installed from: https://github.com/mavlink/qgroundcontrol/releases

Once opened, click: Application Settings > Comm links, add a link and press connect: 

- UDP
- port 18570
- WSL's eth0 IP (e.g., 192.168.125.73 found in step 3)

For more information, read the "PX4 Simulink Integration" document stored in the PX4Sim folder of the repo. To run the simulation, follow these steps:

5. Make sure the required toolboxes and support packages (listed below) are downloaded in Matlab Add On Manager. You must set up the PX4 build tool chain which may be done through the Matlab setup of the UAV Toolbox Support Package for PX4 Autopilots. https://www.mathworks.com/help/uav/px4/ug/setting-px4-toolchain-ubuntu.html.  Otherwise, you can do it via WSL in the folder where you checked out the PX4 repository: ./Tools/setup/ubuntu.sh
6. Open Matlab, run `initVehicleSIL.m` and change the Matlab directory to its containing folder (this script initializes the workspace)
7. If using FlightGear visualization,  run `runFlightGear.m` in MATLAB
8. Open and run the `VehicleSILSimulation.slx` model
9. While the model is running, open a Windows command prompt and navigate to the PX4-Autopilot submodule inside the repository
8. Launch wsl in the command prompt (`wsl`)
9. Build the PX4 executable:
`make px4_sitl_default optimAeroF16`

Once built, the PX4 executable should connect to the Simulink model. Ensure you run the Simulink file first before attempting to connect the PX4 executable. The Simulink model will report "Initializing" or "waiting to connect on 4560" when it is ready for the PX4 executable to connect.

## Launching SIL AFTER initial setup

After the initial setup launch the full SIL can be done using the `initVehicleSIL` with the `launchFullSIL` argument set to true. Set all arguments as needed. Example: `initVehicleSIL(true,'FlightGear')`. If PX4 cannot establish a connection close the WSL terminal and run the `initVehicleSIL` function using the `eth0Path` argument (example: `initVehicleSIL(true,"FlightGear","192.168.50.236")` )

## SIL Connector Notes

The Pixhawk SIL connector is developed by Kiril Boychev and can be found here: <https://www.mathworks.com/matlabcentral/fileexchange/114320-pixhawk-software-in-the-loop-sil-connector-for-simulink>. If the S-Function needs to be remade, and the files are downloaded from the link provided, the asio and mavlink folder along with the `asio.hpp` must be placed inside of a folder named "includes" in order for the make.m file to work properly.

## Unit Tests

Unit tests (UTs) for nearly all of the reference models used in the plant have been created and are stored in the  "testing" folder of each main model folder (i.e., vehicle/testing). All UTs can be run at once using the `testVehicleSIL.m` script (note: `initVehicleSIL(false)` must be run first).

If additional UTs need to be created, the makeHarness function can be used to generate a blank test harness of the model entered into the argument of the function. (see description of makeHarness in the file itself)

## Required Matlab toolboxes

1. Aerospace Toolbox
2. Aerospace Blockset
3. Control System Toolbox
4. Embedded Coder
5. Matlab Coder
6. Simulink
7. Simulink Coder
8. Simulink Test
9. UAV Toolbox

## Required Support Packages

1. UAV Toolbox Support Package for PX4 Autopilots

## Visualization

Installing Flightgear is optional but helps with visualizing flights. Once it is installed with default options, use `visualizationType = "FlightGear"`. For instructions on how to download FlightGear, view visualization/Readme.md

## QGroundControl

QGC must be connected in order to use the joystick when flying via PX4. In QGC, the joystick may be set up once PX4 is running and connected to Simulink. Plug in a joystick (an Xbox or PS5 controller has been tested successfully), click the Q in the top left, then Vehicle Setup, then Joystick. Select the correct Active Joystick, and it is recommended to assign some buttons to ARM and ACRO flight mode.

## Adding Custom Vehicle Configuration

To add a custom vehicle configuration, the Simulink model and the PX4 configuration file, along with other files, must be changed.

### Simulink Changes

#### Step 1: Plant Model

A custom vehicle configuration can be added to the Simulink model by adding the vehicle model as a variant to the <em>plant</em> variant block shown in Figure 1. Note the outputs needed from the plant model (<strong> vehicleBus</strong>) must use the same units as the outputs of the F16 plant model.
<p>
    <img src="README_Images/plant.png" alt="Plant Variant Model" width="600"/>
</p>
<p>
    <em>Figure 1: Plant Variant Model</em>
</p>

#### Step 2: Bus Definition Updates

The <strong>ServosCommandBus</strong> and <strong>ServosBus</strong> must be updated based on the aircraft configuration that is being added. All of the vehicle's actuators (control surfaces, propellers, etc.,) must be added as an element of a sub-bus of the ServosCommandBus bus. The <strong>signals/CustomAircraftS/servosBusDefinitionCustomAircraft.m</strong> and  <strong>signals/CustomAircraftS/servosCommandCustomAircraftBusDefinition.m</strong> files can be modified to include the required signals.

A variant must be added to the <em>PX4 Interface Variant</em> model, Figure 2. This variant must have the correct signals mapped to the <strong>ServosCommandBus</strong> bus assignment block as shown in Figure 3.
<p>
    <img src="README_Images/PX4SimulinkVariant.png" alt="PX4 Simulink Varaint" width="600"/>
</p>
<p>
    <em>Figure 2: PX4 Simulink Varaint</em>
</p>
<p>
    <img src="README_Images/commandMapping.png" alt="PX4 Command Mapping" width="600"/>
</p>
<p>
    <em>Figure 3: PX4 Command Mapping</em>
</p>

### PX4 Changes

#### Step 1: Creating Aircraft Configuration File

A configuration file that specifies the frame type of the aircraft as well as other parameters must be created and saved in <strong>\px4-autopilot\ROMFS\px4fmu_common\init.d-posix\airframes</strong>. The <strong>10020_optimAeroF16</strong> and <strong>10016_none-iris</strong> files can be used as examples. More details about vehicle frame types and parameters can be found on PX4's website.

#### Step 2: Adding Aircraft Configuration File

The aircraft configuration file must be added to the <strong>px4-autopilot\ROMFS\px4fmu_common\init.d-posix\airframesCMakeLists.txt</strong> file and the <strong>px4-autopilot\src\modules\simulation\simulator_mavlink\CMakeLists.txt</strong> file must be updated (replace <em>10020_optimAeroF16</em> and anything else associated with that name in the file with the name of the new custom aircraft).

## Known Issues

### Mapping commands from PX4

Mapping the commands from the <strong>pixhawk_sil_connector</strong> to the <strong>ServosCommandBus</strong> can be challenging. One method of figuring out what signals from the pixhawk_sil_connector correspond to the vehicle's actuators is by using a demux to view all 16 signals coming from the first output of the px4_sil_connector as shown in Figure 4, and observing how the signals change given a joystick input.

### Ending the simulation

When ending the simulation after a successful launch  Ctrl+C must be used to end the PX4 autopilot first (in the WSL terminal press Ctrl+C). If this is not done first the Simulink model will fail to close and matlab will need to be terminate

### Vehicle parameters

The F16 parameters that should be used when running the simulation can be found here: ROMFS/px4fmu_common/init.d-posix/airframes/10020_optimAeroF16. In some cases these parameters are not properly loaded into QGC. If that occurs, the parameters will need to updated manually.

### Simulink fail to launch

In some cases simulink my fail to run and Matlab/Simulink may crash. If this happens multiple times, delete the work folder in the repo and re-launch the Simulink model

<p>
    <img src="README_Images/demuxCmds.png" alt="Demux Commands" width="600"/>
</p>
<p>
    <em>Figure 4: Demux command signals</em>
</p>
