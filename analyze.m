function [mod_elast, ult_stress, frac_stress] = analyze(xlsfile)
    % Function analyze.m analyzes the stress-strain data in the
    % input xlsfile, plotting an Elongation Curve and Stress Strain curve,
    % and returning the data's modulus of elasticity, ultimate stress, and
    % fracture stress
        
    % Universal variables
    cross_sectional_area = 2.482 / 1000; % Meters. Same value for every case.
    gauge_length = 18 / 1000; % Ditto
    
    poly_data = xlsread(xlsfile);

    % Elongation curve. Position vs. load
    position = poly_data(:,3) ./ 1000; % units m
    load = poly_data(:,2); % units N
    figure()
    plot(position, load)

    % Stress strain. Strain vs. stress. Same plot as elongation
    hold on
    
    stress = load ./ cross_sectional_area;
    strain = position ./ gauge_length;
    plot(strain, stress)

    title('Load vs. Position, Stress vs. Strain')
    xlabel('Position(m), Strain')
    ylabel('Load(N), Stress(MPa)')
    legend('Elongation', 'Stress Strain')

    % TODO: modulus of elasticity
    mod_elast = 0;
    
    % Ultimate stress
    [ult_stress, ult_str_index] = max(stress);
    plot(strain(ult_str_index), ult_stress, '*')

    % TODO: fracture stress
    frac_stress = 0;
    
    hold off
   
end