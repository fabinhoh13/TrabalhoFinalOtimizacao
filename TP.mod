#Definições
param v; #Quantidade de Veículos
param consumidores; # Quantidade de pessoas que receberão seus produtos em casa
param cp; #Quantidade de Terminais de Coleta

#Sets
set No := {0}; #Nó que representa o depósito
set Nk := {1 .. consumidores}; #Conjunto de nós que representam as pessoas que receberão seus produtos em casa
set Nc := {1 .. cp}; #Conjunto de nós que representam os Terminais de Coleta
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
param U {i in N, j in N, k in K}; #Demanda restante depois da entrega de cada nó pra determinado veículo
param td {i in N, k in K}; #Tempo de partida depois que um veículo entrega em um determinado nó

#Variável de decisão
var x {i in N, j in N, k in K} binary;

#Função Objetivo
minimize Z: sum {i in N} sum {j in N} sum {k in K} tt[i,j] * x[i,j,k];


#Restrições

Rest1 {j in Nl}: sum {i in N} sum {k in K} x[i,j,k] = 1;


#Dados do problema
data;
param v := 2;
param cp := 3;
param consumidores := 10;

end;