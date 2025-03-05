function servosCommandCustomAircraftBusDefinition() 
% Bus object: ServosCommandCustomAircraftBus 

n = 1;
elems(n) = Simulink.BusElement;
elems(n).Name = 'cmdControlSurfaceOne_nd';
elems(n).Dimensions = 1;
elems(n).DimensionsMode = 'Fixed';
elems(n).DataType = 'double';
elems(n).Complexity = 'real';
elems(n).Min = [];
elems(n).Max = [];
elems(n).DocUnits = '';
elems(n).Description = '';
n = n +1;

elems(n) = Simulink.BusElement;
elems(n).Name = 'cmdControlSurfaceTwo_nd';
elems(n).Dimensions = 1;
elems(n).DimensionsMode = 'Fixed';
elems(n).DataType = 'double';
elems(n).Complexity = 'real';
elems(n).Min = [];
elems(n).Max = [];
elems(n).DocUnits = '';
elems(n).Description = '';

ServosCommandCustomAircraftBus = Simulink.Bus;
ServosCommandCustomAircraftBus.HeaderFile = '';
ServosCommandCustomAircraftBus.Description = '';
ServosCommandCustomAircraftBus.DataScope = 'Auto';
ServosCommandCustomAircraftBus.Alignment = -1;
ServosCommandCustomAircraftBus.PreserveElementDimensions = 0;
ServosCommandCustomAircraftBus.Elements = elems;
clear elems;
assignin('base', 'ServosCommandCustomAircraftBus', ServosCommandCustomAircraftBus);
