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

    length_1989 = length(geysers_1989);

    geysers_2000 = geysers_2011(278:575);
    geysers_2011 = geysers_2011(893:1190);

    linear_analysis(geysers_1989, length_1989, '1989');


end