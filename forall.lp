% forall step plan
:- occurs(A,t), prec(A,X,V), not holds(X,V,t-1).

:- occurs(A,t), prec(A,X,V), not post(A,X,_), not holds(X,V,t).

single(X,t) :- occurs(A,t), prec(A,X,V1), post(A,X,V2), V1 != V2.
:- single(X,t), #count{ A : occurs(A,t), post(A,X,V) } > 1.