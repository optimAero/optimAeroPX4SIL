function servosBusDefinition() 
% Note: For new vehicle designs, servo command busses can be added here.

% Call bus definition for F16
servosBusDefinitionF16
% Call bus definition for Custom Aircraft
servosBusDefinitionCustomAircraft

n = 1;
elems(n) = Simulink.BusElement;
elems(n).Name = 'ServosF16Bus';
elems(n).Dimensions = 1;
elems(n).DimensionsMode = 'Fixed';
elems(n).DataType   = 'Bus: ServosF16Bus';
elems(n).Complexity = 'real';
elems(n).Min = [];
elems(n).Max = [];
elems(n).DocUnits = '';
elems(n).Description = '';

n = n + 1;
elems(n) = Simulink.BusElement;
elems(n).Name = 'ServosCustomAircraftBus';
elems(n).Dimensions = 1;
elems(n).DimensionsMode = 'Fixed';
elems(n).DataType   = 'Bus: ServosCustomAircraftBus';
elems(n).Complexity = 'real';
elems(n).Min = [];
elems(n).Max = [];
elems(n).DocUnits = '';
elems(n).Description = '';

ServosBus = Simulink.Bus;
ServosBus.HeaderFile = '';
ServosBus.Description = '';
ServosBus.DataScope = 'Auto';
ServosBus.Alignment = -1;
ServosBus.PreserveElementDimensions = 0;
ServosBus.Elements = elems;
clear elems;
assignin('base', 'ServosBus', ServosBus);