function pdot = PDOT(P3, P1)

if P1 >= 50
    if P3 >= 50
        T= 5.0;
        P2 = P1;
    else
        P2 = 60;
        T= RTAU(P2-P3);
    end
else
    if P3 >= 50 
        T = 5.0;
        P2 = 40.0;
    else
        P2 = P1;
        T = RTAU(P2-P3);
    end
end
pdot = T * (P2 - P3);

end

function rtau = RTAU(DP)
    if DP <= 25
        rtau = 1.0;
    else
        rtau = 1.9 - 0.036 * DP;
    end
end
