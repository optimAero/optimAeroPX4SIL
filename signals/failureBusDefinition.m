% failureBusDefinition: 
function failureBusDefinition(vehicleType) 
% Bus object: failureBus

switch lower(vehicleType)
    case "f-16"
        % F16 servo command bus definition
        failureF16BusDefinition
        
    case "hexarotor"
        failureHexBusDefinition

    case "customAircraft"
        % Custom aircraft servo command bus definition
        servosCommandCustomAircraftBusDefinition
        elems(1) = Simulink.BusElement;
        elems(1).Name = 'ServosCommandCustomAircraftBus';
        elems(1).Dimensions = 1;
        elems(1).DimensionsMode = 'Fixed';
        elems(1).DataType = 'Bus: ServosCommandCustomAircraftBus';
        elems(1).Complexity = 'real';
        elems(1).Min = [];
        elems(1).Max = [];
        elems(1).DocUnits = '';
        elems(1).Description = '';

        FailureBus = Simulink.Bus;
        FailureBus.HeaderFile = '';
        FailureBus.Description = '';
        FailureBus.DataScope = 'Auto';
        FailureBus.Alignment = -1;
        FailureBus.PreserveElementDimensions = 0;
        FailureBus.Elements = elems;
        clear elems;
        assignin('base', 'FailureBus', FailureBus);

    otherwise
        error(char(["unknown vehicle: " vehicleType]))

end






