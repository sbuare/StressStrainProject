function [mod_elast, ult_stress, frac_stress] = analyze(xlsfile, area, g_len)
    % Function analyze.m analyzes stress-strain data based on the
    % inputs xlsfile, area and g_len (the experiment data, then the 
    % cross-sectional area and gauge length of the material in mm). 
    % The output is a plot of the material's elongation and stress strain,
    % its modulus of elasticity, ultimate stress, and fracture stress.

    poly_data = xlsread(xlsfile);
    
    % Define/calculate values, converting units as necessary
    cross_sectional_area = area / 10^6;
    gauge_length = g_len / 1000; 

    position = poly_data(7:end, 3) ./ 1000;
    load = poly_data(7:end, 2);
    
    stress = (load / cross_sectional_area) / 10^6;
    strain = position / gauge_length;

    
    % Modulus of elasticity -- slope of the linear (elastic) portion of the graph
    
    elastic_strain = strain(strain <= 0.1); % Select strains where strain <= 0.1
    elastic_stress = stress(1:length(elastic_strain)); % Find corresponding stress
    fit_line = polyfit(elastic_strain, elastic_stress, 1); % Calculate fit line of data subset
    
    mod_elast = fit_line(1); % First element in fit_line is its slope

    
    % Ultimate stress -- maximum value of stress in the graph
    [ult_stress, ult_ind] = max(stress);
    
    
    % Fracture stress -- final value of stress before the material breaks
    % Time to search through the array for the fracture point:
    
    frac_ind = 0;
    start_ind = floor(length(stress) * 0.8); % Start search ~80% away from origin
    
    for i=start_ind:(length(stress)-10)
        rise = stress(i + 10) - stress(i);
        run = strain(i + 10) - strain(i);
        
        slope = rise / run; % Approximate instantaneous slope at index i
        angle = atand(slope);
        
        if (angle < -87) % If angle is close to -90 (vertical), fracture stress found
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
    
    % Plot the ultimate stress and fracture stress, with legend
    plot(strain(ult_ind), ult_stress, '*')
    plot(strain(frac_ind), frac_stress, '*')
    legend('Stress strain', 'Ultimate stress', 'Fracture stress', 'Location', 'southwest')
    
    hold off

end
