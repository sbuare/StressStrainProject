function [mod_elast, ult_stress, frac_stress] = analyze(xlsfile)
    % Function analyze.m analyzes the stress-strain data in the
    % input xlsfile, plotting an Elongation Curve and Stress Strain curve,
    % and returning the data's modulus of elasticity, ultimate stress, and
    % fracture stress

    % Constants
    cross_sectional_area = 2.482 / 10^6; % Meters^2. Same value for every case.
    gauge_length = 18 / 1000; % Ditto

    poly_data = xlsread(xlsfile);

    % Load and position
    position = poly_data(7:end, 3) ./ 1000; % units m
    load = poly_data(7:end, 2); % units N
    
    % Stress and strain
    stress = (load / cross_sectional_area) / 10^6; % units MPa
    strain = position / gauge_length;

    % Modulus of elasticity
    % Slope of the linear (elastic) portion of the graph
    % Calculated with the slope of the linear approximation at strain <= 0.1
    elastic_strain = strain(strain <= 0.1);
    elastic_stress = stress(1:length(elastic_strain));
    fit_line = polyfit(elastic_strain, elastic_stress, 1);
    
    mod_elast = fit_line(1); 

    % Ultimate stress
    % Maximum value of stress in the graph
    [ult_stress, ult_ind] = max(stress);

    % Fracture stress
    % Final value of stress before the material breaks
    
    frac_ind = 0;
    start_ind = floor(length(stress) * 0.80); % Start ~80% away from 0 strain
    
    for i=start_ind:(length(stress)-10) % Span from ~80% away to length-10
        rise = stress(i + 10) - stress(i);
        run = strain(i + 10) - strain(i);
        
        slope = rise / run;
        angle = atand(slope);
        
        if (angle < -87) % If angle is close to 90
            frac_ind = i;
        end
    end
    
    frac_stress = stress(frac_ind);
     
    % Plotting
    figure()
    
    % Load vs. position
    subplot(2, 1, 1)
    plot(position, load)
    title('Load vs. Position')
    xlabel('Position (m)')
    ylabel('Load (N)')
    
    % Stress vs. strain
    subplot(2, 1, 2)
    plot(strain, stress, 'linewidth', 1)
    title('Stress vs. Strain')
    xlabel('Strain')
    ylabel('Stress(MPa)')
    
    hold on
    
    plot(strain(ult_ind), ult_stress, '*')
    plot(strain(frac_ind), frac_stress, '*')
    legend('Stress strain', 'Ultimate stress', 'Fracture stress', 'Location', 'southwest')
    
    hold off

end
