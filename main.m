function main()
    % Add analysis tools to the path
    addpath("lab/");

    % Load timeseries datafiles
    addpath("EruptionData/");
    geysers_1989 = load("EruptionData/eruption1989.dat");
    geysers_2000 = load("EruptionData/eruption2000.dat");
    geysers_2011 = load("EruptionData/eruption2011.dat");

    length_1989 = length(geysers_1989);
    length_2000 = length(geysers_2000);
    length_2011 = length(geysers_2011);

    linear_analysis(geysers_1989, length_1989);


end