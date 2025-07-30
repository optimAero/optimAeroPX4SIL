% servosCommandBusDefinition: This function defines the servo command bus signals. If you're importing your
% own vehicle design, replace the servosCommandCustomAircraftBusDefinition with your own vehicle servo command 
% bus definition.
function servosCommandBusDefinition(vehicleType) 
% Bus object: ServosCommandBus

switch lower(vehicleType)
    case "f-16"
        % F16 servo command bus definition
        servosCommandF16BusDefinition
        elems(1) = Simulink.BusElement;
        elems(1).Name = 'ServosCommandF16';
        elems(1).Dimensions = 1;
        elems(1).DimensionsMode = 'Fixed';
        elems(1).DataType = 'Bus: ServosCommandF16Bus';
        elems(1).Complexity = 'real';
        elems(1).Min = [];
        elems(1).Max = [];
        elems(1).DocUnits = '';
        elems(1).Description = '';

        ServosCommandBus = Simulink.Bus;
        ServosCommandBus.HeaderFile = '';
        ServosCommandBus.Description = '';
        ServosCommandBus.DataScope = 'Auto';
        ServosCommandBus.Alignment = -1;
        ServosCommandBus.PreserveElementDimensions = 0;
        ServosCommandBus.Elements = elems;
        clear elems;
        assignin('base', 'ServosCommandBus', ServosCommandBus);
    case "hexarotor"
        motorCommandHexBusDefinition
        elems(1) = Simulink.BusElement;
        elems(1).Name = 'MotorCommandHex';
        elems(1).Dimensions = 1;
        elems(1).DimensionsMode = 'Fixed';
        elems(1).DataType = 'Bus: MotorCommandHexBus';
        elems(1).Complexity = 'real';
        elems(1).Min = [];
        elems(1).Max = [];
        elems(1).DocUnits = '';
        elems(1).Description = '';

        ServosCommandBus = Simulink.Bus;
        ServosCommandBus.HeaderFile = '';
        ServosCommandBus.Description = '';
        ServosCommandBus.DataScope = 'Auto';
        ServosCommandBus.Alignment = -1;
        ServosCommandBus.PreserveElementDimensions = 0;
        ServosCommandBus.Elements = elems;
        assignin('base', 'ServosCommandBus', ServosCommandBus);
    case "customAircraft"
        % Custom aircraft servo command bus definition
        servosCommandCustomAircraftBusDefinition
        elems(1) = Simulink.BusElement;
        elems(1).Name = 'ServosCommandCustomAircraft';
        elems(1).Dimensions = 1;
        elems(1).DimensionsMode = 'Fixed';
        elems(1).DataType = 'Bus: ServosCommandCustomAircraftBus';
        elems(1).Complexity = 'real';
        elems(1).Min = [];
        elems(1).Max = [];
        elems(1).DocUnits = '';
        elems(1).Description = '';

        ServosCommandBus = Simulink.Bus;
        ServosCommandBus.HeaderFile = '';
        ServosCommandBus.Description = '';
        ServosCommandBus.DataScope = 'Auto';
        ServosCommandBus.Alignment = -1;
        ServosCommandBus.PreserveElementDimensions = 0;
        ServosCommandBus.Elements = elems;
        clear elems;
        assignin('base', 'ServosCommandBus', ServosCommandBus);

    otherwise
        error(char(["unknown vehicle: " vehicleType]))

end






