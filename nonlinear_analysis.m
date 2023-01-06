function nonlinear_analysis()
    % Add directories of data and analysis tools
    addpath('labnonlinear/');
    addpath('EruptionData/');

    % Init timeseries
    timeseries = load("EruptionData/eruption2002.dat");
    N = length(timeseries);

    % random_point = floor((N - 500) * rand())

    % Get a randomly selected segment of initial timeseries
    timeseries_segment = timeseries(1827:2326);
    N_seg = 500;

    % Plot the timeseries
    figure(1);
    plot(linspace(0, N, N), timeseries);
    title('2002 Full Time Series');

    figure(2);
    plot(linspace(0, N_seg, N_seg), timeseries_segment);
    title('2002 Time Series Segment');

    % Statistical independence test (Portmanteau test)
    [hV] = portmanteauLB(timeseries_segment , N_seg , 0.05);
    if hV == 1
        fprintf("The Null hypothesis is rejected, there is statistacaly significant autocorrelation on the time series\n");
    else
        fprintf("The Null hypothesis is not rejected, the time series is white noise\n");
    end

    % Estimation of lag τ parameter by Mutual Information Theorem
    [mutM] = mutualinformation(timeseries, 20, 30, 'Mutual Information Full Time Series 2002', 'c');

    % By a visual inspection it occurs that 1st local minimum is at lag τ=3 and the 2nd at τ=7
    test_tau_params = [1 2 3 7];

    % Estimation of embedding dimension m using FNN criterion criterion
    for i=1 : length(test_tau_params)
        fnnM = falsenearest(timeseries, test_tau_params(i), 10, 10, 0, 'FNN for Full Time Series 2022')
    end

    % Plot dispersion diagram in 2D and 3D. CAUTION: plot2d3d is buggy
    tau = 3;
    m = 4;
    [xM] = embeddelays(timeseries, m, tau);
    plotd2d3(xM, 'Dispersion Plot')

    % Local Mean Value forecast model

    % Local Linear prediction model


end






