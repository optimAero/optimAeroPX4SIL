function failureF16BusDefinition() 
% Bus object: failureHexBus

ii = 1;
elems(ii) = Simulink.BusElement;
elems(ii).Name = 'rudderFreeze_isTrue';
elems(ii).Dimensions = 1;
elems(ii).DimensionsMode = 'Fixed';
elems(ii).DataType = 'boolean';
elems(ii).Complexity = 'real';
elems(ii).Min = [];
elems(ii).Max = [];
elems(ii).DocUnits = '';
elems(ii).Description = '';

ii = 2;
elems(ii) = Simulink.BusElement;
elems(ii).Name = 'elevatorFreeze_isTrue';
elems(ii).Dimensions = 1;
elems(ii).DimensionsMode = 'Fixed';
elems(ii).DataType = 'boolean';
elems(ii).Complexity = 'real';
elems(ii).Min = [];
elems(ii).Max = [];
elems(ii).DocUnits = '';
elems(ii).Description = '';

ii = 3;
elems(ii) = Simulink.BusElement;
elems(ii).Name = 'aileronsFreeze_isTrue';
elems(ii).Dimensions = 1;
elems(ii).DimensionsMode = 'Fixed';
elems(ii).DataType = 'boolean';
elems(ii).Complexity = 'real';
elems(ii).Min = [];
elems(ii).Max = [];
elems(ii).DocUnits = '';
elems(ii).Description = '';

ii = 4;
elems(ii) = Simulink.BusElement;
elems(ii).Name = 'engineFailure_isTrue';
elems(ii).Dimensions = 1;
elems(ii).DimensionsMode = 'Fixed';
elems(ii).DataType = 'boolean';
elems(ii).Complexity = 'real';
elems(ii).Min = [];
elems(ii).Max = [];
elems(ii).DocUnits = '';
elems(ii).Description = '';

FailureBus = Simulink.Bus;
FailureBus.HeaderFile = '';
FailureBus.Description = '';
FailureBus.DataScope = 'Auto';
FailureBus.Alignment = -1;
FailureBus.PreserveElementDimensions = 0;
FailureBus.Elements = elems;
assignin('base','FailureBus', FailureBus);
