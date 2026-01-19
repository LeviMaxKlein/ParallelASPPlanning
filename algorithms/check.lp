#include <incmode>.
prec(A, X, V) :- precondition(A, X, V).
post(A, X, V) :- postcondition(A, _, X, V).

cycle(0).

#program check(t).
:- query(t), not cycle(t): t!=0.

#program step(t).
prec(A, X, V, t) :- prec(A, X, V), occurs(A, t).
post(A, X, V, t) :- post(A, X, V), occurs(A, t).
action(A, t) :- occurs(A, t).
apply(A1, t) :- action(A1, t), 
    ready(A2, t): post(A1, X, V1, t), prec(A2, X, V2, t), A1 != A2 , V1 != V2.
ready(A, t) :- action(A, t), not occurs (A, t).
ready (A, t) :- apply(A, t).
cycle(t) :- action (A, t), not ready (A, t).

#show.
#show cycle(t): cycle(t).