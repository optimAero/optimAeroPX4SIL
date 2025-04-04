function thrust_lbf = THRUST(POW,ALT,RMACH)

engineDataF16 = evalin('base', 'engineDataF16');

H = 0.0001 * ALT;
I = fix(H);
if I >= 5
    I = 4;
end
DH = H - I;
RM = 5.0 * RMACH;
M = fix(RM);
if M >= 5
    M = 4;
end
DM = RM - M;
CDH = 1.0 - DH;

BIM = interp2(0:5, 0:5,  engineDataF16.thrustMilitary_lbf,I, M);
BIpOneM = interp2(0:5, 0:5,  engineDataF16.thrustMilitary_lbf,  I + 1, M);
BIMpOne = interp2(0:5, 0:5,  engineDataF16.thrustMilitary_lbf, I, M +1);
BIpOneMpOne = interp2(0:5, 0:5,  engineDataF16.thrustMilitary_lbf, I + 1, M + 1 );
S = BIM * CDH + BIpOneM * DH;
T = BIMpOne * CDH + BIpOneMpOne * DH;

TMIL = S + (T-S) * DM;
AIM = interp2(0:5, 0:5,  engineDataF16.thrustIdle_lbf, I, M);
AIpOneM = interp2(0:5, 0:5,  engineDataF16.thrustIdle_lbf, I + 1, M);
AIMpOne = interp2(0:5, 0:5,  engineDataF16.thrustIdle_lbf, I, M + 1);
AIpOneMpOne = interp2(0:5, 0:5,  engineDataF16.thrustIdle_lbf, I + 1, M + 1);

CIM = interp2(0:5, 0:5,  engineDataF16.thrustMax_lbf, I, M);
CIpOneM = interp2(0:5, 0:5,  engineDataF16.thrustMax_lbf, I + 1, M);
CIMpOne = interp2(0:5, 0:5,  engineDataF16.thrustMax_lbf,I, M + 1);
CIpOneMpOne = interp2(0:5, 0:5,  engineDataF16.thrustMax_lbf, I + 1, M + 1);
if POW < 50
    S = AIM * CDH + AIpOneM * DH;
    T = AIMpOne * CDH + AIpOneMpOne * DH;
    TIDL = S + (T-S) * DM;
    thrust_lbf = TIDL + (TMIL - TIDL) * POW *.02;
else
    S = CIM * CDH + CIpOneM * DH;
    T = CIMpOne * CDH + CIpOneMpOne * DH;
    TMAX = S + (T-S) * DM;
    thrust_lbf = TMIL + (TMAX-TMIL) * (POW-50) * .02;
end


end