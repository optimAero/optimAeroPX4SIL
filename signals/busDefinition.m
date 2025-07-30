% busDefinition: This function initializes a set of bus objects in the MATLAB base workspace. All busses used in the
% simulation can be found in this function
function busDefinition(vehicleType)

% Servo bus definition
servosBusDefinition(vehicleType);

% servo commands bus
servosCommandBusDefinition(vehicleType);

% failure bus
failureBusDefinition(vehicleType);

% Bus object: ComponentForcesMomentsBus
clear elems;
elems(1) = Simulink.BusElement;
elems(1).Name = 'forcesInBody_N';
elems(1).Dimensions = 3;
elems(1).DimensionsMode = 'Fixed';
elems(1).DataType = 'double';
elems(1).Complexity = 'real';
elems(1).Min = [];
elems(1).Max = [];
elems(1).DocUnits = '';
elems(1).Description = '';

elems(2) = Simulink.BusElement;
elems(2).Name = 'momentsInBody_Nm';
elems(2).Dimensions = 3;
elems(2).DimensionsMode = 'Fixed';
elems(2).DataType = 'double';
elems(2).Complexity = 'real';
elems(2).Min = [];
elems(2).Max = [];
elems(2).DocUnits = '';
elems(2).Description = '';

ComponentForcesMomentsBus = Simulink.Bus;
ComponentForcesMomentsBus.HeaderFile = '';
ComponentForcesMomentsBus.Description = '';
ComponentForcesMomentsBus.DataScope = 'Auto';
ComponentForcesMomentsBus.Alignment = -1;
ComponentForcesMomentsBus.PreserveElementDimensions = 0;
ComponentForcesMomentsBus.Elements = elems;
clear elems;
assignin('base', 'ComponentForcesMomentsBus', ComponentForcesMomentsBus);


% Propulsion System Bus
propulsionSystemBusDefinition(vehicleType)

% Bus object: ADCSensorBus
clear elems;
elems(1) = Simulink.BusElement;
elems(1).Name = 'BaroSensorBus';
elems(1).Dimensions = 1;
elems(1).DimensionsMode = 'Fixed';
elems(1).DataType = 'Bus: BaroSensorBus';
elems(1).Complexity = 'real';
elems(1).Min = [];
elems(1).Max = [];
elems(1).DocUnits = '';
elems(1).Description = '';

elems(2) = Simulink.BusElement;
elems(2).Name = 'DiffPressureSensorBus';
elems(2).Dimensions = 1;
elems(2).DimensionsMode = 'Fixed';
elems(2).DataType = 'Bus: DiffPressureSensorBus';
elems(2).Complexity = 'real';
elems(2).Min = [];
elems(2).Max = [];
elems(2).DocUnits = '';
elems(2).Description = '';

ADCSensorBus = Simulink.Bus;
ADCSensorBus.HeaderFile = '';
ADCSensorBus.Description = '';
ADCSensorBus.DataScope = 'Auto';
ADCSensorBus.Alignment = -1;
ADCSensorBus.PreserveElementDimensions = 0;
ADCSensorBus.Elements = elems;
clear elems;
assignin('base', 'ADCSensorBus', ADCSensorBus);

% Bus object: AccelSensorBus
clear elems;
elems(1) = Simulink.BusElement;
elems(1).Name = 'device_id';
elems(1).Dimensions = 1;
elems(1).DimensionsMode = 'Fixed';
elems(1).DataType = 'double';
elems(1).Complexity = 'real';
elems(1).Min = [];
elems(1).Max = [];
elems(1).DocUnits = '';
elems(1).Description = '';

elems(2) = Simulink.BusElement;
elems(2).Name = 'x_mps2';
elems(2).Dimensions = 1;
elems(2).DimensionsMode = 'Fixed';
elems(2).DataType = 'double';
elems(2).Complexity = 'real';
elems(2).Min = [];
elems(2).Max = [];
elems(2).DocUnits = '';
elems(2).Description = '';

elems(3) = Simulink.BusElement;
elems(3).Name = 'y_mps2';
elems(3).Dimensions = 1;
elems(3).DimensionsMode = 'Fixed';
elems(3).DataType = 'double';
elems(3).Complexity = 'real';
elems(3).Min = [];
elems(3).Max = [];
elems(3).DocUnits = '';
elems(3).Description = '';

elems(4) = Simulink.BusElement;
elems(4).Name = 'z_mps2';
elems(4).Dimensions = 1;
elems(4).DimensionsMode = 'Fixed';
elems(4).DataType = 'double';
elems(4).Complexity = 'real';
elems(4).Min = [];
elems(4).Max = [];
elems(4).DocUnits = '';
elems(4).Description = '';

elems(5) = Simulink.BusElement;
elems(5).Name = 'temperature_degC';
elems(5).Dimensions = 1;
elems(5).DimensionsMode = 'Fixed';
elems(5).DataType = 'double';
elems(5).Complexity = 'real';
elems(5).Min = [];
elems(5).Max = [];
elems(5).DocUnits = '';
elems(5).Description = '';

AccelSensorBus = Simulink.Bus;
AccelSensorBus.HeaderFile = '';
AccelSensorBus.Description = '';
AccelSensorBus.DataScope = 'Auto';
AccelSensorBus.Alignment = -1;
AccelSensorBus.PreserveElementDimensions = 0;
AccelSensorBus.Elements = elems;
clear elems;
assignin('base', 'AccelSensorBus', AccelSensorBus);

% Bus object: ActuatorBus
clear elems;
elems(1) = Simulink.BusElement;
elems(1).Name = 'Servos';
elems(1).Dimensions = 1;
elems(1).DimensionsMode = 'Fixed';
elems(1).DataType = 'Bus: ServosBus';
elems(1).Complexity = 'real';
elems(1).Min = [];
elems(1).Max = [];
elems(1).DocUnits = '';
elems(1).Description = '';

elems(2) = Simulink.BusElement;
elems(2).Name = 'Propulsion';
elems(2).Dimensions = 1;
elems(2).DimensionsMode = 'Fixed';
elems(2).DataType = 'Bus: PropulsionBus';
elems(2).Complexity = 'real';
elems(2).Min = [];
elems(2).Max = [];
elems(2).DocUnits = '';
elems(2).Description = '';

ActuatorBus = Simulink.Bus;
ActuatorBus.HeaderFile = '';
ActuatorBus.Description = '';
ActuatorBus.DataScope = 'Auto';
ActuatorBus.Alignment = -1;
ActuatorBus.PreserveElementDimensions = 0;
ActuatorBus.Elements = elems;
clear elems;
assignin('base', 'ActuatorBus', ActuatorBus);

% Bus object: ActuatorCommandBus
clear elems;
elems(1) = Simulink.BusElement;
elems(1).Name = 'controllerArmed';
elems(1).Dimensions = 1;
elems(1).DimensionsMode = 'Fixed';
elems(1).DataType = 'double';
elems(1).Complexity = 'real';
elems(1).Min = [];
elems(1).Max = [];
elems(1).DocUnits = '';
elems(1).Description = '';

elems(2) = Simulink.BusElement;
elems(2).Name = 'ServosCommand';
elems(2).Dimensions = 1;
elems(2).DimensionsMode = 'Fixed';
elems(2).DataType = 'Bus: ServosCommandBus';
elems(2).Complexity = 'real';
elems(2).Min = [];
elems(2).Max = [];
elems(2).DocUnits = '';
elems(2).Description = '';

elems(3) = Simulink.BusElement;
elems(3).Name = 'EngineCommand';
elems(3).Dimensions = 1;
elems(3).DimensionsMode = 'Fixed';
elems(3).DataType = 'Bus: EngineCommandBus';
elems(3).Complexity = 'real';
elems(3).Min = [];
elems(3).Max = [];
elems(3).DocUnits = '';
elems(3).Description = '';

ActuatorCommandBus = Simulink.Bus;
ActuatorCommandBus.HeaderFile = '';
ActuatorCommandBus.Description = '';
ActuatorCommandBus.DataScope = 'Auto';
ActuatorCommandBus.Alignment = -1;
ActuatorCommandBus.PreserveElementDimensions = 0;
ActuatorCommandBus.Elements = elems;
clear elems;
assignin('base', 'ActuatorCommandBus', ActuatorCommandBus);

% Bus object: AirDataBus
clear elems;
elems(1) = Simulink.BusElement;
elems(1).Name = 'airspeedInBody_mps';
elems(1).Dimensions = 3;
elems(1).DimensionsMode = 'Fixed';
elems(1).DataType = 'double';
elems(1).Complexity = 'real';
elems(1).Min = [];
elems(1).Max = [];
elems(1).DocUnits = '';
elems(1).Description = '';

elems(2) = Simulink.BusElement;
elems(2).Name = 'alpha_rad';
elems(2).Dimensions = 1;
elems(2).DimensionsMode = 'Fixed';
elems(2).DataType = 'double';
elems(2).Complexity = 'real';
elems(2).Min = [];
elems(2).Max = [];
elems(2).DocUnits = '';
elems(2).Description = '';

elems(3) = Simulink.BusElement;
elems(3).Name = 'beta_rad';
elems(3).Dimensions = 1;
elems(3).DimensionsMode = 'Fixed';
elems(3).DataType = 'double';
elems(3).Complexity = 'real';
elems(3).Min = [];
elems(3).Max = [];
elems(3).DocUnits = '';
elems(3).Description = '';

AirDataBus = Simulink.Bus;
AirDataBus.HeaderFile = '';
AirDataBus.Description = '';
AirDataBus.DataScope = 'Auto';
AirDataBus.Alignment = -1;
AirDataBus.PreserveElementDimensions = 0;
AirDataBus.Elements = elems;
clear elems;
assignin('base','AirDataBus', AirDataBus);

% Bus object: AirEnvironmentBus
clear elems;
elems(1) = Simulink.BusElement;
elems(1).Name = 'airTemperature_K';
elems(1).Dimensions = 1;
elems(1).DimensionsMode = 'Fixed';
elems(1).DataType = 'double';
elems(1).Complexity = 'real';
elems(1).Min = [];
elems(1).Max = [];
elems(1).DocUnits = '';
elems(1).Description = '';

elems(2) = Simulink.BusElement;
elems(2).Name = 'airPressure_Pa';
elems(2).Dimensions = 1;
elems(2).DimensionsMode = 'Fixed';
elems(2).DataType = 'double';
elems(2).Complexity = 'real';
elems(2).Min = [];
elems(2).Max = [];
elems(2).DocUnits = '';
elems(2).Description = '';

elems(3) = Simulink.BusElement;
elems(3).Name = 'airDensity_kgpm3';
elems(3).Dimensions = 1;
elems(3).DimensionsMode = 'Fixed';
elems(3).DataType = 'double';
elems(3).Complexity = 'real';
elems(3).Min = 0;
elems(3).Max = [];
elems(3).DocUnits = '';
elems(3).Description = '';

elems(4) = Simulink.BusElement;
elems(4).Name = 'windSpeedInNED_mps';
elems(4).Dimensions = 3;
elems(4).DimensionsMode = 'Fixed';
elems(4).DataType = 'double';
elems(4).Complexity = 'real';
elems(4).Min = [];
elems(4).Max = [];
elems(4).DocUnits = '';
elems(4).Description = '';

elems(5) = Simulink.BusElement;
elems(5).Name = 'speedOfSound_mps';
elems(5).Dimensions = 1;
elems(5).DimensionsMode = 'Fixed';
elems(5).DataType = 'double';
elems(5).Complexity = 'real';
elems(5).Min = [];
elems(5).Max = [];
elems(5).DocUnits = '';
elems(5).Description = '';

elems(6) = Simulink.BusElement;
elems(6).Name = 'windsAloftInNED_mps';
elems(6).Dimensions = 3;
elems(6).DimensionsMode = 'Fixed';
elems(6).DataType = 'double';
elems(6).Complexity = 'real';
elems(6).Min = [];
elems(6).Max = [];
elems(6).DocUnits = '';
elems(6).Description = '';

elems(7) = Simulink.BusElement;
elems(7).Name = 'gustInNED_mps';
elems(7).Dimensions = 3;
elems(7).DimensionsMode = 'Fixed';
elems(7).DataType = 'double';
elems(7).Complexity = 'real';
elems(7).Min = [];
elems(7).Max = [];
elems(7).DocUnits = '';
elems(7).Description = '';

elems(8) = Simulink.BusElement;
elems(8).Name = 'turbulenceInNED_mps';
elems(8).Dimensions = 3;
elems(8).DimensionsMode = 'Fixed';
elems(8).DataType = 'double';
elems(8).Complexity = 'real';
elems(8).Min = [];
elems(8).Max = [];
elems(8).DocUnits = '';
elems(8).Description = '';

AirEnvironmentBus = Simulink.Bus;
AirEnvironmentBus.HeaderFile = '';
AirEnvironmentBus.Description = '';
AirEnvironmentBus.DataScope = 'Auto';
AirEnvironmentBus.Alignment = -1;
AirEnvironmentBus.PreserveElementDimensions = 0;
AirEnvironmentBus.Elements = elems;
clear elems;
assignin('base', 'AirEnvironmentBus', AirEnvironmentBus);

% Bus object: AircraftForcesMomentsBus
clear elems;
elems(1) = Simulink.BusElement;
elems(1).Name = 'forcesInBody_N';
elems(1).Dimensions = 3;
elems(1).DimensionsMode = 'Fixed';
elems(1).DataType = 'double';
elems(1).Complexity = 'real';
elems(1).Min = [];
elems(1).Max = [];
elems(1).DocUnits = '';
elems(1).Description = '';

elems(2) = Simulink.BusElement;
elems(2).Name = 'momentsInBody_Nm';
elems(2).Dimensions = 3;
elems(2).DimensionsMode = 'Fixed';
elems(2).DataType = 'double';
elems(2).Complexity = 'real';
elems(2).Min = [];
elems(2).Max = [];
elems(2).DocUnits = '';
elems(2).Description = '';

elems(3) = Simulink.BusElement;
elems(3).Name = 'aeroForcesMoments';
elems(3).Dimensions = 1;
elems(3).DimensionsMode = 'Fixed';
elems(3).DataType = 'Bus: ComponentForcesMomentsBus';
elems(3).Complexity = 'real';
elems(3).Min = [];
elems(3).Max = [];
elems(3).DocUnits = '';
elems(3).Description = '';

elems(4) = Simulink.BusElement;
elems(4).Name = 'engineForcesMoments';
elems(4).Dimensions = 1;
elems(4).DimensionsMode = 'Fixed';
elems(4).DataType = 'Bus: ComponentForcesMomentsBus';
elems(4).Complexity = 'real';
elems(4).Min = [];
elems(4).Max = [];
elems(4).DocUnits = '';
elems(4).Description = '';

elems(5) = Simulink.BusElement;
elems(5).Name = 'groundForcesMoments';
elems(5).Dimensions = 1;
elems(5).DimensionsMode = 'Fixed';
elems(5).DataType = 'Bus: ComponentForcesMomentsBus';
elems(5).Complexity = 'real';
elems(5).Min = [];
elems(5).Max = [];
elems(5).DocUnits = '';
elems(5).Description = '';

elems(6) = Simulink.BusElement;
elems(6).Name = 'weightForcesMoments';
elems(6).Dimensions = 1;
elems(6).DimensionsMode = 'Fixed';
elems(6).DataType = 'Bus: ComponentForcesMomentsBus';
elems(6).Complexity = 'real';
elems(6).Min = [];
elems(6).Max = [];
elems(6).DocUnits = '';
elems(6).Description = '';

AircraftForcesMomentsBus = Simulink.Bus;
AircraftForcesMomentsBus.HeaderFile = '';
AircraftForcesMomentsBus.Description = '';
AircraftForcesMomentsBus.DataScope = 'Auto';
AircraftForcesMomentsBus.Alignment = -1;
AircraftForcesMomentsBus.PreserveElementDimensions = 0;
AircraftForcesMomentsBus.Elements = elems;
clear elems;
assignin('base', 'AircraftForcesMomentsBus', AircraftForcesMomentsBus);

% Bus object: BaroSensorBus
clear elems;
elems(1) = Simulink.BusElement;
elems(1).Name = 'device_id';
elems(1).Dimensions = 1;
elems(1).DimensionsMode = 'Fixed';
elems(1).DataType = 'double';
elems(1).Complexity = 'real';
elems(1).Min = [];
elems(1).Max = [];
elems(1).DocUnits = '';
elems(1).Description = '';

elems(2) = Simulink.BusElement;
elems(2).Name = 'pressure_pa';
elems(2).Dimensions = 1;
elems(2).DimensionsMode = 'Fixed';
elems(2).DataType = 'double';
elems(2).Complexity = 'real';
elems(2).Min = [];
elems(2).Max = [];
elems(2).DocUnits = '';
elems(2).Description = '';

elems(3) = Simulink.BusElement;
elems(3).Name = 'altitude_m';
elems(3).Dimensions = 1;
elems(3).DimensionsMode = 'Fixed';
elems(3).DataType = 'double';
elems(3).Complexity = 'real';
elems(3).Min = [];
elems(3).Max = [];
elems(3).DocUnits = '';
elems(3).Description = '';

elems(4) = Simulink.BusElement;
elems(4).Name = 'temperature_degC';
elems(4).Dimensions = 1;
elems(4).DimensionsMode = 'Fixed';
elems(4).DataType = 'double';
elems(4).Complexity = 'real';
elems(4).Min = [];
elems(4).Max = [];
elems(4).DocUnits = '';
elems(4).Description = '';

BaroSensorBus = Simulink.Bus;
BaroSensorBus.HeaderFile = '';
BaroSensorBus.Description = '';
BaroSensorBus.DataScope = 'Auto';
BaroSensorBus.Alignment = -1;
BaroSensorBus.PreserveElementDimensions = 0;
BaroSensorBus.Elements = elems;
clear elems;
assignin('base', 'BaroSensorBus', BaroSensorBus);

% Bus object: BodyStateBus
clear elems;
elems(1) = Simulink.BusElement;
elems(1).Name = 'aircraftVelInNED_mps';
elems(1).Dimensions = 3;
elems(1).DimensionsMode = 'Fixed';
elems(1).DataType = 'double';
elems(1).Complexity = 'real';
elems(1).Min = [];
elems(1).Max = [];
elems(1).DocUnits = '';
elems(1).Description = '';

elems(2) = Simulink.BusElement;
elems(2).Name = 'aircraftPosInNED_m';
elems(2).Dimensions = 3;
elems(2).DimensionsMode = 'Fixed';
elems(2).DataType = 'double';
elems(2).Complexity = 'real';
elems(2).Min = [];
elems(2).Max = [];
elems(2).DocUnits = '';
elems(2).Description = '';

elems(3) = Simulink.BusElement;
elems(3).Name = 'aircraftEulerAngles_rad';
elems(3).Dimensions = 3;
elems(3).DimensionsMode = 'Fixed';
elems(3).DataType = 'double';
elems(3).Complexity = 'real';
elems(3).Min = [];
elems(3).Max = [];
elems(3).DocUnits = '';
elems(3).Description = '';

elems(4) = Simulink.BusElement;
elems(4).Name = 'aircraftVelInBody_mps';
elems(4).Dimensions = 3;
elems(4).DimensionsMode = 'Fixed';
elems(4).DataType = 'double';
elems(4).Complexity = 'real';
elems(4).Min = [];
elems(4).Max = [];
elems(4).DocUnits = '';
elems(4).Description = '';

elems(5) = Simulink.BusElement;
elems(5).Name = 'aircraftAngVelInBody_radps';
elems(5).Dimensions = 3;
elems(5).DimensionsMode = 'Fixed';
elems(5).DataType = 'double';
elems(5).Complexity = 'real';
elems(5).Min = [];
elems(5).Max = [];
elems(5).DocUnits = '';
elems(5).Description = '';

elems(6) = Simulink.BusElement;
elems(6).Name = 'aircraftAngAccelInBody_radps2';
elems(6).Dimensions = 3;
elems(6).DimensionsMode = 'Fixed';
elems(6).DataType = 'double';
elems(6).Complexity = 'real';
elems(6).Min = [];
elems(6).Max = [];
elems(6).DocUnits = '';
elems(6).Description = '';

elems(7) = Simulink.BusElement;
elems(7).Name = 'aircraftAccelInBody_mps2';
elems(7).Dimensions = 3;
elems(7).DimensionsMode = 'Fixed';
elems(7).DataType = 'double';
elems(7).Complexity = 'real';
elems(7).Min = [];
elems(7).Max = [];
elems(7).DocUnits = '';
elems(7).Description = '';

elems(8) = Simulink.BusElement;
elems(8).Name = 'DCM_be';
elems(8).Dimensions = [3 3];
elems(8).DimensionsMode = 'Fixed';
elems(8).DataType = 'double';
elems(8).Complexity = 'real';
elems(8).Min = [];
elems(8).Max = [];
elems(8).DocUnits = '';
elems(8).Description = '';

elems(9) = Simulink.BusElement;
elems(9).Name = 'aircraftAccelbe_mps2';
elems(9).Dimensions = 3;
elems(9).DimensionsMode = 'Fixed';
elems(9).DataType = 'double';
elems(9).Complexity = 'real';
elems(9).Min = [];
elems(9).Max = [];
elems(9).DocUnits = '';
elems(9).Description = '';

BodyStateBus = Simulink.Bus;
BodyStateBus.HeaderFile = '';
BodyStateBus.Description = '';
BodyStateBus.DataScope = 'Auto';
BodyStateBus.Alignment = -1;
BodyStateBus.PreserveElementDimensions = 0;
BodyStateBus.Elements = elems;
clear elems;
assignin('base', 'BodyStateBus', BodyStateBus);


% Bus object: DiffPressureSensorBus
clear elems;
elems(1) = Simulink.BusElement;
elems(1).Name = 'device_id';
elems(1).Dimensions = 1;
elems(1).DimensionsMode = 'Fixed';
elems(1).DataType = 'double';
elems(1).Complexity = 'real';
elems(1).Min = [];
elems(1).Max = [];
elems(1).DocUnits = '';
elems(1).Description = '';

elems(2) = Simulink.BusElement;
elems(2).Name = 'differential_pressure_pa';
elems(2).Dimensions = 1;
elems(2).DimensionsMode = 'Fixed';
elems(2).DataType = 'double';
elems(2).Complexity = 'real';
elems(2).Min = [];
elems(2).Max = [];
elems(2).DocUnits = '';
elems(2).Description = '';

elems(3) = Simulink.BusElement;
elems(3).Name = 'temperature_degC';
elems(3).Dimensions = 1;
elems(3).DimensionsMode = 'Fixed';
elems(3).DataType = 'double';
elems(3).Complexity = 'real';
elems(3).Min = [];
elems(3).Max = [];
elems(3).DocUnits = '';
elems(3).Description = '';

DiffPressureSensorBus = Simulink.Bus;
DiffPressureSensorBus.HeaderFile = '';
DiffPressureSensorBus.Description = '';
DiffPressureSensorBus.DataScope = 'Auto';
DiffPressureSensorBus.Alignment = -1;
DiffPressureSensorBus.PreserveElementDimensions = 0;
DiffPressureSensorBus.Elements = elems;
clear elems;
assignin('base', 'DiffPressureSensorBus', DiffPressureSensorBus);

% Bus object: EarthEnvironmentBus
clear elems;
elems(1) = Simulink.BusElement;
elems(1).Name = 'gravityScalar_mps2';
elems(1).Dimensions = 1;
elems(1).DimensionsMode = 'Fixed';
elems(1).DataType = 'double';
elems(1).Complexity = 'real';
elems(1).Min = [];
elems(1).Max = [];
elems(1).DocUnits = '';
elems(1).Description = '';

elems(2) = Simulink.BusElement;
elems(2).Name = 'worldMagneticFieldInNED_nT';
elems(2).Dimensions = 3;
elems(2).DimensionsMode = 'Fixed';
elems(2).DataType = 'double';
elems(2).Complexity = 'real';
elems(2).Min = [];
elems(2).Max = [];
elems(2).DocUnits = '';
elems(2).Description = '';

elems(3) = Simulink.BusElement;
elems(3).Name = 'mulh';
elems(3).Dimensions = 3;
elems(3).DimensionsMode = 'Fixed';
elems(3).DataType = 'double';
elems(3).Complexity = 'real';
elems(3).Min = [];
elems(3).Max = [];
elems(3).DocUnits = '';
elems(3).Description = '';

EarthEnvironmentBus = Simulink.Bus;
EarthEnvironmentBus.HeaderFile = '';
EarthEnvironmentBus.Description = '';
EarthEnvironmentBus.DataScope = 'Auto';
EarthEnvironmentBus.Alignment = -1;
EarthEnvironmentBus.PreserveElementDimensions = 0;
EarthEnvironmentBus.Elements = elems;
clear elems;
assignin('base', 'EarthEnvironmentBus', EarthEnvironmentBus);



% Bus object: EngineCommandBus
clear elems;
elems(1) = Simulink.BusElement;
elems(1).Name = 'cmdThrottle_unit';
elems(1).Dimensions = 1;
elems(1).DimensionsMode = 'Fixed';
elems(1).DataType = 'double';
elems(1).Complexity = 'real';
elems(1).Min = [];
elems(1).Max = [];
elems(1).DocUnits = '';
elems(1).Description = '';

EngineCommandBus = Simulink.Bus;
EngineCommandBus.HeaderFile = '';
EngineCommandBus.Description = '';
EngineCommandBus.DataScope = 'Auto';
EngineCommandBus.Alignment = -1;
EngineCommandBus.PreserveElementDimensions = 0;
EngineCommandBus.Elements = elems;
clear elems;
assignin('base', 'EngineCommandBus', EngineCommandBus);

% Bus object: EnvironmentBus
clear elems;
elems(1) = Simulink.BusElement;
elems(1).Name = 'EarthEnvironment';
elems(1).Dimensions = 1;
elems(1).DimensionsMode = 'Fixed';
elems(1).DataType = 'Bus: EarthEnvironmentBus';
elems(1).Complexity = 'real';
elems(1).Min = [];
elems(1).Max = [];
elems(1).DocUnits = '';
elems(1).Description = '';

elems(2) = Simulink.BusElement;
elems(2).Name = 'AirEnvironment';
elems(2).Dimensions = 1;
elems(2).DimensionsMode = 'Fixed';
elems(2).DataType = 'Bus: AirEnvironmentBus';
elems(2).Complexity = 'real';
elems(2).Min = [];
elems(2).Max = [];
elems(2).DocUnits = '';
elems(2).Description = '';

elems(3) = Simulink.BusElement;
elems(3).Name = 'TerrainEnvironment';
elems(3).Dimensions = 1;
elems(3).DimensionsMode = 'Fixed';
elems(3).DataType = 'Bus: TerrainEnvironmentBus';
elems(3).Complexity = 'real';
elems(3).Min = [];
elems(3).Max = [];
elems(3).DocUnits = '';
elems(3).Description = '';

EnvironmentBus = Simulink.Bus;
EnvironmentBus.HeaderFile = '';
EnvironmentBus.Description = '';
EnvironmentBus.DataScope = 'Auto';
EnvironmentBus.Alignment = -1;
EnvironmentBus.PreserveElementDimensions = 0;
EnvironmentBus.Elements = elems;
clear elems;
assignin('base', 'EnvironmentBus', EnvironmentBus);

% Bus object: GPSSensorBus
clear elems;
elems(1) = Simulink.BusElement;
elems(1).Name = 'device_id';
elems(1).Dimensions = 1;
elems(1).DimensionsMode = 'Fixed';
elems(1).DataType = 'double';
elems(1).Complexity = 'real';
elems(1).Min = [];
elems(1).Max = [];
elems(1).DocUnits = '';
elems(1).Description = '';

elems(2) = Simulink.BusElement;
elems(2).Name = 'lat_deg';
elems(2).Dimensions = 1;
elems(2).DimensionsMode = 'Fixed';
elems(2).DataType = 'double';
elems(2).Complexity = 'real';
elems(2).Min = [];
elems(2).Max = [];
elems(2).DocUnits = '';
elems(2).Description = '';

elems(3) = Simulink.BusElement;
elems(3).Name = 'lon_deg';
elems(3).Dimensions = 1;
elems(3).DimensionsMode = 'Fixed';
elems(3).DataType = 'double';
elems(3).Complexity = 'real';
elems(3).Min = [];
elems(3).Max = [];
elems(3).DocUnits = '';
elems(3).Description = '';

elems(4) = Simulink.BusElement;
elems(4).Name = 'alt_m';
elems(4).Dimensions = 1;
elems(4).DimensionsMode = 'Fixed';
elems(4).DataType = 'double';
elems(4).Complexity = 'real';
elems(4).Min = [];
elems(4).Max = [];
elems(4).DocUnits = '';
elems(4).Description = '';

elems(5) = Simulink.BusElement;
elems(5).Name = 'eph_m';
elems(5).Dimensions = 1;
elems(5).DimensionsMode = 'Fixed';
elems(5).DataType = 'double';
elems(5).Complexity = 'real';
elems(5).Min = [];
elems(5).Max = [];
elems(5).DocUnits = '';
elems(5).Description = '';

elems(6) = Simulink.BusElement;
elems(6).Name = 'epv_m';
elems(6).Dimensions = 1;
elems(6).DimensionsMode = 'Fixed';
elems(6).DataType = 'double';
elems(6).Complexity = 'real';
elems(6).Min = [];
elems(6).Max = [];
elems(6).DocUnits = '';
elems(6).Description = '';

elems(7) = Simulink.BusElement;
elems(7).Name = 'vel_mps';
elems(7).Dimensions = 1;
elems(7).DimensionsMode = 'Fixed';
elems(7).DataType = 'double';
elems(7).Complexity = 'real';
elems(7).Min = [];
elems(7).Max = [];
elems(7).DocUnits = '';
elems(7).Description = '';

elems(8) = Simulink.BusElement;
elems(8).Name = 'vel_n_mps';
elems(8).Dimensions = 1;
elems(8).DimensionsMode = 'Fixed';
elems(8).DataType = 'double';
elems(8).Complexity = 'real';
elems(8).Min = [];
elems(8).Max = [];
elems(8).DocUnits = '';
elems(8).Description = '';

elems(9) = Simulink.BusElement;
elems(9).Name = 'vel_e_mps';
elems(9).Dimensions = 1;
elems(9).DimensionsMode = 'Fixed';
elems(9).DataType = 'double';
elems(9).Complexity = 'real';
elems(9).Min = [];
elems(9).Max = [];
elems(9).DocUnits = '';
elems(9).Description = '';

elems(10) = Simulink.BusElement;
elems(10).Name = 'vel_d_mps';
elems(10).Dimensions = 1;
elems(10).DimensionsMode = 'Fixed';
elems(10).DataType = 'double';
elems(10).Complexity = 'real';
elems(10).Min = [];
elems(10).Max = [];
elems(10).DocUnits = '';
elems(10).Description = '';

elems(11) = Simulink.BusElement;
elems(11).Name = 'cog_deg';
elems(11).Dimensions = 1;
elems(11).DimensionsMode = 'Fixed';
elems(11).DataType = 'double';
elems(11).Complexity = 'real';
elems(11).Min = [];
elems(11).Max = [];
elems(11).DocUnits = '';
elems(11).Description = '';

% elems(12) = Simulink.BusElement;
% elems(12).Name = 'fix_type_nd';
% elems(12).Dimensions = 1;
% elems(12).DimensionsMode = 'Fixed';
% elems(12).DataType = 'uint8';
% elems(12).Complexity = 'real';
% elems(12).Min = [];
% elems(12).Max = [];
% elems(12).DocUnits = '';
% elems(12).Description = '';

elems(12) = Simulink.BusElement;
elems(12).Name = 'satellites_used_nd';
elems(12).Dimensions = 1;
elems(12).DimensionsMode = 'Fixed';
elems(12).DataType = 'double';
elems(12).Complexity = 'real';
elems(12).Min = [];
elems(12).Max = [];
elems(12).DocUnits = '';
elems(12).Description = '';

GPSSensorBus = Simulink.Bus;
GPSSensorBus.HeaderFile = '';
GPSSensorBus.Description = '';
GPSSensorBus.DataScope = 'Auto';
GPSSensorBus.Alignment = -1;
GPSSensorBus.PreserveElementDimensions = 0;
GPSSensorBus.Elements = elems;
clear elems;
assignin('base', 'GPSSensorBus', GPSSensorBus);

% Bus object: GyroSensorBus
clear elems;
elems(1) = Simulink.BusElement;
elems(1).Name = 'device_id';
elems(1).Dimensions = 1;
elems(1).DimensionsMode = 'Fixed';
elems(1).DataType = 'double';
elems(1).Complexity = 'real';
elems(1).Min = [];
elems(1).Max = [];
elems(1).DocUnits = '';
elems(1).Description = '';

elems(2) = Simulink.BusElement;
elems(2).Name = 'x_radps';
elems(2).Dimensions = 1;
elems(2).DimensionsMode = 'Fixed';
elems(2).DataType = 'double';
elems(2).Complexity = 'real';
elems(2).Min = [];
elems(2).Max = [];
elems(2).DocUnits = '';
elems(2).Description = '';

elems(3) = Simulink.BusElement;
elems(3).Name = 'y_radps';
elems(3).Dimensions = 1;
elems(3).DimensionsMode = 'Fixed';
elems(3).DataType = 'double';
elems(3).Complexity = 'real';
elems(3).Min = [];
elems(3).Max = [];
elems(3).DocUnits = '';
elems(3).Description = '';

elems(4) = Simulink.BusElement;
elems(4).Name = 'z_radps';
elems(4).Dimensions = 1;
elems(4).DimensionsMode = 'Fixed';
elems(4).DataType = 'double';
elems(4).Complexity = 'real';
elems(4).Min = [];
elems(4).Max = [];
elems(4).DocUnits = '';
elems(4).Description = '';

elems(5) = Simulink.BusElement;
elems(5).Name = 'temperature_degC';
elems(5).Dimensions = 1;
elems(5).DimensionsMode = 'Fixed';
elems(5).DataType = 'double';
elems(5).Complexity = 'real';
elems(5).Min = [];
elems(5).Max = [];
elems(5).DocUnits = '';
elems(5).Description = '';

GyroSensorBus = Simulink.Bus;
GyroSensorBus.HeaderFile = '';
GyroSensorBus.Description = '';
GyroSensorBus.DataScope = 'Auto';
GyroSensorBus.Alignment = -1;
GyroSensorBus.PreserveElementDimensions = 0;
GyroSensorBus.Elements = elems;
clear elems;
assignin('base', 'GyroSensorBus', GyroSensorBus);

% Bus object: INSSensorBus
clear elems;
elems(1) = Simulink.BusElement;
elems(1).Name = 'GyroSensorBus';
elems(1).Dimensions = 1;
elems(1).DimensionsMode = 'Fixed';
elems(1).DataType = 'GyroSensorBus';
elems(1).Complexity = 'real';
elems(1).Min = [];
elems(1).Max = [];
elems(1).DocUnits = '';
elems(1).Description = '';

elems(2) = Simulink.BusElement;
elems(2).Name = 'MagSensorBus';
elems(2).Dimensions = 1;
elems(2).DimensionsMode = 'Fixed';
elems(2).DataType = 'MagSensorBus';
elems(2).Complexity = 'real';
elems(2).Min = [];
elems(2).Max = [];
elems(2).DocUnits = '';
elems(2).Description = '';

elems(3) = Simulink.BusElement;
elems(3).Name = 'AccelSensorBus';
elems(3).Dimensions = 1;
elems(3).DimensionsMode = 'Fixed';
elems(3).DataType = 'AccelSensorBus';
elems(3).Complexity = 'real';
elems(3).Min = [];
elems(3).Max = [];
elems(3).DocUnits = '';
elems(3).Description = '';

INSSensorBus = Simulink.Bus;
INSSensorBus.HeaderFile = '';
INSSensorBus.Description = '';
INSSensorBus.DataScope = 'Auto';
INSSensorBus.Alignment = -1;
INSSensorBus.PreserveElementDimensions = 0;
INSSensorBus.Elements = elems;
clear elems;
assignin('base', 'INSSensorBus', INSSensorBus);

% Bus object: MagSensorBus
clear elems;
elems(1) = Simulink.BusElement;
elems(1).Name = 'device_id';
elems(1).Dimensions = 1;
elems(1).DimensionsMode = 'Fixed';
elems(1).DataType = 'double';
elems(1).Complexity = 'real';
elems(1).Min = [];
elems(1).Max = [];
elems(1).DocUnits = '';
elems(1).Description = '';

elems(2) = Simulink.BusElement;
elems(2).Name = 'x_Gauss';
elems(2).Dimensions = 1;
elems(2).DimensionsMode = 'Fixed';
elems(2).DataType = 'double';
elems(2).Complexity = 'real';
elems(2).Min = [];
elems(2).Max = [];
elems(2).DocUnits = '';
elems(2).Description = '';

elems(3) = Simulink.BusElement;
elems(3).Name = 'y_Gauss';
elems(3).Dimensions = 1;
elems(3).DimensionsMode = 'Fixed';
elems(3).DataType = 'double';
elems(3).Complexity = 'real';
elems(3).Min = [];
elems(3).Max = [];
elems(3).DocUnits = '';
elems(3).Description = '';

elems(4) = Simulink.BusElement;
elems(4).Name = 'z_Gauss';
elems(4).Dimensions = 1;
elems(4).DimensionsMode = 'Fixed';
elems(4).DataType = 'double';
elems(4).Complexity = 'real';
elems(4).Min = [];
elems(4).Max = [];
elems(4).DocUnits = '';
elems(4).Description = '';

elems(5) = Simulink.BusElement;
elems(5).Name = 'temperature_degC';
elems(5).Dimensions = 1;
elems(5).DimensionsMode = 'Fixed';
elems(5).DataType = 'double';
elems(5).Complexity = 'real';
elems(5).Min = [];
elems(5).Max = [];
elems(5).DocUnits = '';
elems(5).Description = '';

MagSensorBus = Simulink.Bus;
MagSensorBus.HeaderFile = '';
MagSensorBus.Description = '';
MagSensorBus.DataScope = 'Auto';
MagSensorBus.Alignment = -1;
MagSensorBus.PreserveElementDimensions = 0;
MagSensorBus.Elements = elems;
clear elems;
assignin('base', 'MagSensorBus', MagSensorBus);

% Bus object: MassPropertiesBus
clear elems;
elems(1) = Simulink.BusElement;
elems(1).Name = 'aircraftMass_kg';
elems(1).Dimensions = 1;
elems(1).DimensionsMode = 'Fixed';
elems(1).DataType = 'double';
elems(1).Complexity = 'real';
elems(1).Min = [];
elems(1).Max = [];
elems(1).DocUnits = '';
elems(1).Description = '';

elems(2) = Simulink.BusElement;
elems(2).Name = 'aircraftCg_m';
elems(2).Dimensions = 3;
elems(2).DimensionsMode = 'Fixed';
elems(2).DataType = 'double';
elems(2).Complexity = 'real';
elems(2).Min = [];
elems(2).Max = [];
elems(2).DocUnits = '';
elems(2).Description = '';

elems(3) = Simulink.BusElement;
elems(3).Name = 'aircraftInertiaInBody_kgm2';
elems(3).Dimensions = [3 3];
elems(3).DimensionsMode = 'Fixed';
elems(3).DataType = 'double';
elems(3).Complexity = 'real';
elems(3).Min = [];
elems(3).Max = [];
elems(3).DocUnits = '';
elems(3).Description = '';

elems(4) = Simulink.BusElement;
elems(4).Name = 'fuelLevelFraction';
elems(4).Dimensions = 1;
elems(4).DimensionsMode = 'Fixed';
elems(4).DataType = 'double';
elems(4).Complexity = 'real';
elems(4).Min = [];
elems(4).Max = [];
elems(4).DocUnits = '';
elems(4).Description = '';

MassPropertiesBus = Simulink.Bus;
MassPropertiesBus.HeaderFile = '';
MassPropertiesBus.Description = '';
MassPropertiesBus.DataScope = 'Auto';
MassPropertiesBus.Alignment = -1;
MassPropertiesBus.PreserveElementDimensions = 0;
MassPropertiesBus.Elements = elems;
clear elems;
assignin('base','MassPropertiesBus', MassPropertiesBus);

% Bus object: SensorsBus
clear elems;
elems(1) = Simulink.BusElement;
elems(1).Name = 'GPSSensorBus';
elems(1).Dimensions = 1;
elems(1).DimensionsMode = 'Fixed';
elems(1).DataType = 'Bus: GPSSensorBus';
elems(1).Complexity = 'real';
elems(1).Min = [];
elems(1).Max = [];
elems(1).DocUnits = '';
elems(1).Description = '';

elems(2) = Simulink.BusElement;
elems(2).Name = 'INSSensorBus';
elems(2).Dimensions = 1;
elems(2).DimensionsMode = 'Fixed';
elems(2).DataType = 'Bus: INSSensorBus';
elems(2).Complexity = 'real';
elems(2).Min = [];
elems(2).Max = [];
elems(2).DocUnits = '';
elems(2).Description = '';

elems(3) = Simulink.BusElement;
elems(3).Name = 'ADCSensorBus';
elems(3).Dimensions = 1;
elems(3).DimensionsMode = 'Fixed';
elems(3).DataType = 'Bus: ADCSensorBus';
elems(3).Complexity = 'real';
elems(3).Min = [];
elems(3).Max = [];
elems(3).DocUnits = '';
elems(3).Description = '';

SensorsBus = Simulink.Bus;
SensorsBus.HeaderFile = '';
SensorsBus.Description = '';
SensorsBus.DataScope = 'Auto';
SensorsBus.Alignment = -1;
SensorsBus.PreserveElementDimensions = 0;
SensorsBus.Elements = elems;
clear elems;
assignin('base', 'SensorsBus', SensorsBus);




% Bus object: TerrainEnvironmentBus
clear elems;
elems(1) = Simulink.BusElement;
elems(1).Name = 'terrainHeightInNED_m';
elems(1).Dimensions = 1;
elems(1).DimensionsMode = 'Fixed';
elems(1).DataType = 'double';
elems(1).Complexity = 'real';
elems(1).Min = [];
elems(1).Max = [];
elems(1).DocUnits = '';
elems(1).Description = '';

TerrainEnvironmentBus = Simulink.Bus;
TerrainEnvironmentBus.HeaderFile = '';
TerrainEnvironmentBus.Description = '';
TerrainEnvironmentBus.DataScope = 'Auto';
TerrainEnvironmentBus.Alignment = -1;
TerrainEnvironmentBus.PreserveElementDimensions = 0;
TerrainEnvironmentBus.Elements = elems;
clear elems;
assignin('base', 'TerrainEnvironmentBus', TerrainEnvironmentBus);

% Bus object: VehicleBus
clear elems;
elems(1) = Simulink.BusElement;
elems(1).Name = 'VehicleConfiguration';
elems(1).Dimensions = 1;
elems(1).DimensionsMode = 'Fixed';
elems(1).DataType = 'Bus: VehicleConfigurationBus';
elems(1).Complexity = 'real';
elems(1).Min = [];
elems(1).Max = [];
elems(1).DocUnits = '';
elems(1).Description = '';

elems(2) = Simulink.BusElement;
elems(2).Name = 'BodyStates';
elems(2).Dimensions = 1;
elems(2).DimensionsMode = 'Fixed';
elems(2).DataType = 'Bus: BodyStateBus';
elems(2).Complexity = 'real';
elems(2).Min = [];
elems(2).Max = [];
elems(2).DocUnits = '';
elems(2).Description = '';

elems(3) = Simulink.BusElement;
elems(3).Name = 'MassProperties';
elems(3).Dimensions = 1;
elems(3).DimensionsMode = 'Fixed';
elems(3).DataType = 'Bus: MassPropertiesBus';
elems(3).Complexity = 'real';
elems(3).Min = [];
elems(3).Max = [];
elems(3).DocUnits = '';
elems(3).Description = '';

elems(4) = Simulink.BusElement;
elems(4).Name = 'AircraftForcesMoments';
elems(4).Dimensions = 1;
elems(4).DimensionsMode = 'Fixed';
elems(4).DataType = 'Bus: AircraftForcesMomentsBus';
elems(4).Complexity = 'real';
elems(4).Min = [];
elems(4).Max = [];
elems(4).DocUnits = '';
elems(4).Description = '';

elems(5) = Simulink.BusElement;
elems(5).Name = 'AirData';
elems(5).Dimensions = 1;
elems(5).DimensionsMode = 'Fixed';
elems(5).DataType = 'Bus: AirDataBus';
elems(5).Complexity = 'real';
elems(5).Min = [];
elems(5).Max = [];
elems(5).DocUnits = '';
elems(5).Description = '';

VehicleBus = Simulink.Bus;
VehicleBus.HeaderFile = '';
VehicleBus.Description = '';
VehicleBus.DataScope = 'Auto';
VehicleBus.Alignment = -1;
VehicleBus.PreserveElementDimensions = 0;
VehicleBus.Elements = elems;
clear elems;
assignin('base', 'VehicleBus', VehicleBus);

% Bus object: VehicleConfigurationBus
clear elems;
elems(1) = Simulink.BusElement;
elems(1).Name = 'isVehicleAirborne';
elems(1).Dimensions = 1;
elems(1).DimensionsMode = 'Fixed';
elems(1).DataType = 'boolean';
elems(1).Complexity = 'real';
elems(1).Min = [];
elems(1).Max = [];
elems(1).DocUnits = '';
elems(1).Description = '';

elems(2) = Simulink.BusElement;
elems(2).Name = 'groundCollision';
elems(2).Dimensions = 1;
elems(2).DimensionsMode = 'Fixed';
elems(2).DataType = 'boolean';
elems(2).Complexity = 'real';
elems(2).Min = [];
elems(2).Max = [];
elems(2).DocUnits = '';
elems(2).Description = '';

VehicleConfigurationBus = Simulink.Bus;
VehicleConfigurationBus.HeaderFile = '';
VehicleConfigurationBus.Description = '';
VehicleConfigurationBus.DataScope = 'Auto';
VehicleConfigurationBus.Alignment = -1;
VehicleConfigurationBus.PreserveElementDimensions = 0;
VehicleConfigurationBus.Elements = elems;
clear elems;
assignin('base', 'VehicleConfigurationBus', VehicleConfigurationBus);

end