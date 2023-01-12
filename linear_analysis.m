function linear_analysis(timeseries, N, id)
    % Add analysis tools to the path
    addpath("lab/");

    % Linear Analysis 
    figure(1);
    r_t = autocorrelation(timeseries, N, id, 'c');
    hold on;
    confidence_interval = [-1.96/sqrt(N) 1.96/sqrt(N)];
    yline(confidence_interval(1), 'r');
    yline(confidence_interval(2), 'r');

    p_value = 0;
    for i=1 : length(r_t)
        if r_t(i, 2) > confidence_interval(2) || r_t(i, 2) < confidence_interval(1)
            p_value = p_value + 1;
        end
    end
    p_value = p_value / N;
    if p_value > 0.05
        fprintf("There are strong correlations between observations, it's not white noise. %.3f is significant\n", p_value);
    else
        fprintf("There are not any strong correlations. The time series is white noise. %.3f is significant\n", p_value);
    end

    % Fit AR(p) model
    aic_memory_ar = NaN();

    for p=1 : 30
        [~, ~, ~, ~, aic_memory_ar(p)] = fitARMA(timeseries, p, 0, 1);
    end

    figure(2);
    plot(aic_memory_ar);

    % Fit MA(q) model
    aic_memory_ma = NaN();

    for q=1 : 30
        [~, ~, ~, ~, aic_memory_ma(q)] = fitARMA(timeseries, 0, q, 1);
    end

    figure(3);
    plot(aic_memory_ma);

    % Fit ARMA(p,q) model
    aic_memory_arma = NaN();

    figure(4);
    for q=1 : 7
        for p=1 : 7
            [~, ~, ~, ~, aic_memory_arma(p)] = fitARMA(timeseries, p, q, 1);
        end
        plot(aic_memory_arma);
        q_str{q} = sprintf('q = %d', q);
        legend(q_str);
        hold all;
        drawnow;
    end

    % Find models parameters for selected p, q
    [nrmse, phi_paramaeters, theta_parameters, s_z, aic, ~, ~] = fitARMA(timeseries, 1, 1, 1)

    [nrmse, phi_paramaeters, ~, s_z, aic, ~, ~] = fitARMA(timeseries, 2, 0, 1)

    [nrmse, ~, theta_parameters, s_z, aic, ~, ~] = fitARMA(timeseries, 0, 5, 1)

end

