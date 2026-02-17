#program step(t).
reach(X, V, t) :- holds (X, V, t-1).
reach(X, V, t) :- occurs(A, t), apply(A, t), post(A, X, V).
apply(A1, t) :- action(A1), reach(X, V, t) : prec(A1, X, V);
    ready(A2, t) : post(A1, X, V1), prec(A2, X, V2), A1 != A2 , V1 != V2.
ready(A, t) :- action(A), not occurs(A, t).
ready(A, t) :- apply(A, t).
:- action(A), not ready(A, t).