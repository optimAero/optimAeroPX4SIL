function propulsionSystemHexBusDefinition() 
% Bus object: propulsionSystemHexBusDefinition 

ii = 1;
elems(ii) = Simulink.BusElement;
elems(ii).Name = sprintf('rotorAngVel_radps',ii);
elems(ii).Dimensions = 6;
elems(ii).DimensionsMode = 'Fixed';
elems(ii).DataType = 'double';
elems(ii).Complexity = 'real';
elems(ii).Min = [];
elems(ii).Max = [];
elems(ii).DocUnits = '';
elems(ii).Description = '';

ii = ii + 1;
elems(ii) = Simulink.BusElement;
elems(ii).Name = 'engineForcesMoments';
elems(ii).Dimensions = 1;
elems(ii).DimensionsMode = 'Fixed';
elems(ii).DataType = 'Bus: ComponentForcesMomentsBus';
elems(ii).Complexity = 'real';
elems(ii).Min = [];
elems(ii).Max = [];
elems(ii).DocUnits = '';
elems(ii).Description = '';

PropulsionSystemHexBus = Simulink.Bus;
PropulsionSystemHexBus.HeaderFile = '';
PropulsionSystemHexBus.Description = '';
PropulsionSystemHexBus.DataScope = 'Auto';
PropulsionSystemHexBus.Alignment = -1;
PropulsionSystemHexBus.PreserveElementDimensions = 0;
PropulsionSystemHexBus.Elements = elems;
assignin('base','PropulsionSystemHexBus', PropulsionSystemHexBus);
