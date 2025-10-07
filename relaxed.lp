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

% relaxed exists step plan
reach ( X , V , t ) :- holds ( X , V ,t -1).
reach ( X , V , t ) :- occurs ( A , t ) , apply ( A , t ) , post ( A , X , V ).
apply ( A1 , t ) :- action ( A1 ) , reach ( X , V , t ) : prec ( A1 , X , V );
ready ( A2 , t ) : post ( A1 , X , V1 ) , prec ( A2 , X , V2 ) , A1 != A2 , V1 != V2 .
ready ( A , t ) :- action ( A ) , not occurs ( A , t ).
ready ( A , t ) :- apply ( A , t ).
:- action ( A ) , not ready ( A , t ).