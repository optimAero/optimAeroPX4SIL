function servosBusDefinitionCustomAircraft() 
% Bus object: ServosCustomAircraftBus
% These are the servo commands for the F16 vehicle
n = 1;
clear elems;
elems(n) = Simulink.BusElement;
elems(n).Name = 'posControlSurfaceOne_rad';
elems(n).Dimensions = 1;
elems(n).DimensionsMode = 'Fixed';
elems(n).DataType = 'double';
elems(n).Complexity = 'real';
elems(n).Min = [];
elems(n).Max = [];
elems(n).DocUnits = '';
elems(n).Description = '';
n = n + 1;

elems(n) = Simulink.BusElement;
elems(n).Name = 'posControlSurfaceTwo_rad';
elems(n).Dimensions = 1;
elems(n).DimensionsMode = 'Fixed';
elems(n).DataType = 'double';
elems(n).Complexity = 'real';
elems(n).Min = [];
elems(n).Max = [];
elems(n).DocUnits = '';
elems(n).Description = '';


ServosCustomAircraftBus = Simulink.Bus;
ServosCustomAircraftBus.HeaderFile = '';
ServosCustomAircraftBus.Description = '';
ServosCustomAircraftBus.DataScope = 'Auto';
ServosCustomAircraftBus.Alignment = -1;
ServosCustomAircraftBus.PreserveElementDimensions = 0;
ServosCustomAircraftBus.Elements = elems;
clear elems;
assignin('base', 'ServosCustomAircraftBus', ServosCustomAircraftBus);