function main()
    % Add analysis tools to the path
    addpath("lab/");

    % Load timeseries datafiles
    addpath("EruptionData/");
    geysers_1989 = load("EruptionData/eruption1989.dat");
    geysers_2000 = load("EruptionData/eruption2000.dat");
    geysers_2011 = load("EruptionData/eruption2011.dat");

    % random_point = floor((length_2000 - length_1989) * rand());
    % random_point = floor((length_2011 - length_1989) * rand());

    lengths = length(geysers_1989);

    geysers_2000 = geysers_2011(278:575);
    geysers_2011 = geysers_2011(893:1190);

    linear_analysis(geysers_1989, length_1989, '2000');

    arma_p = 1;
    arma_q = 1;
    ar_p = 2;
    ma_q = 5;
    prediction_steps = 1;
    linear_analysis_determine_models_coeffs_and_nrmse(arma_p, arma_q, ar_p, ma_q, prediction_steps);

    % Nonlinear
    % Init timeseries
    timeseries_nonlinear = load("EruptionData/eruption2002.dat");
    N = length(timeseries);

    % Get a randomly selected segment of initial timeseries
    timeseries_nonlinear_segment = timeseries(1827:2326);
    N_seg = 500;

    nonlinear_analysis(timeseries_nonlinear, N);
    nonlinear_analysis(timeseries_nonlinear_segment, N_seg);

end