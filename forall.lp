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

% forall step plan
:- occurs(A,t), prec(A,X,V), not holds(X,V,t-1).

:- occurs(A,t), prec(A,X,V), not post(A,X,_), not holds(X,V,t).

single(X,t) :- occurs(A,t), prec(A,X,V1), post(A,X,V2), V1 != V2.
:- single(X,t), #count{ A : occurs(A,t), post(A,X,V) } > 1.