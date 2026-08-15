%%
% 1. Análise de três medições

medicao_1 = input('Digite a primeira medicao: ');
medicao_2 = input('Digite a segunda medicao: ');
medicao_3 = input('Digite a terceira medicao: ');

medicoes = [medicao_1 medicao_2 medicao_3];

media = mean(medicoes)
maior = max(medicoes)
menor = min(medicoes)

if media >= 8
    disp('Resultado alto')
elseif media >= 5
    disp('Resultado intermediario')
else
    disp('Resultado baixo')
end

fprintf('Media das medicoes: %.2f\n', media)

%%
% 2. Processamento de um vetor com for

A = [3 8 2 10 5 7 1 6];

B = zeros(size(A));

for i = 1:length(A)
    if A(i) >= 6
        B(i) = A(i) * 2;
    else
        B(i) = A(i) + 3;
    end
end

A
B

soma = sum(B)
media = mean(B)
maior = max(B)
menor = min(B)

%%
% 3. Identificação de números pares

A = [14 7 20 9 6 11 18 5];

B = zeros(size(A));
contador = 0;

for i = 1:length(A)
    if rem(A(i), 2) == 0
        B(i) = A(i);
        contador = contador + 1;
    else
        B(i) = 0;
    end
end

B
contador

%%
% 4. Calculadora com menu usando switch

a = input('Digite o primeiro valor: ');
b = input('Digite o segundo valor: ');

opcao = input('Digite a opcao: ');

switch opcao
    case 1
        resultado = a + b;
        fprintf('Resultado: %.2f\n', resultado)

    case 2
        resultado = a - b;
        fprintf('Resultado: %.2f\n', resultado)

    case 3
        resultado = a * b;
        fprintf('Resultado: %.2f\n', resultado)

    case 4
        if b == 0
            disp('A divisao por zero nao pode ser realizada')
        else
            resultado = a / b;
            fprintf('Resultado: %.2f\n', resultado)
        end

    otherwise
        disp('Opcao invalida')
end

%%
% 5. Acumulador com while

soma = 0;
contador = 0;

while soma <= 4
    valor = rand;
    soma = soma + valor;
    contador = contador + 1;

    fprintf('Valor sorteado: %.4f\n', valor)
    fprintf('Soma atual: %.4f\n', soma)
end

if contador > 8
    disp('Muitas repeticoes')
else
    disp('Poucas repeticoes')
end

fprintf('Numero total de repeticoes: %d\n', contador)

%%
% 6. Processamento de uma matriz com dois for

A = [2 7 4 9;
    6 1 8 3];

B = zeros(size(A));

for j = 1:size(A,1)
    for i = 1:size(A,2)
        if A(j,i) > 5
            B(j,i) = A(j,i) * 2;
        else
            B(j,i) = A(j,i) + 5;
        end
    end
end

A
B

transposta = B'
linha_1 = B(1,:)
coluna_3 = B(:,3)

%%
% 7. Funcao com duas saidas

A = [5 12 7 3 9 14];

[soma, media] = analisa_vetor(A);

fprintf('Soma: %.2f\n', soma)
fprintf('Media: %.2f\n', media)

if media >= 8
    disp('Media elevada')
else
    disp('Media abaixo de 8')
end

%%
% 8. Funcao para transformar uma matriz

A = [1 5 3 8;
    6 2 7 4];

B = zeros(size(A));

B = transforma_matriz(A, B);

B

%%
% 9. Entrada como texto e conversao numerica

valor_1 = input('Digite o primeiro valor: ', 's');
valor_2 = input('Digite o segundo valor: ', 's');

disp(valor_1)
disp(valor_2)

numero_1 = str2num(valor_1);
numero_2 = str2num(valor_2);

soma = numero_1 + numero_2;
mul = numero_1 * numero_2;

fprintf('Soma: %.2f\n', soma)
fprintf('Multiplicacao: %.2f\n', mul)

if soma > 20
    disp('Soma alta')
elseif soma == 20
    disp('Soma igual a 20')
else
    disp('Soma baixa')
end

%%
% 10. Desafio integrador
dados = [12 18 10 25 15];

soma = sum(dados)
media = mean(dados)
maior = max(dados)
menor = min(dados)

contador = 0;

for i = 1:length(dados)
    if dados(i) >= media
        contador = contador + 1;
    end
end

opcao = input('Digite a opcao: ');

switch opcao
    case 1
        bar(dados)
        title('Grafico de barras dos dados')

    case 2
        pie3(dados)
        title('Grafico de pizza dos dados')

    otherwise
        warning('Nenhum grafico foi criado')
end

if contador > length(dados) / 2
    disp('Maioria dos valores acima ou igual a media')
else
    disp('Menos da metade dos valores acima ou igual a media')
end
