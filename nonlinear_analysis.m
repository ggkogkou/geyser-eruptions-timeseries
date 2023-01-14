function nonlinear_analysis(timeseries, N)
    % Add directories of data and analysis tools
    addpath('labnonlinear/');
    addpath('lab/');
    addpath('EruptionData/');

    % Init timeseries
    [~, ~, ~, timeseries_2002, timeseries_2002_segment] = load_data();

    % Select timeseries to analyze
    timeseries = timeseries_2002;
    %timeseries = timeseries_2002_segment;

    N = length(timeseries);

    % operation variable, 1: Find τ and m, 2: Predictions, correlation
    % dimension
    operation = 1;

    % Estimated τ and m by operation 1 execution
    tau = 3;
    m = 4;

    if operation == 1
        % Plot the timeseries
        figure(1);
        plot(linspace(0, N, N), timeseries);
        title('2002 Time Series');
    
        % Statistical independence test (Portmanteau test)
        [hV] = portmanteauLB(timeseries , N , 0.05);
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
            fnnM = falsenearest(timeseries, test_tau_params(i), 10, 10, 0, 'FNN for Full Time Series 2002');
        end

    else
        % Local Mean Value forecast model
        K = 50;
        q = 0;     
        Tmax = 5;
        [nrmseMM, preMM] = localfitnrmse(timeseries, tau, m, Tmax, K, q, 'Local Mean Value prediction model');
        
        % Local Linear prediction model
        K = 10;
        q = m;     
        Tmax = 5;
        nlast = 190;
        [nrmseV, preM, phiV] = linearpredictnrmse(timeseries, m, Tmax, nlast, 'Local Linear Prediction Model');
    
        % Calculate correlation dimension
        [rcM,cM,rdM,dM,nuM] = correlationdimension(timeseries, 3, 10, 'C(r)', -15, -0.5, 0.5);
    end

end



