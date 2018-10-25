function v = V(x,u,i)
    alpha = 0.1;
    a = 2;
    v_f = 110;                      % [km/h]
    rho_c = 28;                     % [veh/km/lane]
    
    v = min([(1 + alpha) * u(1), ... 
             v_f * exp(-1/a * (x(i-4)/rho_c)^a)]);
end