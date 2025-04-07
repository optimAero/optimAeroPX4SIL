% Data For Hexa, approximated from: Bershadsky, Dmitry. "Electric multirotor design and optimization." Georgia Institute of Technology, Atlanta (2017).

alphaBkpts_rad = deg2rad([-90:10:90]);
C_D = [0.05 0.06 0.07 0.08 0.09 0.1 0.09 0.08 0.07 0.06];
C_D = [C_D fliplr(C_D(1:end-1) )];
C_L = [0.38:-(0.38-0.0)/9:0.0];
C_L = -[C_L -fliplr(C_L(1:end-1) )];
% plot(alphaBkpts_rad, C_L)
% plot(alphaBkpts_rad, C_D) %TODO