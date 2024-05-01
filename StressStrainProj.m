clc, clear, format bank

% main

poly_file = 'C:\Users\mt2c\Downloads\Poly_81_16_01_21_19_39.xlsx';
ABS_file = 'C:\Users\mt2c\Downloads\ABS_71_16_01_21_19_25.xlsx';
HIPS_file = 'C:\Users\mt2c\Downloads\HIPS_51_16_01_21_19_15.xlsx';
nylon_file = 'C:\Users\mt2c\Downloads\Nylon6_61_16_01_21_19_20.xlsx';

[poly_elast, poly_ult_stress, poly_fract_stress] = analyze(poly_file);

[ABS_elast, ABS_ult_stress, ABS_fract_stress] = analyze(ABS_file);

[HIPS_elast, HIPS_ult_stress, HIPS_fract_stress] = analyze(HIPS_file);

[nylon_elast, nylon_ult_stress, nylon_fract_stress] = analyze(nylon_file);
