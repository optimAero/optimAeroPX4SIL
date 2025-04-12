
function servosBusDefinition(vehicleType)
% Note: For new vehicle designs, servo command busses can be added here.

switch lower(vehicleType)
    case "f-16"
        % Call bus definition for F16
        servosBusDefinitionF16
        elems(1) = Simulink.BusElement;
        elems(1).Name = 'ServosF16Bus';
        elems(1).Dimensions = 1;
        elems(1).DimensionsMode = 'Fixed';
        elems(1).DataType   = 'Bus: ServosF16Bus';
        elems(1).Complexity = 'real';
        elems(1).Min = [];
        elems(1).Max = [];
        elems(1).DocUnits = '';
        elems(1).Description = '';

        ServosBus = Simulink.Bus;
        ServosBus.HeaderFile = '';
        ServosBus.Description = '';
        ServosBus.DataScope = 'Auto';
        ServosBus.Alignment = -1;
        ServosBus.PreserveElementDimensions = 0;
        ServosBus.Elements = elems;
        clear elems;
        assignin('base', 'ServosBus', ServosBus);
    case "hexarotor"
        % Call bus definition for Hex
        servosBusDefinitionHex
        elems(1) = Simulink.BusElement;
        elems(1).Name = 'ServosHexBus';
        elems(1).Dimensions = 1;
        elems(1).DimensionsMode = 'Fixed';
        elems(1).DataType   = 'Bus: ServosHexBus';
        elems(1).Complexity = 'real';
        elems(1).Min = [];
        elems(1).Max = [];
        elems(1).DocUnits = '';
        elems(1).Description = '';

        ServosBus = Simulink.Bus;
        ServosBus.HeaderFile = '';
        ServosBus.Description = '';
        ServosBus.DataScope = 'Auto';
        ServosBus.Alignment = -1;
        ServosBus.PreserveElementDimensions = 0;
        ServosBus.Elements = elems;
        clear elems;
        assignin('base', 'ServosBus', ServosBus);
    case "customAircraft"
        % Call bus definition for Custom Aircraft
        servosBusDefinitionCustomAircraft
        elems(1) = Simulink.BusElement;
        elems(1).Name = 'ServosCustomAircraftBus';
        elems(1).Dimensions = 1;
        elems(1).DimensionsMode = 'Fixed';
        elems(1).DataType   = 'Bus: ServosCustomAircraftBus';
        elems(1).Complexity = 'real';
        elems(1).Min = [];
        elems(1).Max = [];
        elems(1).DocUnits = '';
        elems(1).Description = '';

        ServosBus = Simulink.Bus;
        ServosBus.HeaderFile = '';
        ServosBus.Description = '';
        ServosBus.DataScope = 'Auto';
        ServosBus.Alignment = -1;
        ServosBus.PreserveElementDimensions = 0;
        ServosBus.Elements = elems;
        clear elems;
        assignin('base', 'ServosBus', ServosBus);
    otherwise
        error(char(["unknown vehicle: " vehicleType]))

end







