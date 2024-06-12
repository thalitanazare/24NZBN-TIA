clear all
clc
close all
% Carregando os dados dos arquivos CSV
lw_data = readtable('MGWOH.csv');
lh_data = readtable('MGWH.csv');

% Renomeando colunas para clareza
lw_data.Properties.VariableNames = {'Time', 'Power'};
lh_data.Properties.VariableNames = {'Time', 'Power'};

% Mostrando as primeiras linhas de cada tabela para entender a estrutura
head(lw_data)
head(lh_data)

figure;
hold on;
plot(lw_data.Time, lw_data.Power, 'Color', '#800080', 'LineWidth', 1.5, 'DisplayName', 'Without Horner');
plot(lh_data.Time, lh_data.Power, 'Color', [0, 168/255, 107/255], 'LineWidth', 1.5, 'DisplayName', 'With Horner'); 

title('PMD data collected for the same total iterations $N = 10^7$ ', 'FontSize', 16, 'FontName', 'Times New Roman', 'Interpreter', 'latex');
xlabel('Time (ms)', 'FontSize', 18, 'FontName', 'Times New Roman', 'Interpreter', 'latex');
ylabel('Power (W)', 'FontSize', 18, 'FontName', 'Times New Roman', 'Interpreter', 'latex');
legend('FontSize', 16, 'FontName', 'Times New Roman', 'Interpreter', 'latex');
grid on;
maxTime = max([max(lw_data.Time), max(lh_data.Time)]);
xlim([min(lw_data.Time), maxTime]);
set(gca, 'FontName', 'Times New Roman', 'FontSize', 16);

fig = gcf;
fig.Units = 'inches';
fig.PaperPositionMode = 'auto';
fig_pos = fig.PaperPosition;
fig.PaperSize = [fig_pos(3) fig_pos(4)];
filename = '/Users/thalitanazare/Library/CloudStorage/OneDrive-MaynoothUniversity/PhD/My articles/2024/24TIA/code/pmd_data_fig.pdf';
% Salvando a figura atual no formato PDF
print(fig, filename, '-dpdf', '-bestfit');

% Calculando a energia total gasta para cada modelo
% A energia pode ser aproximada integrando a potência pelo tempo.

% Calculando energia total para lw_data
energy_lw = trapz(lw_data.Time, lw_data.Power);
fprintf('Total energy for LWOH: %f energy units\n', energy_lw);

% Calculando energia total para lh_data
energy_lh = trapz(lh_data.Time, lh_data.Power);
fprintf('Total energy for LWH: %f energy units\n', energy_lh);


% Calculando métricas para LWOH
metrics_lw = calculate_metrics(lw_data);

% Calculando métricas para LWH
metrics_lh = calculate_metrics(lh_data);

% Mostrando as métricas
disp('Metrics for Lorenz without Horner (LWOH):');
disp(metrics_lw);

disp('Metrics for Lorenz with Horner (LWH):');
disp(metrics_lh);

custo_por_kwh = 0.3567; % Substitua 0.20 pelo valor atual se você tiver essa informação

% Convertendo energia de joules para kWh
energia_lw_kwh = energy_lw / 3600000;
energia_lh_kwh = energy_lh / 3600000;

% Calculando o custo total da energia consumida por cada modelo
custo_total_lw = energia_lw_kwh * custo_por_kwh;
custo_total_lh = energia_lh_kwh * custo_por_kwh;

fprintf('Custo total LWOH: %f\n', custo_total_lw);
fprintf('Custo total LWH: %f\n', custo_total_lh);

% Função para calcular métricas
function metrics = calculate_metrics(data)
    energy = trapz(data.Time, data.Power);
    std_dev = std(data.Power);
    max_power = max(data.Power);
    min_power = min(data.Power);
    mean_power = mean(data.Power);
    median_power = median(data.Power);
    metrics = struct('Total_Energy_Joules', energy, 'Standard_Deviation', std_dev, 'Maximum', max_power, 'Minimum', min_power, 'Average', mean_power, 'Median', median_power);
end

