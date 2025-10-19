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
        % Custom aircraft failureBus bus definition
        disp("Place Failure Bus for custom aircraft here")

    otherwise
        error(char(["unknown vehicle: " vehicleType]))

end






