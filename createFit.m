function [fitresult, gof] = createFit(distances, avs)
%CREATEFIT1(DISTANCES,AVS)
%  Create a fit.
%
%  Data for 'lab2' fit:
%      X Input: distances
%      Y Output: avs
%  Output:
%      fitresult : a fit object representing the fit.
%      gof : structure with goodness-of fit info.
%
%  See also FIT, CFIT, SFIT.

%  Auto-generated by MATLAB on 13-Mar-2024 10:53:31


%% Fit: 'lab2'.
[xData, yData] = prepareCurveData( distances, avs );

% Set up fittype and options.
ft = fittype( '7.1663-U_s*exp(-0.693*(x-y_0)^2/y_12^2)', 'independent', 'x', 'dependent', 'y' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.Lower = [-Inf 11 -Inf];
opts.StartPoint = [0.530797553008973 12 0.779167230102011];
opts.Upper = [Inf 13 Inf];

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts );


