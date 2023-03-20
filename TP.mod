#Definições
param v; #Quantidade de Veículos
param consumidores; # Quantidade de pessoas que receberão seus produtos em casa
param cp; #Quantidade de Terminais de Coleta

#Sets
set No := {0}; #Nó que representa o depósito
set Nk := {1 .. consumidores}; #Conjunto de nós que representam as pessoas que receberão seus produtos em casa
set Nc := {consumidores + 1 .. cp + consumidores}; #Conjunto de nós que representam os Terminais de Coleta
set Nl := Nc union Nk; #União entre os consumidores HD e os consumidores CP
set N := No union Nc union Nk; #União entre todos os nós
set K := {1 .. v}; #Conjunto de veículos

#Parametros
param tt {i in N, j in N}; #Tempo de viagem entre um nó e outro
param e {i in Nk}; #Limite inferior da janela de tempo
param l {i in Nk}; #Limite superior da janela de tempo
param Q; #Capacidade de cada veículo
param T; #Tempo de planejamento
param q {i in Nl}; # Demanda de cada consumidor
param U {i in N, k in K}; #Demanda restante depois da entrega de cada nó pra determinado veículo
param td {i in N, k in K}; #Tempo de partida depois que um veículo entrega em um determinado nó
param M; #Big M

#Variável de decisão
var x {i in N, j in N, k in K} binary;

#Função Objetivo
minimize Z: sum {i in N, j in N, k in K}  x[i,j,k] * tt[i,j];

#Restrições

Rest1 {j in Nl}: sum {i in N, k in K} x[i,j,k] = 1;

Rest2 {i in N, k in K}: sum {j in Nl diff {i}} x[i,j,k] = sum {j in N diff {i}} x[i,j,k];

Rest3 {k in K} : sum {i in No, j in N diff No} x[i,j,k] = 1;

Rest4 {k in K} : sum {i in N diff No, j in No} x[i,j,k] = 1;

Rest51 {j in N, k in K} : sum {i in Nk} x[i,j,k] * e[i] <= td[j,k];
Rest52 {j in N, k in K} : td[j,k] <= sum {i in Nk} x[i,j,k] * l[i];

Rest6 {i in N, j in N, k in K} : td[i,k] + x[i,j,k] * tt[i,j] <= td[j,k] + T * (1 - x[i,j,k]);

Rest71 {i in Nl, k in K} : 0 <= U[i,k];
Rest72 {i in Nl, k in K} : U[i,k] <= Q - q[i];

Rest8 {i in Nl, j in Nl, k in K} : q[j] + U[j,k] <= U[i,k] + M * (1 - x[i,j,k]);



#Dados do problema
data;
param v := 1;
param cp := 2;
param consumidores := 5;
param M := 999999999;
param Q := 20;
param T:= 2;

param tt:      0      1      2      3      4      5      6      7:=
			0  0.00   10.77  7.42   9.30   15.90  10.61  10.61  23.43
			1  10.77  0.00   20.60  5.01   7.14   8.57   47.43  16.67
			2  7.42   20.60  0.00   4.20   5.34   6.10   24.66  9.30
			3  9.30   5.01   4.20   0.00   10.48  5.99   5.05   6.76
			4  15.90  7.14   5.34   10.48  0.00   13.87  6.76   12.50
			5  10.61  8.57   6.10   5.99   13.87  0.00   7.50   13.87
			6  10.61  47.43  24.66  5.05   6.76   7.50   0.00   14.37
			7  23.43  16.67  9.30   6.76   12.50  13.87  14.37  0.00;
			
param e:= 1 0
		  2 0.25
		  3 0.33
		  4 0.42
		  5 0.42;

param l:= 1 2
		  2 0.83
		  3 0.67
		  4 0.67
		  5 0.67;

param q:= 1 3
		  2 2
		  3 1
		  4 2
		  5 1
		  6 1
		  7 1;

param U :    1:=
		   0 1
		   1 1
		   2 1
		   3 1
		   4 1
		   5 1
		   6 1
		   7 1;


param td :    1:=
			0 0
			1 1.42
			2 1.5
			3 1.12
			4 0.98
			5 1.15
			6 0.65
			7 0.9;


end;

