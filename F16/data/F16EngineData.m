% Data For F-16 Engine Model 
% Reference: Aircraft Control and Simulation THIRD EDITION (STEVENS, LEWIS,
% JOHNSON)

% Thrust tables have rows corresponding to mach Number, columns that
% correspond to altitude and the third dimension corresponds to power level
% (idle, military, and max)

% engineDataF16.altitudeBkpts_ft = 0:10000:50000;
% engineDataF16.machBkpts = 0:0.2:1;
engineDataF16.altitudeBkpts_ft = 0:5;
engineDataF16.machBkpts = 0:5;

engineDataF16.thrustIdle_lbf = [
1060 670 880 1140 1500 1860;
635	425	690	1010 1330 1700;
60	25	345	755	1130	1525;
-1020	-710	-300	350	910	1360;
-2700	-1900	-1300	-247	600	1100;
-3600	-1400	-595	-342	-200	700];

engineDataF16.thrustMilitary_lbf = [
12680	9150	6200	3950	2450	1400;
12680	9150	6313	4040	2470	1400;
12610	9312	6610	4290	2600	1560;
12640	9839	7090	4660	2840	1660;
12390	10176	7750	5320	3250	1930;
11680	9848	8050	3100	3800	2310];

engineDataF16.thrustMax_lbf= [
20000	15000	10800	7000	4000	2500;
21420	15700	11225	7323	4435	2600;
22700	16860	12250	8154	5000	2835;
24240	18910	13760	9285	5700	3215;
26070	21075	15975	11115	6860	3950;
28886	23319	18300	13484	8642	5057];