function CZOutput = CZFunc(alpha ,beta, El)
CZ = evalin('base', 'CZ');
maxElevatorDefl_deg = evalin('base', 'maxElevatorDefl_deg');
alphaBkpts_nd = evalin('base', 'alphaBkpts_nd');

S = 0.2 * alpha;
K = fix(S);
if K <= -2
    K = -1;
end
if K >= 9
    K = 8;
end
DA = S - K;
L = K + fix(sign(DA) * abs(1.1));
S = interp1(alphaBkpts_nd, CZ, K) + abs(DA) * (interp1(alphaBkpts_nd, CZ, L) -  interp1(alphaBkpts_nd, CZ, K));
CZOutput = S * (1 - (beta/57.3)^2) - 0.19 * (El / maxElevatorDefl_deg);