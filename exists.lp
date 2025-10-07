#include <incmode>.

#program base.
holds(X,V,0) :- init(X,V).

#program check(t).
:- query(t), goal(X,V), not holds(X,V,t).

#program step(t).
{ holds(X,V,t) : value(X,V) } = 1 :- fluent(X).
{ occurs(A,t) } :- action(A).

:- occurs(A,t), post(A,X,V), not holds(X,V,t).
:- holds(X,V,t), not holds(X,V,t-1), not occurs(A,t) : post(A,X,V).

% exists step plan
:- occurs ( A , t ) , prec ( A , X , V ) , not holds ( X , V ,t -1).
apply ( A1 , t ) :- action ( A1 ) ,
ready ( A2 , t ) : post ( A1 , X , V1 ) , prec ( A2 , X , V2 ) , A1 != A2 , V1 != V2 .
ready ( A , t ) :- action ( A ) , not occurs ( A , t ).
ready ( A , t ) :- apply ( A , t ).
:- action ( A ) , not ready ( A , t ).

#show occurs/2.