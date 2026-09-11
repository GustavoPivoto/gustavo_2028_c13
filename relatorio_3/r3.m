%%
% 1. Identificacao de um sistema de primeira ordem a partir de um ensaio

valor_final = 1.8;
tau = 1.2;
ganho = valor_final;
num = ganho;
den = [tau 1];
sistema_1 = tf(num, den);
polo_1 = pole(sistema_1);
ganho_regime_1 = dcgain(sistema_1);
info_1 = stepinfo(sistema_1, ...
    'RiseTimeLimits', [0.1 0.9], ...
    'SettlingTimeThreshold', 0.02);
fprintf('1. Identificacao do sistema de primeira ordem\n')
fprintf('Valor final: %.4f\n', valor_final)
fprintf('Constante de tempo: %.4f s\n', tau)
fprintf('Ganho: %.4f\n', ganho)
fprintf('Polo: %.4f\n', polo_1)
fprintf('Tempo de subida (10%% a 90%%): %.4f s\n', info_1.RiseTime)
fprintf('Tempo de acomodacao (2%%): %.4f s\n', info_1.SettlingTime)
fprintf('Ganho em regime permanente: %.4f\n', ganho_regime_1)
fprintf('Funcao de transferencia:\n')
sistema_1
tempo = 0:0.01:8;
[y1, t1] = step(sistema_1, tempo);
figure
plot(t1, y1)
hold on
plot(tempo, valor_final * ones(size(tempo)), '--')
xlabel('Tempo (s)')
ylabel('Saida')
title('Resposta ao degrau unitario - Sistema de primeira ordem')
legend('Resposta do sistema', 'Valor final')
grid on

%%
% Resposta para uma entrada em degrau de amplitude 2,5

amplitude = 2.5;
valor_final_2 = ganho_regime_1 * amplitude;
[y2, t2] = step(amplitude * sistema_1, tempo);
fprintf('\nEntrada em degrau de amplitude: %.2f\n', amplitude)
fprintf('Novo valor final da saida: %.4f\n', valor_final_2)
fprintf('Funcao de transferencia com entrada de amplitude %.2f:\n', amplitude)
amplitude * sistema_1
figure
plot(t2, y2)
hold on
plot(tempo, valor_final_2 * ones(size(tempo)), '--')
xlabel('Tempo (s)')
ylabel('Saida')
title('Resposta ao degrau de amplitude 2,5 - Sistema de primeira ordem')
legend('Resposta do sistema', 'Valor final')
grid on

% A constante de tempo maior deixa a resposta mais lenta.
% Quanto mais distante o polo estiver da origem, mais rapida e a resposta.

%%
% 2. Escolha entre tres sistemas de segunda ordem

num_A = 25;
den_A = [1 3 25];
sistema_A = tf(num_A, den_A);
num_B = 25;
den_B = [1 10 25];
sistema_B = tf(num_B, den_B);
num_C = 25;
den_C = [1 16 25];
sistema_C = tf(num_C, den_C);
sistemas_2 = {sistema_A, sistema_B, sistema_C};
nomes_2 = {'Sistema A', 'Sistema B', 'Sistema C'};
for i = 1:3
    sistema_atual = sistemas_2{i};
    [num_atual, den_atual] = tfdata(sistema_atual, 'v');
    wn_atual = sqrt(den_atual(3));
    zeta_atual = den_atual(2) / (2 * wn_atual);
    polos_atual = pole(sistema_atual);
    ganho_atual = dcgain(sistema_atual);
    fprintf('\n%s\n', nomes_2{i})
    fprintf('Polos:\n')
    disp(polos_atual)
    fprintf('Frequencia natural: %.4f rad/s\n', wn_atual)
    fprintf('Coeficiente de amortecimento: %.4f\n', zeta_atual)
    if zeta_atual < 1
        fprintf('Tipo de resposta: subamortecida\n')
    elseif abs(zeta_atual - 1) < 1e-10
        fprintf('Tipo de resposta: criticamente amortecida\n')
    else
        fprintf('Tipo de resposta: superamortecida\n')
    end
    fprintf('Ganho em regime permanente: %.4f\n', ganho_atual)
    fprintf('Funcao de transferencia:\n')
    sistema_atual
end

%%
% Resposta ao degrau unitario dos tres sistemas

tempo = 0:0.01:8;
[yA, tA] = step(sistema_A, tempo);
[yB, tB] = step(sistema_B, tempo);
[yC, tC] = step(sistema_C, tempo);
figure
plot(tA, yA)
hold on
plot(tB, yB)
plot(tC, yC)
xlabel('Tempo (s)')
ylabel('Saida')
title('Resposta ao degrau unitario - Sistemas A, B e C')
legend('Sistema A', 'Sistema B', 'Sistema C')
grid on

%%
% Posicao dos polos dos tres sistemas

polos_A = pole(sistema_A);
polos_B = pole(sistema_B);
polos_C = pole(sistema_C);
figure
plot(real(polos_A), imag(polos_A), 'x', 'MarkerSize', 10, 'LineWidth', 2)
hold on
plot(real(polos_B), imag(polos_B), 'o', 'MarkerSize', 8, 'LineWidth', 2)
plot(real(polos_C), imag(polos_C), 's', 'MarkerSize', 8, 'LineWidth', 2)
xlabel('Parte real')
ylabel('Parte imaginaria')
title('Posicao dos polos dos sistemas de segunda ordem')
legend('Sistema A', 'Sistema B', 'Sistema C')
grid on

%%
% Escolha do sistema para a aplicacao

info_A = stepinfo(sistema_A, ...
    'RiseTimeLimits', [0.1 0.9], ...
    'SettlingTimeThreshold', 0.02);
info_B = stepinfo(sistema_B, ...
    'RiseTimeLimits', [0.1 0.9], ...
    'SettlingTimeThreshold', 0.02);
info_C = stepinfo(sistema_C, ...
    'RiseTimeLimits', [0.1 0.9], ...
    'SettlingTimeThreshold', 0.02);
fprintf('\nEscolha para a aplicacao sem sobressinal:\n')
fprintf('Sistema A - Sobressinal: %.4f %%\n', info_A.Overshoot)
fprintf('Sistema B - Sobressinal: %.4f %%\n', info_B.Overshoot)
fprintf('Sistema C - Sobressinal: %.4f %%\n', info_C.Overshoot)
fprintf('Sistema escolhido: Sistema B\n')

% O Sistema B e o mais adequado, pois nao apresenta sobressinal e e mais rapido
% que o Sistema C, que tambem nao apresenta sobressinal.

%%
% 3. Avaliacao de desempenho de dois sistemas de segunda ordem

num_1 = 16;
den_1 = [1 2.8 16];
sistema_3_1 = tf(num_1, den_1);
num_2 = 25;
den_2 = [1 6.5 25];
sistema_3_2 = tf(num_2, den_2);
sistemas_3 = {sistema_3_1, sistema_3_2};
nomes_3 = {'Sistema 1', 'Sistema 2'};
for i = 1:2
    sistema_atual = sistemas_3{i};
    [num_atual, den_atual] = tfdata(sistema_atual, 'v');
    wn_atual = sqrt(den_atual(3));
    zeta_atual = den_atual(2) / (2 * wn_atual);
    ganho_atual = dcgain(sistema_atual);
    polos_atual = pole(sistema_atual);
    info_atual = stepinfo(sistema_atual, 'RiseTimeLimits', [0.1 0.9], 'SettlingTimeThreshold', 0.02);
    tempo_aux = 0:0.001:8;
    [y_aux, t_aux] = step(sistema_atual, tempo_aux);
    valor_final_aux = dcgain(sistema_atual);
    indice_50 = find(y_aux >= 0.5 * valor_final_aux, 1);
    tempo_50 = t_aux(indice_50);
    fprintf('\n%s\n', nomes_3{i})
    fprintf('Valor final da resposta: %.4f\n', ganho_atual)
    fprintf('Tempo de atraso (50%%): %.4f s\n', tempo_50)
    fprintf('Tempo de subida (10%% a 90%%): %.4f s\n', info_atual.RiseTime)
    fprintf('Tempo de pico: %.4f s\n', info_atual.PeakTime)
    fprintf('Valor do primeiro pico: %.4f\n', info_atual.Peak)
    fprintf('Maximo sobressinal: %.4f %%\n', info_atual.Overshoot)
    fprintf('Tempo de acomodacao (2%%): %.4f s\n', info_atual.SettlingTime)
    fprintf('Frequencia natural: %.4f rad/s\n', wn_atual)
    fprintf('Coeficiente de amortecimento: %.4f\n', zeta_atual)
    fprintf('Polos:\n')
    disp(polos_atual)
    fprintf('Funcao de transferencia:\n')
    sistema_atual
end

%%
% Comparacao das respostas ao degrau

tempo = 0:0.01:8;
[y31, t31] = step(sistema_3_1, tempo);
[y32, t32] = step(sistema_3_2, tempo);
figure
plot(t31, y31)
hold on
plot(t32, y32)
xlabel('Tempo (s)')
ylabel('Saida')
title('Resposta ao degrau unitario - Comparacao dos sistemas')
legend('Sistema 1', 'Sistema 2')
grid on

%%
% Verificacao dos requisitos da aplicacao

info_31 = stepinfo(sistema_3_1, ...
    'RiseTimeLimits', [0.1 0.9], ...
    'SettlingTimeThreshold', 0.02);
info_32 = stepinfo(sistema_3_2, ...
    'RiseTimeLimits', [0.1 0.9], ...
    'SettlingTimeThreshold', 0.02);
atende_1 = (info_31.Overshoot < 10) && (info_31.SettlingTime < 1.5);
atende_2 = (info_32.Overshoot < 10) && (info_32.SettlingTime < 1.5);
fprintf('\nVerificacao dos requisitos:\n')
fprintf('Sistema 1 atende aos requisitos: %d\n', atende_1)
fprintf('Sistema 2 atende aos requisitos: %d\n', atende_2)
fprintf('Sistema escolhido: Sistema 2\n')

% O Sistema 1 possui maior sobressinal e maior tempo de acomodacao.
% O Sistema 2 atende aos dois requisitos e apresenta um transitório mais controlado.

%%
% 4. Selecao de parametros para um sistema de segunda ordem

zeta_A = 0.35;
wn_A = 6;
zeta_B = 0.55;
wn_B = 5;
zeta_C = 0.70;
wn_C = 4;
zeta_D = 0.80;
wn_D = 3.2;
zeta_4 = [zeta_A zeta_B zeta_C zeta_D];
wn_4 = [wn_A wn_B wn_C wn_D];
nomes_4 = {'Configuracao A', 'Configuracao B', ...
           'Configuracao C', 'Configuracao D'};
sistema_4_A = tf(wn_A^2, [1 2*zeta_A*wn_A wn_A^2]);
sistema_4_B = tf(wn_B^2, [1 2*zeta_B*wn_B wn_B^2]);
sistema_4_C = tf(wn_C^2, [1 2*zeta_C*wn_C wn_C^2]);
sistema_4_D = tf(wn_D^2, [1 2*zeta_D*wn_D wn_D^2]);
sistemas_4 = {sistema_4_A, sistema_4_B, sistema_4_C, sistema_4_D};
for i = 1:4
    sistema_atual = sistemas_4{i};
    info_atual = stepinfo(sistema_atual, ...
        'RiseTimeLimits', [0.1 0.9], ...
        'SettlingTimeThreshold', 0.02);
    polos_atual = pole(sistema_atual);
    fprintf('\n%s\n', nomes_4{i})
    fprintf('Zeta: %.4f\n', zeta_4(i))
    fprintf('Wn: %.4f rad/s\n', wn_4(i))
    fprintf('Polos:\n')
    disp(polos_atual)
    fprintf('Maximo sobressinal: %.4f %%\n', info_atual.Overshoot)
    fprintf('Tempo de subida (10%% a 90%%): %.4f s\n', info_atual.RiseTime)
    fprintf('Tempo de pico: %.4f s\n', info_atual.PeakTime)
    fprintf('Tempo de acomodacao (2%%): %.4f s\n', info_atual.SettlingTime)
    fprintf('Valor final da resposta: %.4f\n', dcgain(sistema_atual))
    fprintf('Funcao de transferencia:\n')
    sistema_atual
end

%%
% Resposta ao degrau das quatro configuracoes

tempo = 0:0.01:8;
[y4A, t4A] = step(sistema_4_A, tempo);
[y4B, t4B] = step(sistema_4_B, tempo);
[y4C, t4C] = step(sistema_4_C, tempo);
[y4D, t4D] = step(sistema_4_D, tempo);
figure
plot(t4A, y4A)
hold on
plot(t4B, y4B)
plot(t4C, y4C)
plot(t4D, y4D)
xlabel('Tempo (s)')
ylabel('Saida')
title('Resposta ao degrau unitario - Quatro configuracoes')
legend('Configuracao A', 'Configuracao B', ...
       'Configuracao C', 'Configuracao D')
grid on

%%
% Verificacao dos requisitos e escolha da configuracao

infos_4 = cell(1,4);
atende_4 = false(1,4);
for i = 1:4
    infos_4{i} = stepinfo(sistemas_4{i}, ...
        'RiseTimeLimits', [0.1 0.9], ...
        'SettlingTimeThreshold', 0.02);
    atende_4(i) = (infos_4{i}.Overshoot < 10) && ...
                  (infos_4{i}.SettlingTime < 1.5);
end
fprintf('\nVerificacao dos requisitos das configuracoes:\n')

for i = 1:4
    fprintf('%s atende aos requisitos: %d\n', nomes_4{i}, atende_4(i))
end
tempos_subida_validos = inf(1,4);
for i = 1:4
    if atende_4(i)
        tempos_subida_validos(i) = infos_4{i}.RiseTime;
    end
end
[menor_tempo_subida, indice_escolhido] = min(tempos_subida_validos);
fprintf('Configuracao escolhida: %s\n', nomes_4{indice_escolhido})
fprintf('Menor tempo de subida entre as validas: %.4f s\n', menor_tempo_subida)

% Os graficos mostram que as configuracoes com maior amortecimento reduzem o sobressinal.
% A Configuracao C foi escolhida por atender aos requisitos e possuir a menor subida entre as validas.

%%
% 5. Comparacao entre sistemas de primeira e segunda ordem

num_A = 2;
den_A = [1.2 1];
equipamento_A = tf(num_A, den_A);
num_B = 32;
den_B = [1 5.6 16];
equipamento_B = tf(num_B, den_B);
polo_A = pole(equipamento_A);
polo_B = pole(equipamento_B);
ganho_A = dcgain(equipamento_A);
ganho_B = dcgain(equipamento_B);
info_A = stepinfo(equipamento_A, ...
    'RiseTimeLimits', [0.1 0.9], ...
    'SettlingTimeThreshold', 0.02);
info_B = stepinfo(equipamento_B, ...
    'RiseTimeLimits', [0.1 0.9], ...
    'SettlingTimeThreshold', 0.02);
wn_B = sqrt(16);
zeta_B = 5.6 / (2 * wn_B);
fprintf('\n5. Comparacao entre primeira e segunda ordem\n')
fprintf('\nEquipamento A - Sistema de primeira ordem\n')
fprintf('Polos:\n')
disp(polo_A)
fprintf('Ganho em regime permanente: %.4f\n', ganho_A)
fprintf('Valor final da resposta: %.4f\n', ganho_A)
fprintf('Tempo de subida (10%% a 90%%): %.4f s\n', info_A.RiseTime)
fprintf('Tempo de acomodacao (2%%): %.4f s\n', info_A.SettlingTime)
fprintf('Funcao de transferencia:\n')
equipamento_A
fprintf('\nEquipamento B - Sistema de segunda ordem\n')
fprintf('Polos:\n')
disp(polo_B)
fprintf('Ganho em regime permanente: %.4f\n', ganho_B)
fprintf('Valor final da resposta: %.4f\n', ganho_B)
fprintf('Tempo de subida (10%% a 90%%): %.4f s\n', info_B.RiseTime)
fprintf('Tempo de acomodacao (2%%): %.4f s\n', info_B.SettlingTime)
fprintf('Frequencia natural: %.4f rad/s\n', wn_B)
fprintf('Coeficiente de amortecimento: %.4f\n', zeta_B)
fprintf('Tempo de pico: %.4f s\n', info_B.PeakTime)
fprintf('Valor do primeiro pico: %.4f\n', info_B.Peak)
fprintf('Maximo sobressinal: %.4f %%\n', info_B.Overshoot)
fprintf('Funcao de transferencia:\n')
equipamento_B

%%
% Resposta ao degrau unitario dos dois equipamentos

tempo = 0:0.01:8;
[y5A, t5A] = step(equipamento_A, tempo);
[y5B, t5B] = step(equipamento_B, tempo);
figure
plot(t5A, y5A)
hold on
plot(t5B, y5B)
xlabel('Tempo (s)')
ylabel('Saida')
title('Resposta ao degrau unitario - Equipamentos A e B')
legend('Equipamento A', 'Equipamento B')
grid on

%%
% Resposta para uma entrada de degrau de amplitude 1,5

amplitude_5 = 1.5;
valor_final_5A = ganho_A * amplitude_5;
valor_final_5B = ganho_B * amplitude_5;
[y5A_15, t5A_15] = step(amplitude_5 * equipamento_A, tempo);
[y5B_15, t5B_15] = step(amplitude_5 * equipamento_B, tempo);
fprintf('\nEntrada em degrau de amplitude %.2f\n', amplitude_5)
fprintf('Equipamento A - novo valor final: %.4f\n', valor_final_5A)
fprintf('Equipamento B - novo valor final: %.4f\n', valor_final_5B)
figure
plot(t5A_15, y5A_15)
hold on
plot(t5B_15, y5B_15)
xlabel('Tempo (s)')
ylabel('Saida')
title('Resposta ao degrau de amplitude 1,5 - Equipamentos A e B')
legend('Equipamento A', 'Equipamento B')
grid on

% O Equipamento B apresenta resposta mais rapida que o Equipamento A.
% O Equipamento A nao apresenta sobressinal, enquanto o Equipamento B apresenta um pequeno sobressinal.
% Em regime permanente, ambos atingem o mesmo valor para a mesma entrada.
