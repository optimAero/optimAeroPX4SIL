function b2w = body2wind(alpha, beta)
    % Function to transform from body frame to wind frame
    % Input:
    % alpha - Angle of attack in radians
    % beta - Sideslip angle in radians

    % Rotation matrix for sideslip angle beta (around Z-axis)
    R_beta = [cos(beta), sin(beta), 0;
              -sin(beta), cos(beta), 0;
              0, 0, 1];

    % Rotation matrix for angle of attack alpha (around Y-axis)
    R_alpha = [cos(alpha), 0, sin(alpha);
               0, 1, 0;
               -sin(alpha), 0, cos(alpha)];

    % Combined rotation matrix
    b2w = R_beta * R_alpha;
end