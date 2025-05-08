function failureHexBusDefinition() 
% Bus object: failureHexBus

for ii = 1:6
    elems(ii) = Simulink.BusElement;
    elems(ii).Name = sprintf('rotorFailure%d_nd',ii);
    elems(ii).Dimensions = 1;
    elems(ii).DimensionsMode = 'Fixed';
    elems(ii).DataType = 'boolean';
    elems(ii).Complexity = 'real';
    elems(ii).Min = [];
    elems(ii).Max = [];
    elems(ii).DocUnits = '';
    elems(ii).Description = '';
end


FailureHexBus = Simulink.Bus;
FailureHexBus.HeaderFile = '';
FailureHexBus.Description = '';
FailureHexBus.DataScope = 'Auto';
FailureHexBus.Alignment = -1;
FailureHexBus.PreserveElementDimensions = 0;
FailureHexBus.Elements = elems;
assignin('base','FailureHexBus', FailureHexBus);
