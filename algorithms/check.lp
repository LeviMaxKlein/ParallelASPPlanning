#program step(t).
apply(A1, t) :- action(A1), ready(A2, t) : post(A1, X, V1), prec(A2, X, V2), A1 != A2 , V1 != V2.
ready(A, t) :- action(A), not occurs (A, t).
ready (A, t) :- apply(A, t).
cycle(t) :- action (A), not ready (A, t).
#program check(t).
:- query(t), not cycle(T): T=1..t.


#show.
#show occurs/2.