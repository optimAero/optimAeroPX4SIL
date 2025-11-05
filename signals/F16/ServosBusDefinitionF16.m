function servosBusDefinitionF16() 
% Bus object: ServosF16Bus
% These are the servo commands for the F16 vehicle
n = 1;
clear elems;
elems(n) = Simulink.BusElement;
elems(n).Name = 'posAileron_rad';
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
elems(n).Name = 'posRudder_rad';
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
elems(n).Name = 'posElevator_rad';
elems(n).Dimensions = 1;
elems(n).DimensionsMode = 'Fixed';
elems(n).DataType = 'double';
elems(n).Complexity = 'real';
elems(n).Min = [];
elems(n).Max = [];
elems(n).DocUnits = '';
elems(n).Description = '';

ServosF16Bus = Simulink.Bus;
ServosF16Bus.HeaderFile = '';
ServosF16Bus.Description = '';
ServosF16Bus.DataScope = 'Auto';
ServosF16Bus.Alignment = -1;
ServosF16Bus.PreserveElementDimensions = 0;
ServosF16Bus.Elements = elems;
clear elems;
assignin('base','ServosF16Bus', ServosF16Bus);