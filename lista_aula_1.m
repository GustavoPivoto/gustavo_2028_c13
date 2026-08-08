%%
% 1. Operações básicas
a = 12;
b = 5;

soma = a + b
sub = a - b
mul = a * b
div = a / b
elevado = a ^ b;

%%
% 2. Raiz, arredondamento e resto
raiz = sqrt(144)
arredondamento = round(7.6)
arredondamento_cima = ceil(4.01)
resto = rem(250,17)

%%
% 3. MDC e MMC
maximo = gcd(24,46)
minimo = lcm(12,18)

%%
% 4. 
% elevado_2 = exp(2)

seno = sin(30)
cosseno = cos(60)
tangente = tan(45)

%%
% 5. Criando vetores
vetor_1 = 1:10
vetor_2 = 10:-1:1

pares = 0:2:20
espaco = linspace(0, 100, 5)

%%
% 6. Acessando posições de um vetor
v = [4 8 15 16 23 42];

prim= v(1)
ultimo = v(end)
interv = v(2:4)
espec = v([1, 3, 6])

%%
% 7. Informações sobre um vetor
v2 = [5 10 15 20 25];

qtd = length(v2)
dimen = size(v2)
soma_2 = sum(v2)
media = mean(v2)
maximo = max(v2)
minimo = min(v2)

%%
% 8. Vetor linha e vetor coluna
v3 = [10 20 30 40];

transposta = v3'

antes = size(v3)
depois = size(transposta)

%%
% 9. Criando e acessando uma matriz
A2 = [3 6 9; 2 4 8; 1 5 7];

elemento = A2(2,3)
linha_1 = A2(1, :)
coluna_2 = A2(:, 2)
dimen_2 = size(v2)

%%
% 10. Operações com matrizes
A3 = [1 2;
    3 4];
B3 = [2 0;
    1 5];

soma_2 = A3 + B3
MUL_2 = A3 * B3
transp_2 = A3'

 preen_zeros = zeros(3)
 preen_uns = ones(2,4)
 iden = eye(4)
 ale = rand(3)