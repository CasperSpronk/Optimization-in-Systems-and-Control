function out = g_r(x,u)
    timeStep = 10;                  % [s]
    rho_c = 28;                     % [veh/km/lane]
    C_r = 2000;                     % [veh/h]
    rho_m = 120;                    % [veh/km/lane]
    
    out = min([u(2) * C_r, ...
              u(4) + x(9) / timeStep, ...
              C_r * (rho_m - x(4)) / (rho_m - rho_c)]);
end