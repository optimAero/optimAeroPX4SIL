function controlSurfaceCoeff = CSFunc(alpha, beta, aeroData)
alphaBkpts_nd = evalin('base', 'alphaBkpts_nd');
betaBkpts_nd = evalin('base', 'betaBkpts_nd');

S = 0.2 * alpha;
K = fix(S);
if K <= -2
    K = -1;
end
if K>= 9
    K = 8;
end
DA = S - K;
L = K + fix(sign(DA) * 1.1);
S = 0.1 * beta;
M = fix(S);
if M == -3
    M = -2;
end
if M >= 3
    M = 2;
end
DB = S - M;
N = M + fix(sign(DB) * 1.1);
T = interp2(alphaBkpts_nd, betaBkpts_nd, aeroData, K, M);
U = interp2(alphaBkpts_nd, betaBkpts_nd, aeroData, K, N);
V = T + abs(DA) * (interp2(alphaBkpts_nd, betaBkpts_nd, aeroData, L, M) - T);
W = U + abs(DA) * (interp2(alphaBkpts_nd, betaBkpts_nd, aeroData, L, N) - U);
controlSurfaceCoeff = V + (W-V) * abs(DB);
