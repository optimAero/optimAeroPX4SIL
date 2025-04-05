function motorCommandHexBusDefinition() 
% Bus object: motorCommandHexBus 

for ii = 1:6
    elems(ii) = Simulink.BusElement;
    elems(ii).Name = sprintf('cmdRotor%d_nd',ii);
    elems(ii).Dimensions = 1;
    elems(ii).DimensionsMode = 'Fixed';
    elems(ii).DataType = 'double';
    elems(ii).Complexity = 'real';
    elems(ii).Min = [];
    elems(ii).Max = [];
    elems(ii).DocUnits = '';
    elems(ii).Description = '';
end


MotorCommandHexBus = Simulink.Bus;
MotorCommandHexBus.HeaderFile = '';
MotorCommandHexBus.Description = '';
MotorCommandHexBus.DataScope = 'Auto';
MotorCommandHexBus.Alignment = -1;
MotorCommandHexBus.PreserveElementDimensions = 0;
MotorCommandHexBus.Elements = elems;
assignin('base','MotorCommandHexBus', MotorCommandHexBus);
