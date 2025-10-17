% exists step plan
:- occurs ( A , t ) , prec ( A , X , V ) , not holds ( X , V ,t -1).
apply ( A1 , t ) :- action ( A1 ) ,
ready ( A2 , t ) : post ( A1 , X , V1 ) , prec ( A2 , X , V2 ) , A1 != A2 , V1 != V2 .
ready ( A , t ) :- action ( A ) , not occurs ( A , t ).
ready ( A , t ) :- apply ( A , t ).
:- action ( A ) , not ready ( A , t ).

#show occurs/2.