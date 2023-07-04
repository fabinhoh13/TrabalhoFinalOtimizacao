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

Rest4 {k in K} : sum {i in N diff No, j in No} x[i,j,k] <= 1;

Rest51 {j in N, k in K} : sum {i in Nk} x[i,j,k] * e[i] <= td[j,k];
#Rest52 {j in N, k in K} : td[j,k] <= sum {i in Nk} x[i,j,k] * l[i];

Rest6 {i in N, j in N, k in K} : td[i,k] + x[i,j,k] * tt[i,j] <= td[j,k] + T * (1 - x[i,j,k]);

Rest7 {i in Nl, k in K} : 0 <= U[i,k] <= Q - q[i];

Rest8 {i in Nl, j in Nl, k in K} : q[j] + U[j,k] <= U[i,k] + M * (1 - x[i,j,k]);



#Dados do problema
data;
param v := 1;
param cp := 5;
param consumidores := 9;
param M := 999999999;
param Q := 20;
param T:= 9999999999;

param tt:      0       1       2        3      4       5       6       7       8       9      10      11      12       13      14:=
			0  00.00   10.77   07.42   09.30   15.90   10.61   07.95    7.53    5.51    3.21   10.61   23.43   13.35    8.56    5.73
			1  10.77   00.00   20.60   05.01   07.14   08.57   13.16    4.69    5.05    2.67   47.43   16.67    7.68    7.99    4.38
			2  07.42   20.60   00.00   04.20   05.34   06.10   09.15    3.83    4.14    2.36   24.66    9.30    5.60    5.88    3.61
			3  09.30   05.01   04.20   00.00   10.48   05.99   04.42   10.09    4.34    3.60    5.05    6.76    7.80    5.24    5.58
			4  15.90   07.14   05.34   10.48   00.00   13.87   07.11   13.58    7.14    4.02    6.76   12.50   30.46   10.47    8.77
			5  10.61   08.57   06.10   05.99   13.87   00.00   12.33    7.98   11.18    3.84    7.50   13.87   24.91   41.21    8.77
			6  07.95   13.16   09.15   04.42   07.11   12.33   00.00    4.89    7.28    2.98   10.30   11.97    8.69   13.51    5.24
			7  07.53   04.69   03.83   10.09   13.58   07.98   04.89    0.00    6.57    5.37    4.51    6.52   11.14    7.02   11.99
			8  05.51   05.05   04.14   04.34   07.14   11.18   07.28    6.57    0.00    4.76    4.61    6.20    9.02   13.62   11.62
			9  03.21   02.67   02.36   03.60   04.02   03.84   02.98    5.37    4.76    0.00    2.58    3.13    4.06    3.82    6.82
		   10  10.61   47.43   24.66   05.05   06.76   07.50   10.30    4.51    4.61    2.58    0.00   14.37    7.02    6.95    4.12
		   11  23.43   16.67   09.30   06.76   12.50   13.87   11.97    6.52    6.20    3.13   14.37    0.00   13.68   11.14    5.72
		   12  13.35   07.68   05.60   07.80   30.46   24.91   08.69   11.14    9.02    4.06    7.02   13.68    0.00   15.90    9.74
		   13  08.56   07.99   05.88   05.24   10.47   41.21   13.51    7.02   13.62    3.82    6.95   11.14   15.90    0.00    8.56
		   14  05.73   04.38   03.61   05.58   08.77   08.77   05.24   11.99   11.62    6.82    4.12    5.72    9.74    8.56    0.00;



param e:= 1 0.00
		  2 0.25
		  3 0.33
		  4 0.42
		  5 0.42
		  6 0.17
		  7 0.00
		  8 0.38
		  9 0.00;

param l:= 1 2.00
		  2 0.83
		  3 0.67
		  4 0.67
		  5 1.00
		  6 0.50
		  7 2.00
		  8 0.72
		  9 0.33;

param q:= 1 3
		  2 2
		  3 1
		  4 2
		  5 1
		  6 1
		  7 1
		  8 2
		  9 3
		  10 1
		  11 4
		  12 1
		  14 2;

param U :    1:=
		   0 1
		   1 1
		   2 1
		   3 1
		   4 1
		   5 1
		   6 1
		   7 1
		   8 1
		   9 1
		   10 1
		   11 1
		   12 1
		   13 1
		   14 1;


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