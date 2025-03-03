function w2b = wind2body(alpha, beta)
    % Function to transform from wind frame to body frame
    % Input:
    % alpha - Angle of attack in radians
    % beta - Sideslip angle in radians
    w2b = body2wind(alpha, beta)';
end