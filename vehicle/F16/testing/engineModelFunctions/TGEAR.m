function tgear = TGEAR(THTL)

if THTL <= 0.77
    tgear = 64.94 * THTL;
else
    tgear = 217.38 * THTL - 117.38;
end