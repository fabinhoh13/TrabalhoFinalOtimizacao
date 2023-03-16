from math import sqrt

pontos = [(10.2, 7.4), (12.8, 6.4), (14.2, 6.8), (7.4, 9.0), (8.6, 6.4), (9.8, 4.6), (13.0, 7.0), (11.0, 6.4)]
cont = 0
tempos = []
for i in pontos:
    tempos.append ([])
    xa, ya = i
    for j in pontos:
        xb, yb = j
        distancia = (xb - xa) ** 2 + (yb - ya) ** 2
        distancia = sqrt (distancia)
        if (distancia == 0):
            tempos[cont].append (0)
        else:
            t = 30 / distancia
            tempos[cont].append (round (t, 2))
    cont += 1
        
for i in range (len (tempos)):
    for j in range (len (tempos)):
        print (f'{tempos[i][j]:8.2f}', end='')
    print ()
