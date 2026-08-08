%%
% 1. Entrada e saída
cidade = input('Digite o nome de uma cidade: ', 's');
disp(cidade);
fprintf('Cidade escolhida: %s\n', cidade);

%%
% 2. if, elseif e else
x = 7;

if x > 10
    disp('Maior que 10')
elseif x == 10
    disp('Igual a 10')
else
    disp('Menor que 10')
end

% Alterando o valor de x para testar outros casos
x = 10;

if x > 10
    disp('Maior que 10')
elseif x == 10
    disp('Igual a 10')
else
    disp('Menor que 10')
end

x = 15;

if x > 10
    disp('Maior que 10')
elseif x == 10
    disp('Igual a 10')
else
    disp('Menor que 10')
end

%%
% 3. for
for i = 1:5
    resultado = i * 3
end

%%
% 4. while
x = 0;
i = 0;

while i < 5
    x = x + 1;
    i = i + 1;
    x
end

%%
% 5. switch e função

% a) switch
opcao = 2;

switch opcao
    case 1
        disp('Opcao A')
    case 2
        disp('Opcao B')
    case 3
        disp('Opcao C')
    otherwise
        disp('Opcao invalida')
end

% b) Função
valor = 7;
resultado_2 = funcao_triplo(valor)
