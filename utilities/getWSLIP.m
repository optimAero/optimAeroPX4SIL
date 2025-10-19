[status, result] = system('powershell -Command "Get-NetIPAddress -InterfaceAlias ''vEthernet (WSL)'' | Where-Object {$_.AddressFamily -eq ''IPv4''} | Select-Object -ExpandProperty IPAddress"');

if status == 0 && ~isempty(strtrim(result))
    wslVEip = strtrim(result);  % Remove any leading/trailing whitespace
    fprintf('WSL vEthernet IP: %s\n', wslVEip);
else
    wslVEip = '';
    error(['Could not retrieve WSL vEthernet IP. Please re-run initVehicleSIL and enter in your WSL IP' ...
        ' address as an argument, or, start WSL.']);
end
