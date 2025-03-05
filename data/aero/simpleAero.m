function [CF, CM] = simpleAero(alpha_rad, beta_rad, angularRates_radps, elevatorLeft_rad, ...
    elevatorRight_rad, rudderLeft_rad, rudderRight_rad)
    % TED (positive) deflection of left elevator generates negative yaw
    % TEL (positive) deflection of rudder generates negative yaw

    % ================================ Control power ================================
    % Assumed that control surfaces do not effect forces, just moments.

    % Roll:
    dCML_dElevator_prad  = 0.01; 
    dCML_dRudder_prad    = 0.001; 

    % Pitch
    dCMM_dElevator_prad  = -0.01; 
    dCMM_dRudder_prad    = -0.0001; 
    % Yaw
    dCMN_dElevator_prad  = -0.0001; 
    dCMN_dRudder_prad    = -0.05; 
    % ================================ Forces ================================
    CL_alpha_prad = 5.7;  % per radian
    CL0 = 0.05; 
    CL = CL0 + CL_alpha_prad * alpha_rad;
    
    e = 0.8; % Oswald efficiency factor, which typically ranges from about 0.7 to 0.95
    AR = 7;
    k = 1 / (pi * AR * e);
    CD0 = 0.055;
    CD = CD0 + k * CL ^ 2; % Drag coefficient 

    CY_beta_prad = -0.01;
    CY = CY_beta_prad * beta_rad;
    
    R2 = [cos(alpha_rad), 0, -sin(alpha_rad), 
         0 1 0; 
        sin(alpha_rad), 0, cos(alpha_rad)];
    Rn3 = [cos(-beta_rad), sin(-beta_rad), 0; 
          -sin(-beta_rad), cos(-beta_rad), 0; 
          0, 0, 1];
    R_wind2bod = R2 * Rn3;

    CF = R_wind2bod * [-CD; CY; -CL];   %Force coefficient
    
    % ================================ Moments ================================

    p_radps = angularRates_radps(1);
    q_radps = angularRates_radps(2);
    r_radps = angularRates_radps(3);

    % Roll
    CML_beta_prad = -0.01; 
    CML_p_sprad = -0.01;
    CML = CML_beta_prad * beta_rad + CML_p_sprad * p_radps + dCML_dElevator_prad * (elevatorLeft_rad - elevatorRight_rad) + dCML_dRudder_prad * (rudderLeft_rad + rudderRight_rad);

    % Pitch
    CM0 = 0.0;
    CMM_alpha_prad = -0.1; 
    CMM_q_sprad = -0.01;
    CMM = CM0 + CMM_alpha_prad * alpha_rad + CMM_q_sprad * q_radps + dCMM_dElevator_prad * (elevatorLeft_rad + elevatorRight_rad) + dCMM_dRudder_prad * (rudderLeft_rad - rudderRight_rad);
 
    % Yaw
    CMN_beta_prad = 0.1;
    CMN_r_sprad = -0.1;
    CMN = CMN_beta_prad * beta_rad + CMN_r_sprad * r_radps + dCMN_dElevator_prad * (abs(elevatorLeft_rad) - abs(elevatorRight_rad)) + dCMN_dRudder_prad * (rudderLeft_rad + rudderRight_rad);

    CM = [CML; CMM; CMN];
end