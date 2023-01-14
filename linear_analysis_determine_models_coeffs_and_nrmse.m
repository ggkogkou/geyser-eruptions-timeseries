function [ ] = linear_analysis_determine_models_coeffs_and_nrmse(arma_p, arma_q, ar_p, ma_q, prediction_steps)
    % Determine models coefficients phi, theta for selected p, q
    % Also predict and check nrmse
    [nrmse, phi_paramaeters, theta_parameters, s_z, aic, ~, ~] = fitARMA(timeseries, arma_p, arma_q, prediction_steps)

    [nrmse, phi_paramaeters, ~, s_z, aic, ~, ~] = fitARMA(timeseries, ar_p, 0, prediction_steps)

    [nrmse, ~, theta_parameters, s_z, aic, ~, ~] = fitARMA(timeseries, 0, ma_q, prediction_steps)

end


