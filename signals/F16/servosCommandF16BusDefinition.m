function servosCommandF16BusDefinition() 
% Bus object: ServosCommandF16Bus 

n = 1;
elems(n) = Simulink.BusElement;
elems(n).Name = 'cmdAileron_nd';
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
elems(n).Name = 'cmdElevator_nd';
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
elems(n).Name = 'cmdRudder_nd';
elems(n).Dimensions = 1;
elems(n).DimensionsMode = 'Fixed';
elems(n).DataType = 'double';
elems(n).Complexity = 'real';
elems(n).Min = [];
elems(n).Max = [];
elems(n).DocUnits = '';
elems(n).Description = '';

ServosCommandF16Bus = Simulink.Bus;
ServosCommandF16Bus.HeaderFile = '';
ServosCommandF16Bus.Description = '';
ServosCommandF16Bus.DataScope = 'Auto';
ServosCommandF16Bus.Alignment = -1;
ServosCommandF16Bus.PreserveElementDimensions = 0;
ServosCommandF16Bus.Elements = elems;
clear elems;
assignin('base','ServosCommandF16Bus', ServosCommandF16Bus);
