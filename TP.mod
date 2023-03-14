#Defini��es
param v; #Quantidade de Ve�culos
param consumidores; # Quantidade de pessoas que receber�o seus produtos em casa
param cp; #Quantidade de Terminais de Coleta

#Sets
set No := {0}; #N� que representa o dep�sito
set Nk := {1 .. consumidores}; #Conjunto de n�s que representam as pessoas que receber�o seus produtos em casa
set Nc := {1 .. cp}; #Conjunto de n�s que representam os Terminais de Coleta
set Nl := Nc union Nk; #Uni�o entre os consumidores HD e os consumidores CP
set N := No union Nc union Nk; #Uni�o entre todos os n�s
set K := {1 .. v}; #Conjunto de ve�culos

#Parametros
param tt {i in N, j in N}; #Tempo de viagem entre um n� e outro
param e {i in Nk}; #Limite inferior da janela de tempo
param l {i in Nk}; #Limite superior da janela de tempo
param Q; #Capacidade de cada ve�culo
param T; #Tempo de planejamento
param q {i in Nl}; # Demanda de cada consumidor
param U {i in N, j in N, k in K}; #Demanda restante depois da entrega de cada n� pra determinado ve�culo
param td {i in N, k in K}; #Tempo de partida depois que um ve�culo entrega em um determinado n�

#Vari�vel de decis�o
var x {i in N, j in N, k in K} binary;

#Fun��o Objetivo
minimize Z: sum {i in N} sum {j in N} sum {k in K} tt[i,j] * x[i,j,k];


#Restri��es

Rest1 {j in Nl}: sum {i in N} sum {k in K} x[i,j,k] = 1;


#Dados do problema
data;
param v := 2;
param cp := 3;
param consumidores := 10;

end;