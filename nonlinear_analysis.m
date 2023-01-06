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
    r_t = autocorrelation(timeseries_segment, N_seg);
    Q = 0;
    k = N_seg-1;
    for tau = 1:k
        Q = Q + (r_t(tau, 2)^2)/(N_seg-tau);  
    end
    Q = N_seg*(N_seg+2)*Q;
    if Q > chi2inv(1-0.05, k)
        fprintf("There are strong correlations between observations, it's not white noise. Q = %.3f\n", Q);
    else
        fprintf("There are not any strong correlations. The time series is white noise. Q = %.3f\n", Q); 
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






