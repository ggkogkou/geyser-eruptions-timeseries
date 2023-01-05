function linear_analysis(timeseries, N)
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

    % random_point = floor((length_2000 - length_1989) * rand());
    % random_point = floor((length_2011 - length_1989) * rand());

    geysers_2000 = geysers_2011(278:575);
    geysers_2011 = geysers_2011(893:1190);

    % Linear Analysis for 1989
    figure(1);
    r_t = autocorrelation(geysers_1989, length_1989, 'ac.f. 1989', 'c');
    hold on;
    confidence_interval = [-1.96/sqrt(length_1989) 1.96/sqrt(length_1989)];
    yline(confidence_interval(1), 'r');
    yline(confidence_interval(2), 'r');

    p_value = 0;
    for i=1 : length(r_t)
        if r_t(i, 2) > confidence_interval(2) || r_t(i, 2) < confidence_interval(1)
            p_value = p_value + 1;
        end
    end
    p_value = p_value / length_1989;
    if p_value > 0.05
        fprintf("There are strong correlations between observations, it's not white noise. %.3f is significant\n", p_value);
    else
        fprintf("There are not any strong correlations. The time series is white noise\n");
    end

    % Fit AR(p) model
    aic_memory_ar = dictionary(1, 0);

    for p=1 : 30
        [~, ~, ~, ~, aic_memory_ar(p)] = fitARMA(geysers_1989, p, 0, 1);
    end

    aic_array = values(aic_memory_ar);
    figure(2);
    plot(aic_array);

    % Fit MA(q) model
    aic_memory_ma = dictionary(1, 0);

    for q=1 : 30
        [~, ~, ~, ~, aic_memory_ma(q)] = fitARMA(geysers_1989, 0, q, 1);
    end

    aic_array = values(aic_memory_ma);
    figure(3);
    plot(aic_array);

    % Fit ARMA(p,q) model
    aic_memory_arma = dictionary(1, 0);

    figure(4);
    for q=1 : 7
        for p=1 : 7
            [~, ~, ~, ~, aic_memory_arma(p)] = fitARMA(geysers_1989, p, q, 1);
        end
        plot(values(aic_memory_arma));
        q_str{q} = sprintf('q = %d', q);
        legend(q_str);
        hold all;
        drawnow;
    end

    % Find models parameters
    [nrmse, phi_paramaeters, theta_parameters, s_z, aic, ~, ~] = fitARMA(geysers_1989, 1, 1, 1)

    [nrmse, phi_paramaeters, ~, s_z, aic, ~, ~] = fitARMA(geysers_1989, 2, 0, 1)

    [nrmse, ~, theta_parameters, s_z, aic, ~, ~] = fitARMA(geysers_1989, 0, 5, 1)

end

