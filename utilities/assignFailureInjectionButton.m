% assignFailureInjectionButton: This function assigns a button on your joystick to the failure injection that the user
% chooses.
function assignFailureInjectionButton()
mdl = 'joystickFailureInjectionButtonDetection';
load_system(mdl)
try
   disp(['Hold the joystick button that you want to use to trigger a vehicle failure AND then press the ' ...
       'SPACE BAR while in the terminal...'])
   pause()
   simOut = sim(mdl); 
   if simOut.yout{1}.Values.Data(end) == 0
       error("A button was not held for the duration of this script, try running this script again while" + ...
           " holding a button on your joystick.")
   end
   assignin('caller','failureInjectionButton',simOut.yout{1}.Values.Data(end))
   disp('Failure injection button has been mapped!')
catch ME
    error(ME.message)
end

end