%%
% 1. Sistema massa-mola-amortecedor

M = 2;
B = 3;
K = 8;

num = 1;
den = [M B K];

sistema = tf(num, den)

figure
step(sistema, 15)
xlabel('Tempo (s)')
ylabel('Posicao')
title('Resposta ao degrau - Sistema massa-mola-amortecedor')
grid on

%%
% 2. Circuito RC

R = 1000;
tau = 2;

C = tau / R;

num = 1;
den = [R*C 1];

sistema = tf(num, den);

fprintf('Capacitancia: %.4f F\n', C)
sistema

figure
step(sistema, 10)
xlabel('Tempo (s)')
ylabel('Tensao')
title('Resposta ao degrau - Circuito RC')
grid on

%%
% 3. Sistema massa-atrito

M = 4;
F = 1;
velocidade = 0.5;

B = F / velocidade;

num = 1;
den = [M B];

sistema = tf(num, den);

fprintf('Coeficiente de atrito B: %.2f\n', B)
sistema

figure
step(F * sistema)
xlabel('Tempo (s)')
ylabel('Velocidade (m/s)')
title('Resposta do sistema massa-atrito')
grid on