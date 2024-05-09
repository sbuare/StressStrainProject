function [mod_elast, ult_stress, frac_stress] = analyze(xlsfile)
    % Function analyze.m analyzes the stress-strain data in the
    % input xlsfile, plotting an Elongation Curve and Stress Strain curve,
    % and returning the data's modulus of elasticity, ultimate stress, and
    % fracture stress

    % Constants
    cross_sectional_area = 2.482 / 10^6; % Meters^2. Same value for every case.
    gauge_length = 18 / 1000; % Ditto

    poly_data = xlsread(xlsfile);

    % Elongation curve. Load vs. position
    position = poly_data(7:end, 3) ./ 1000; % units m
    load = poly_data(7:end, 2); % units N
    figure()

    subplot(2, 1, 1)
    plot(position, load)
    title('Load vs. Position')
    xlabel('Position (m)')
    ylabel('Load (N)')

    % Stress strain. Stress vs. strain
    stress = (load / cross_sectional_area) / 10^6; % units MPa
    strain = position / gauge_length;
    
    subplot(2, 1, 2)
    plot(strain, stress, 'linewidth', 1)
    title('Stress vs. Strain')
    xlabel('Strain')
    ylabel('Stress(MPa)')

    % Modulus of elasticity
    % Slope of the linear (elastic) portion of the graph
    % Calculated with the slope of the linear approximation at strain <= 0.1
    elastic_strain = strain(strain <= 0.1);
    elastic_stress = stress(1:length(elastic_strain));
    fit_line = polyfit(elastic_strain, elastic_stress, 1);
    
    mod_elast = fit_line(1); 

    % Ultimate stress
    % Maximum value of stress in the graph
    [ult_stress, ~] = max(stress);

    % TODO: fracture stress
    % Final value of stress before the material breaks
    frac_stress = 0;

end
