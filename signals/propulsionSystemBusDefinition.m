% propulsionSystemBusDefinition:
function propulsionSystemBusDefinition(vehicleType)
% Bus object: PropulsionBus

switch lower(vehicleType)
    case "f-16"
        % Bus object: PropulsionBus
        clear elems;
        elems(1) = Simulink.BusElement;
        elems(1).Name = 'angVel_radps';
        elems(1).Dimensions = 1;
        elems(1).DimensionsMode = 'Fixed';
        elems(1).DataType = 'double';
        elems(1).Complexity = 'real';
        elems(1).Min = [];
        elems(1).Max = [];
        elems(1).DocUnits = '';
        elems(1).Description = '';

        elems(2) = Simulink.BusElement;
        elems(2).Name = 'engineForcesMoments';
        elems(2).Dimensions = 1;
        elems(2).DimensionsMode = 'Fixed';
        elems(2).DataType = 'Bus: ComponentForcesMomentsBus';
        elems(2).Complexity = 'real';
        elems(2).Min = [];
        elems(2).Max = [];
        elems(2).DocUnits = '';
        elems(2).Description = '';

        elems(3) = Simulink.BusElement;
        elems(3).Name = 'fuelRate_kgps';
        elems(3).Dimensions = 1;
        elems(3).DimensionsMode = 'Fixed';
        elems(3).DataType = 'double';
        elems(3).Complexity = 'real';
        elems(3).Min = [];
        elems(3).Max = [];
        elems(3).DocUnits = '';
        elems(3).Description = '';

        PropulsionBus = Simulink.Bus;
        PropulsionBus.HeaderFile = '';
        PropulsionBus.Description = '';
        PropulsionBus.DataScope = 'Auto';
        PropulsionBus.Alignment = -1;
        PropulsionBus.PreserveElementDimensions = 0;
        PropulsionBus.Elements = elems;
        assignin('base', 'PropulsionBus', PropulsionBus);
    case "hexarotor"
        elems(1) = Simulink.BusElement;
        elems(1).Name = 'rotorAngVel_radps';
        elems(1).Dimensions = 6;
        elems(1).DimensionsMode = 'Fixed';
        elems(1).DataType = 'double';
        elems(1).Complexity = 'real';
        elems(1).Min = [];
        elems(1).Max = [];
        elems(1).DocUnits = '';
        elems(1).Description = '';

        elems(2) = Simulink.BusElement;
        elems(2).Name = 'engineForcesMoments';
        elems(2).Dimensions = 1;
        elems(2).DimensionsMode = 'Fixed';
        elems(2).DataType = 'Bus: ComponentForcesMomentsBus';
        elems(2).Complexity = 'real';
        elems(2).Min = [];
        elems(2).Max = [];
        elems(2).DocUnits = '';
        elems(2).Description = '';

        PropulsionBus = Simulink.Bus;
        PropulsionBus.HeaderFile = '';
        PropulsionBus.Description = '';
        PropulsionBus.DataScope = 'Auto';
        PropulsionBus.Alignment = -1;
        PropulsionBus.PreserveElementDimensions = 0;
        PropulsionBus.Elements = elems;
        assignin('base', 'PropulsionBus', PropulsionBus);
    case "customAircraft"
        % Custom aircraft servo command bus definition
        servosCommandCustomAircraftBusDefinition
        elems(1) = Simulink.BusElement;
        elems(1).Name = 'PropulsionSystemCustomAircraftBus';
        elems(1).Dimensions = 1;
        elems(1).DimensionsMode = 'Fixed';
        elems(1).DataType = 'Bus: PropulsionSystemCustomAircraftBus';
        elems(1).Complexity = 'real';
        elems(1).Min = [];
        elems(1).Max = [];
        elems(1).DocUnits = '';
        elems(1).Description = '';

        PropulsionBus = Simulink.Bus;
        PropulsionBus.HeaderFile = '';
        PropulsionBus.Description = '';
        PropulsionBus.DataScope = 'Auto';
        PropulsionBus.Alignment = -1;
        PropulsionBus.PreserveElementDimensions = 0;
        PropulsionBus.Elements = elems;
        clear elems;
        assignin('base', 'ServosCommandBus', PropulsionBus);

    otherwise
        error(char(["unknown vehicle: " vehicleType]))

end






