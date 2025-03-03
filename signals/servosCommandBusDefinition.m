function servosCommandBusDefinition() 
% Bus object: ServosCommandBus 

% F16 servo command bus definition
servosCommandF16BusDefinition
% Custom aircraft servo command bus definition 
servosCommandCustomAircraftBusDefinition

n = 1;
elems(n) = Simulink.BusElement;
elems(n).Name = 'ServosCommandF16Bus';
elems(n).Dimensions = 1;
elems(n).DimensionsMode = 'Fixed';
elems(n).DataType = 'Bus: ServosCommandF16Bus';
elems(n).Complexity = 'real';
elems(n).Min = [];
elems(n).Max = [];
elems(n).DocUnits = '';
elems(n).Description = '';

n = n + 1;
elems(n) = Simulink.BusElement;
elems(n).Name = 'ServosCommandCustomAircraftBus';
elems(n).Dimensions = 1;
elems(n).DimensionsMode = 'Fixed';
elems(n).DataType = 'Bus: ServosCommandCustomAircraftBus';
elems(n).Complexity = 'real';
elems(n).Min = [];
elems(n).Max = [];
elems(n).DocUnits = '';
elems(n).Description = '';

ServosCommandBus = Simulink.Bus;
ServosCommandBus.HeaderFile = '';
ServosCommandBus.Description = '';
ServosCommandBus.DataScope = 'Auto';
ServosCommandBus.Alignment = -1;
ServosCommandBus.PreserveElementDimensions = 0;
ServosCommandBus.Elements = elems;
clear elems;
assignin('base', 'ServosCommandBus', ServosCommandBus);
