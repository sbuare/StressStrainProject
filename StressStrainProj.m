clc, clear, format bank

% Files
poly_file = 'Poly_81_16_01_21_19_39.xlsx';
ABS_file = 'ABS_71_16_01_21_19_25.xlsx';
HIPS_file = 'HIPS_51_16_01_21_19_15.xlsx';
nylon_file = 'Nylon6_61_16_01_21_19_20.xlsx';

% User inputs
cross_section = input('Is the cross_sectional area circular? [Y/N]\n', 's');
area = input('What is the cross-setional area of the material? (Hint: probably 2.482 square mm)\n');
diameter = input('What is the diameter? (Hint: probably 1.7777 mm)\n');
g_len = input('What is the gauge length? (Hint: probably 18 mm)\n');

mat_string = 'Please select the material (-1 to stop): \n1. Polypropylene \n2. ABS \n3. HIPS \n4. Nylon \n';
material = input(mat_string);

% Process the inputs and return:
% Name of the material
% Values in MPa of elastic modulus, ultimate stress, fracture stress
% Plots of elongation and stress strain

while material ~= -1
    switch material
        case 1
            [poly_elast, poly_ult_stress, poly_fract_stress] = analyze(poly_file, area, g_len);
            disp('Polypropylene:')
            fprintf(' Modulus of elasticity: %.2f MPa\n Ultimate stress: %.2f MPa\n Fracture stress: %.2f MPa\n', poly_elast, poly_ult_stress, poly_fract_stress);
        case 2
            [ABS_elast, ABS_ult_stress, ABS_fract_stress] = analyze(ABS_file, area, g_len);
            disp('ABS:')
            fprintf(' Modulus of elasticity: %.2f MPa\n Ultimate stress: %.2f MPa\n Fracture stress: %.2f MPa\n', ABS_elast, ABS_ult_stress, ABS_fract_stress);
        case 3
            [HIPS_elast, HIPS_ult_stress, HIPS_fract_stress] = analyze(HIPS_file, area, g_len);
            disp('HIPS:')
            fprintf(' Modulus of elasticity: %.2f MPa\n Ultimate stress: %.2f MPa\n Fracture stress: %.2f MPa\n', HIPS_elast, HIPS_ult_stress, HIPS_fract_stress);
        case 4
            [nylon_elast, nylon_ult_stress, nylon_fract_stress] = analyze(nylon_file, area, g_len);
            disp('Nylon:')
            fprintf(' Modulus of elasticity: %.2f MPa\n Ultimate stress: %.2f MPa\n Fracture stress: %.2f MPa\n', nylon_elast, nylon_ult_stress, nylon_fract_stress);
        otherwise
            disp('Invalid input. Please try again.')
    end
    material = input(mat_string);
end

disp('Thank you for using the stress-strain analyzer.')


