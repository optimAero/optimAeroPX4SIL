% This script populates the base workspace with vehicle parameters for the specified vehicle. This script also includes
% the data describing the initial location of the vehicle in the ismulation.
switch lower(vehicleParams.type)
    case "f-16"
        vehicleParams.dryMass_kg = 20500 * lbs2kg;
        vehicleParams.aircraftInertialBody_kgm2 = [12820.61 0 1331.41; 0 75673.62 0; 0 0 85552.11];
        vehicleParams.bRef_m = 30 * ft2m;
        vehicleParams.SRef_m2 = 27.8709;
        vehicleParams.cRef_m = 11.32 * ft2m;% Mean Aero Chord
        vehicleParams.aircraftCg_m = [vehicleParams.cRef_m * 0.35; 0; 0]; 
        vehicleParams.refCG_m = [vehicleParams.cRef_m * 0.35; 0; 0]; % reference cg
        aeroDataF16    
    case "hexarotor"    
        vehicleParams.dryMass_kg = 180 * lbs2kg;
        vehicleParams.aircraftInertialBody_kgm2 = [11.8 0 0; 0 11.8 0;  0 0 23.5];
        vehicleParams.aircraftCg_m = [0; 0; 0]; 
        vehicleParams.refCG_m = [0; 0; 0]; % reference cg
        vehicleParams.maxRPM = 3000;
        vehicleParams.SRef_m2 = 0.5;
        aeroDataHex
    otherwise
        error(char(["unknown vehicle: " vehicleType]))
end

% set initial location to Juancho E. Yrausquin Airport
referenceAltitude_m = 125 * ft2m;
referenceLatitude_deg = 17.645927; 
referenceLongitude_deg = -63.222027;
aircraftInitialPosInNED_m = [0, 0, -referenceAltitude_m];
aircraftInitialVelInBody_mps = [0, 0, 0];
aircraftInitialEuler_rad = [0, 0, 1.9199];

aircraftInitialBodyRates_radps = [0, 0, 0];
referenceDecimalYear_years = 2024; % World magnetic model doesn't work in 2025
aircraftInitial.lat_deg = referenceLatitude_deg;
aircraftInitial.lon_deg = referenceLongitude_deg;
aircraftInitial.alt_m = aircraftInitialPosInNED_m(3);
aircraftInitial.yawAngle_rad = aircraftInitialEuler_rad(3);
terrainHeightNED_m = aircraftInitialPosInNED_m(3); 