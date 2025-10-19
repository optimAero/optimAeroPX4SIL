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


FailureBus = Simulink.Bus;
FailureBus.HeaderFile = '';
FailureBus.Description = '';
FailureBus.DataScope = 'Auto';
FailureBus.Alignment = -1;
FailureBus.PreserveElementDimensions = 0;
FailureBus.Elements = elems;
assignin('base','FailureBus', FailureBus);
