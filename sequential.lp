% sequential plan
:- occurs ( A , t ) , prec ( A , X , V ) , not holds ( X , V ,t -1).
:- #count { A : occurs ( A , t )} > 1.

#show occurs/2.