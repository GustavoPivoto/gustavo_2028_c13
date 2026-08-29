%%
% 1. Sistema massa-atrito e comparacao grafica

M1 = 2;
B1 = 3;

M2 = 4;
B2 = 6;

num = 1;

den1 = [M1 B1];
den2 = [M2 B2];

sistema_1 = tf(num, den1)
sistema_2 = tf(num, den2)

tempo = 0:0.01:20;

[y1, t1] = step(sistema_1, tempo);
[y2, t2] = step(sistema_2, tempo);

figure
plot(t1, y1)
hold on
plot(t2, y2)
plot(tempo, ones(size(tempo)), '--')

xlabel('Tempo (s)')
ylabel('Velocidade (m/s)')
title('Resposta ao degrau dos sistemas massa-atrito')
legend('Sistema 1', 'Sistema 2', 'Forca unitaria')
grid on

%%
% Janela com os dois sistemas separados

figure

subplot(2,1,1)
plot(t1, y1)
xlabel('Tempo (s)')
ylabel('Velocidade (m/s)')
title('Sistema 1')
grid on

subplot(2,1,2)
plot(t2, y2)
xlabel('Tempo (s)')
ylabel('Velocidade (m/s)')
title('Sistema 2')
grid on

%%
% Janela de ampliacao dos primeiros 5 segundos

figure
plot(t1, y1)
hold on
plot(t2, y2)

xlabel('Tempo (s)')
ylabel('Velocidade (m/s)')
title('Resposta ao degrau - Ampliacao dos primeiros 5 segundos')
legend('Sistema 1', 'Sistema 2')
grid on

axes('Position', [0.58 0.58 0.28 0.28])

plot(t1, y1)
hold on
plot(t2, y2)

xlim([0 5])
xlabel('Tempo (s)')
ylabel('Velocidade')
grid on

%%
% 2. Circuito RC e comparacao de escalas

R = 2000;
tau = 2.5;

C = tau / R;

num = 1;
den = [R*C 1];

sistema = tf(num, den);

fprintf('Capacitancia: %.4f F\n', C)
sistema

tempo = 0:0.01:15;

figure
step(sistema, tempo)
xlabel('Tempo (s)')
ylabel('Tensao')
title('Resposta ao degrau - Circuito RC')
grid on

%%
% Relacao entre resistencia e constante de tempo

Rteste = 100:100:10000;

tau_teste = Rteste * C;

figure

subplot(2,2,1)
plot(Rteste, tau_teste)
xlabel('Resistencia (Ohm)')
ylabel('Constante de tempo (s)')
title('Escala comum')
grid on

subplot(2,2,2)
semilogy(Rteste, tau_teste)
xlabel('Resistencia (Ohm)')
ylabel('Constante de tempo (s)')
title('Escala logaritmica no eixo vertical')
grid on

subplot(2,2,3)
semilogx(Rteste, tau_teste)
xlabel('Resistencia (Ohm)')
ylabel('Constante de tempo (s)')
title('Escala logaritmica no eixo horizontal')
grid on

subplot(2,2,4)
loglog(Rteste, tau_teste)
xlabel('Resistencia (Ohm)')
ylabel('Constante de tempo (s)')
title('Escala logaritmica nos dois eixos')
grid on

%%
% 3. Identificacao e visualizacao de dados experimentais

t = (0:25)';

u = [0 0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1]';

y = [0.008 0.012 0.006 0.010 0.020 0.382 0.671 0.903 1.082 1.226 1.335 1.425 ...
1.492 1.547 1.587 1.618 1.642 1.660 1.674 1.684 1.692 1.698 1.702 1.706 ...
1.709 1.711]';

figure

subplot(2,1,1)
plot(t, u)
xlabel('Tempo (s)')
ylabel('Entrada')
title('Entrada do sistema')
grid on

subplot(2,1,2)
plot(t, y)
xlabel('Tempo (s)')
ylabel('Saida')
title('Saida do sistema')
grid on

%%
% Grafico 3D

figure
plot3(t, u, y)

xlabel('Tempo (s)')
ylabel('Entrada')
zlabel('Saida')
title('Dados experimentais')
grid on

%%
% Identificacao do sistema

Ts = 1;

dados = iddata(y, u, Ts);

sistema_estimado = tfest(dados, 1, 0)

%%
% Comparacao entre dados experimentais e modelo

figure
compare(dados, sistema_estimado)

%%
% Resposta ao degrau do modelo

figure
step(sistema_estimado, 25)
xlabel('Tempo (s)')
ylabel('Saida')
title('Resposta ao degrau - Modelo identificado')
grid on

%%
% 4. Analise de diferentes circuitos RC

R1 = 1000;
tau1 = 1.2;

R2 = 2000;
tau2 = 2.8;

R3 = 3000;
tau3 = 3.9;

R4 = 5000;
tau4 = 7.0;

C1 = tau1 / R1;
C2 = tau2 / R2;
C3 = tau3 / R3;
C4 = tau4 / R4;

fprintf('C1 = %.6f F\n', C1)
fprintf('C2 = %.6f F\n', C2)
fprintf('C3 = %.6f F\n', C3)
fprintf('C4 = %.6f F\n', C4)

R = [R1 R2 R3 R4];
tau = [tau1 tau2 tau3 tau4];
C = [C1 C2 C3 C4];

%%
% Grafico 3D dos experimentos

figure
plot3(R, tau, C, 'o-')

xlabel('Resistencia (Ohm)')
ylabel('Constante de tempo (s)')
zlabel('Capacitancia (F)')
title('Experimentos com circuitos RC')
grid on

%%
% Funcao de transferencia do Experimento 3

num = 1;
den = [R3*C3 1];

sistema_3 = tf(num, den)

tempo = 0:0.01:20;

figure
step(sistema_3, tempo)
xlabel('Tempo (s)')
ylabel('Tensao')
title('Resposta ao degrau - Experimento 3')
grid on

%%
% Janela de ampliacao dos primeiros 5 segundos

axes('Position', [0.58 0.58 0.28 0.28])

step(sistema_3, tempo)

xlim([0 5])
xlabel('Tempo (s)')
ylabel('Tensao')
grid on

%%
% 5. Analise completa de tres tipos de modelagem

% Sistema A - Caixa Branca
M = 3;
B = 5;

num_A = 1;
den_A = [M B];

sistema_A = tf(num_A, den_A);

% Sistema B - Caixa Cinza
R = 1500;
tau = 3;

C = tau / R;

num_B = 1;
den_B = [R*C 1];

sistema_B = tf(num_B, den_B);

% Sistema C - Caixa Preta
t = (0:20)';

u = [0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1]';

y = [0.010 0.006 0.012 0.018 0.408 0.706 0.934 1.103 1.229 1.322 1.391 ...
1.441 1.479 1.505 1.526 1.540 1.551 1.558 1.564 1.568 1.571]';

Ts = 1;

dados = iddata(y, u, Ts);

sistema_C = tfest(dados, 1, 0);

%%
% Mostrando os resultados

fprintf('Sistema A - Funcao de transferencia:\n')
sistema_A

fprintf('Capacitancia do Sistema B: %.4f F\n', C)

fprintf('Sistema B - Funcao de transferencia:\n')
sistema_B

fprintf('Sistema C - Funcao de transferencia estimada:\n')
sistema_C

%%
% Respostas ao degrau dos tres sistemas

tempo = 0:0.01:20;

figure

subplot(3,1,1)
step(sistema_A, tempo)
xlabel('Tempo (s)')
ylabel('Velocidade')
title('Sistema A - Caixa Branca')
grid on

subplot(3,1,2)
step(sistema_B, tempo)
xlabel('Tempo (s)')
ylabel('Tensao')
title('Sistema B - Caixa Cinza')
grid on

subplot(3,1,3)
step(sistema_C, tempo)
xlabel('Tempo (s)')
ylabel('Saida')
title('Sistema C - Caixa Preta')
grid on

%%
% Dados de entrada e saida do Sistema C

figure

subplot(2,1,1)
plot(t, u)
xlabel('Tempo (s)')
ylabel('Entrada')
title('Entrada - Sistema C')
grid on

subplot(2,1,2)
plot(t, y)
xlabel('Tempo (s)')
ylabel('Saida')
title('Saida - Sistema C')
grid on

%%
% Comparacao dos dados experimentais com o modelo

figure
compare(dados, sistema_C)

%%
% Classificacao dos sistemas

% Sistema A: caixa branca, pois o modelo matematico e conhecido.
% Sistema B: caixa cinza, pois parte do modelo e conhecida e usa dado experimental.
% Sistema C: caixa preta, pois o modelo e obtido a partir dos dados experimentais.
