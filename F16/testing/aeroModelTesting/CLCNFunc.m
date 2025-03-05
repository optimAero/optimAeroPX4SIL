function coefficient = CLCNFunc(alpha, beta, aeroData)

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
S = 0.2 * abs(beta);
M = fix(S);
if M == 0
    M = 1;
end
if M >= 6
    M = 5;
end
DB = S - M;
N = M + fix(sign(DB) * abs(1.1));
T = interp2(alphaBkpts_nd, betaBkpts_nd, aeroData, K, M);
U = interp2(alphaBkpts_nd, betaBkpts_nd, aeroData, K, N);
V = T + abs(DA) * (interp2(alphaBkpts_nd, betaBkpts_nd, aeroData, L, M) - T);
W = U + abs(DA) * (interp2(alphaBkpts_nd, betaBkpts_nd, aeroData, L, N) - U);
DUM = V + (W-V) * abs(DB);
coefficient = DUM  * sign(1 * sign(beta));
