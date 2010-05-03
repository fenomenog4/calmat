 
 OPTCALMAT. Versión: Septiembre 2003
 
 
 Ejemplo calculo pandeo 1.                                                      
  
 TIPO DE CALCULO:    
 ESTATICO                                                                       
  
 
 
 
 ELEMENTOS
 
 tipo:  P2D                                                                             
 num        nodo i        nodo j       seccion      material
   1             1             2             1             1
 
 tipo:  P2D                                                                             
 num        nodo i        nodo j       seccion      material
   2             2             3             1             1
 
 tipo:  P2D                                                                             
 num        nodo i        nodo j       seccion      material
   3             3             4             1             1
 
 tipo:  P2D                                                                             
 num        nodo i        nodo j       seccion      material
   4             4             5             1             1
 
 
 CONDICIONES DE CONTORNO
 nod            Rx            Ry         Rgiro
   1             1             1             0
   5             1             0             0
 
 
 SECCIONES
 
 num:  1
  0.2500000      5.2080001E-03
 
 
 MATERIALES
 num             E             G          alfa            ro
   1    2.1000E+07    0.0000E+00    0.0000E+00    0.0000E+00
 
 
 CARGAS NODALES
 nod            Fx            Fy             M
   3    1.0000E+00    0.0000E+00    0.0000E+00
   5    0.0000E+00    0.0000E+00    0.0000E+00
 
 
 
 RESULTADOS DE LOS CALCULOS:
 
 
 DESPLAZAMIENTOS DE LOS NODOS
 nodo            Ux            Uy          Giro
    1    0.0000E+00    0.0000E+00   -5.7147E-05
    2    1.3096E-04    0.0000E+00   -4.2860E-05
    3    1.9049E-04    0.0000E+00    1.2203E-11
    4    1.3096E-04    0.0000E+00    4.2860E-05
    5    0.0000E+00    0.0000E+00    5.7147E-05
 
 
 REACCIONES
 nodo            Rx            Ry       Momento
    1   -5.0000E-01    0.0000E+00    0.0000E+00
    5   -5.0000E-01    0.0000E+00    0.0000E+00
 
 
 ESFUERZOS EN LOS ELEMENTOS
 elemento:   1
 nodo          Axil      Cortante       Flector
    1  0.000000E+00  5.000009E-01 -1.543218E-06
    2  0.000000E+00 -5.000009E-01  1.250004E+00
 
 elemento:   2
 nodo          Axil      Cortante       Flector
    2  0.000000E+00  5.000005E-01 -1.250004E+00
    3  0.000000E+00 -5.000005E-01  2.500006E+00
 
 elemento:   3
 nodo          Axil      Cortante       Flector
    3  0.000000E+00 -5.000004E-01 -2.500005E+00
    4  0.000000E+00  5.000004E-01  1.250003E+00
 
 elemento:   4
 nodo          Axil      Cortante       Flector
    4  0.000000E+00 -5.000012E-01 -1.250004E+00
    5  0.000000E+00  5.000012E-01 -3.352318E-07
 
