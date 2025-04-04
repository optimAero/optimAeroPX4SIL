function coeff = CXCMFunc(alpha_deg, posElevator_deg, aeroData)
alphaBkpts_nd = evalin('base', 'alphaBkpts_nd');
elevBkpts_nd = evalin('base', 'elevBkpts_nd');

S = 0.2 * alpha_deg;
K = fix(S);
if K <= -2
    K = -1;
end

if K >= 9
    K = 8;
end

DA = S - K;
L = K + fix(sign(DA) * abs(1.1));
S = posElevator_deg/12;
M = fix(S);
if M <= -2
    M=-1;
end
if M >= 2
    M=1;
end

DE = S - M;
N = M + fix(sign(DE) * abs(1.1));
T = interp2(alphaBkpts_nd, elevBkpts_nd, aeroData, K, M);
U = interp2(alphaBkpts_nd, elevBkpts_nd, aeroData, K, N);
V = T + abs(DA) * (interp2(alphaBkpts_nd, elevBkpts_nd, aeroData, L, M) -T);
W = U + abs(DA) * (interp2(alphaBkpts_nd, elevBkpts_nd, aeroData, L, N) -U);
coeff = V + (W-V) * abs(DE);
end