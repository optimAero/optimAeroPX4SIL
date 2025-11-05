% failureBusDefinition: 
function FailureBusDefinition(vehicleType) 
% Bus object: failureBus

switch lower(vehicleType)
    case "f-16"
        % F16 servo command bus definition
        FailureF16BusDefinition
        
    case "hexarotor"
        FailureHexBusDefinition

    case "customAircraft"
        % Custom aircraft failureBus bus definition
        disp("Place Failure Bus for custom aircraft here")

    otherwise
        error(char(["unknown vehicle: " vehicleType]))

end






