init_lat = aircraftInitial.lat_deg;
init_long = aircraftInitial.lon_deg;
init_altitude = aircraftInitial.alt_m;
init_yaw_deg = aircraftInitial.yawAngle_rad;
if ispc
    app_path = '"C:\Program Files\FlightGear 2020.3\bin\fgfs.exe"';
elseif ismac
    app_path = '/Applications/FlightGear.app/Contents/MacOS/fgfs';
elseif isunix
    app_path = '/usr/bin/fgfs';
else
    error('Unsupported operating system');
end
% find closest feasible frame rate given the fixed step size (rounding up)
frameRate_Hz = floor(1 / stepSize_s);

% Check to see if F16 FlightGear visualization exist
f16DirName = 'C:\Program Files\FlightGear 2020.3\data\Aircraft\f16';
hexDirName = 'C:\Program Files\FlightGear 2020.3\data\Aircraft\bigHexy';
options = sprintf('--fdm=null --native-fdm=socket,in,%d,localhost,5502,udp --aircraft=c172p --fog-fastest --disable-clouds --disable-sound', frameRate_Hz);
switch lower(vehicleParams.type)
    case "f-16"
        if isdir(f16DirName)
            options = sprintf('--fdm=null --native-fdm=socket,in,%d,localhost,5502,udp --aircraft=f16-block-52 --fog-fastest --disable-clouds --disable-sound', frameRate_Hz);
        end
    case "hexarotor"
        if isdir(hexDirName)
            options = sprintf('--fdm=null --native-fdm=socket,in,%d,localhost,5502,udp --aircraft=bigHexy-block-52 --fog-fastest --disable-clouds --disable-sound', frameRate_Hz);
        end
    otherwise
        warning("Unknown vehicle for display")
end
           
initial_conditions = sprintf('--in-air=%s  --lat=%f --lon=%f --altitude=%f --heading=%f --timeofday=noon', 'false', init_lat, init_long, init_altitude, rad2deg(init_yaw_deg));
scenery = sprintf('--enable-terrasync');
use_additional_options = false;
additional_options = '';
if use_additional_options
    % Examples of potentially useful options:
    additional_options = '--airport=KEDW --runway=10L --altitude=7224 --offset-distance=4.72 --offset-azimuth=0';
end
command = sprintf('%s %s %s %s %s &', app_path, options, initial_conditions, scenery, additional_options);
system(command);