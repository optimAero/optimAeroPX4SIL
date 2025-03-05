function dampCoeffs = DAMP(alpha_deg)
alphaBkpts_nd = evalin('base', 'alphaBkpts_nd');
CXq = evalin('base', 'CXq');
CYr = evalin('base', 'CYr');
CYp = evalin('base', 'CYp');
CZq = evalin('base', 'CZq');
Clr = evalin('base', 'Clr');
Clp = evalin('base', 'Clp');
Cmq = evalin('base', 'Cmq');
Cnr = evalin('base', 'Cnr');
Cnp = evalin('base', 'Cnp');

dampCoefMatrix = [CXq; CYr; CYp; CZq; Clr; Clp; Cmq; Cnr; Cnp];

S = 0.2 * alpha_deg;
K = fix(S);
if K <= -2
    K=-1;
end
if K >= 9
    K = 8;
end
DA = S -K;
L = K + fix(sign(DA) * abs(1.1));
for ii = 1:9
    dampCoeffs(ii) = interp1(alphaBkpts_nd, dampCoefMatrix(ii,:), K) + abs(DA) * (interp1(alphaBkpts_nd, dampCoefMatrix(ii,:), L) - interp1(alphaBkpts_nd, dampCoefMatrix(ii,:), K));
end

end