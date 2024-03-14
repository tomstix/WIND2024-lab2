cal_data = readtable("data\Calibration table.txt", "Delimiter","\t");
freestream_data = readtable("data\free stream.txt", "Delimiter","\t");
data_4 = readtable("data\4cm.txt", "Delimiter","\t");
data_6 = readtable("data\6cm.txt", "Delimiter","\t");
data_8 = readtable("data\8cm.txt", "Delimiter","\t");
data_9 = readtable("data\9cm.txt", "Delimiter","\t");
data_10 = readtable("data\10cm.txt", "Delimiter","\t");
data_11 = readtable("data\11cm.txt", "Delimiter","\t");
data_12 = readtable("data\12cm.txt", "Delimiter","\t");
data_13 = readtable("data\13cm.txt", "Delimiter","\t");
data_14 = readtable("data\14cm.txt", "Delimiter","\t");
data_15 = readtable("data\15cm.txt", "Delimiter","\t");
data_16 = readtable("data\16cm.txt", "Delimiter","\t");
data_17 = readtable("data\17cm.txt", "Delimiter","\t");
data_19 = readtable("data\19cm.txt", "Delimiter","\t");
data_21 = readtable("data\21cm.txt", "Delimiter","\t");

distances = [4;6;8;9;10;11;12;13;14;15;16;17;19;21];

freestream_avg = mean(freestream_data.U1cal);
averages(:,1) = distances;
averages(:,2) = [...
    mean(data_4.U1cal),...
    mean(data_6.U1cal),...
    mean(data_8.U1cal),...
    mean(data_9.U1cal),...
    mean(data_10.U1cal),...
    mean(data_11.U1cal),...
    mean(data_12.U1cal),...
    mean(data_13.U1cal),...
    mean(data_14.U1cal),...
    mean(data_15.U1cal),...
    mean(data_16.U1cal),...
    mean(data_17.U1cal),...
    mean(data_19.U1cal),...
    mean(data_21.U1cal)
    ];
variances(:,1) = distances;
variances(:,2) = [...
    var(data_4.U1cal),...
    var(data_6.U1cal),...
    var(data_8.U1cal),...
    var(data_9.U1cal),...
    var(data_10.U1cal),...
    var(data_11.U1cal),...
    var(data_12.U1cal),...
    var(data_13.U1cal),...
    var(data_14.U1cal),...
    var(data_15.U1cal),...
    var(data_16.U1cal),...
    var(data_17.U1cal),...
    var(data_19.U1cal),...
    var(data_21.U1cal)
    ];
%% 

% upper = averages(:,2) + variances(:,2);
% lower = averages(:,2) - variances(:,2);

% f = figure;
% f.Theme = "light";
% hold on
% plot(averages(:,1), averages(:,2))
% % plot(averages(:,1), upper, "Color", "blue", "LineStyle","--")
% % plot(averages(:,1), lower, "Color", "blue", "LineStyle","--")
% yline(freestream_avg);
% xlabel("Position $y$ in $cm$", "Interpreter", "latex");
% ylabel("Average wind speed in $\frac{m}{s}$", "Interpreter", "latex");
% hold off

f3 = figure;
f3.Theme = "light";
plot(distances, variances(:,2));
grid on
xlabel("Position $y$ in $cm$", "Interpreter", "latex");
ylabel("Variance of the wind speed $\sigma^2$ in $\frac{m^2}{s^2}$", "Interpreter", "latex");
xlim([0 25])

fit = createFit(distances, averages(:,2));
func = subs(str2sym(formula(fit)),coeffnames(fit),num2cell(coeffvalues(fit).'));
vars = sym(indepnames(fit));
%% 

% Plot fit with data.
figure( 'Name', 'Curve Fit' );
hold on
scatter(averages(:,1), averages(:,2))
fplot(func, [0 25]);
legend('Measured Data', 'Fitted Curve', 'Location', 'NorthEast', 'Interpreter', 'latex' );
% Label axes
xlabel("Position $y$ in $cm$", "Interpreter", "latex");
ylabel("Average wind speed $\langle U \rangle$ in $\frac{m}{s}$", "Interpreter", "latex");
xlim([0 25])
grid on
hold off

M_dot = int(1.225 * freestream_avg * (func - freestream_avg), 0, 25) / 100
C_D = abs(M_dot)/(0.5 * 1.225 * freestream_avg^2 * 0.006)

%%
% Put the right data to plot the growth here
% growth_data = [
%     8, 0.5;
%     25, 1;
%     37.5, 1;
%     53, 1.8
%     ]';
% plot(growth_data(1,:), growth_data(2,:))