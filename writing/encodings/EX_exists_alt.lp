#program step(t).
:- occurs(A, t), prec(A ,X ,V), not holds(X, V, t-1).
#edge((A1, t), (A2, t)): occurs(A1, t),
    post(A1, X, V1), prec(A2, X, V2), A1 != A2, V1 != V2.