function servosBusDefinitionHex() 
% Bus object: ServosHexBus
% These are the servo commands for the hexarotor vehicle
for ii = 1:6
    elems(ii) = Simulink.BusElement;
    elems(ii).Name = sprintf('rotor%s_rpm', num2str(ii));
    elems(ii).Dimensions = 1;
    elems(ii).DimensionsMode = 'Fixed';
    elems(ii).DataType = 'double';
    elems(ii).Complexity = 'real';
    elems(ii).Min = [];
    elems(ii).Max = [];
    elems(ii).DocUnits = '';
    elems(ii).Description = '';
end

ServosHexBus = Simulink.Bus;
ServosHexBus.HeaderFile = '';
ServosHexBus.Description = '';
ServosHexBus.DataScope = 'Auto';
ServosHexBus.Alignment = -1;
ServosHexBus.PreserveElementDimensions = 0;
ServosHexBus.Elements = elems;
assignin('base','ServosHexBus', ServosHexBus);