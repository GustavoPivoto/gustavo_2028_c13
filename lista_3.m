%%
% 1. Funcoes e graficos 2D

tempo = 0:0.1:10;

senoide = 2 * sin(3 * tempo);
cossenoide = 2 * cos(3 * tempo);

plot(tempo, senoide)
hold on
plot(tempo, cossenoide)

xlabel('Tempo (s)')
ylabel('Amplitude')
title('Senoide e Cossenoide')
legend('Senoide', 'Cossenoide')
grid on

qtd = length(tempo)

%%
% 2. Entrada de dados, condicao e grafico

a = input('Digite o valor de a: ');

x = -10:0.1:10;
y = a * x + 2;

if a > 0
    disp('O coeficiente e positivo')
elseif a < 0
    disp('O coeficiente e negativo')
else
    disp('O coeficiente e igual a zero')
end

plot(x, y)
xlabel('x')
ylabel('y')
title('Funcao y = a*x + 2')
grid on

axes('Position', [0.6 0.6 0.25 0.25])
x2 = -2:0.1:2;
y2 = a * x2 + 2;

plot(x2, y2)
grid on
xlabel('x')
ylabel('y')
title('Regiao entre -2 e 2')

%%
% 3. Repeticao e organizacao de graficos

valores = zeros(1,5);

for i = 1:5
    valores(i) = i * 3;
end

dobro = valores * 2;

subplot(2,1,1)
plot(valores, '-o')
xlabel('Posicao')
ylabel('Valor')
title('Multiplos de 3')
grid on

subplot(2,1,2)
plot(dobro, '-o')
xlabel('Posicao')
ylabel('Valor')
title('Dobro dos multiplos de 3')
grid on

%%
% 4. Comparacao de escalas

t = 0:1:1000;

y = 50000 * exp(-0.05 * t);

subplot(2,1,1)
plot(t, y)
xlabel('Tempo')
ylabel('y')
title('Escala comum')
grid on

subplot(2,1,2)
semilogy(t, y)
xlabel('Tempo')
ylabel('y')
title('Escala logaritmica no eixo vertical')
grid on

%%
% 5. Graficos 3D

x = 1:0.1:10;
y = 1:0.1:20;

[X, Y] = meshgrid(x, y);

Z = sin(X) + cos(Y);

subplot(1,2,1)
surf(X, Y, Z)
xlabel('X')
ylabel('Y')
zlabel('Z')
title('Superficie 3D')
shading interp
colormap parula
grid on

subplot(1,2,2)
contour(X, Y, Z)
xlabel('X')
ylabel('Y')
title('Curvas de nivel')
grid on