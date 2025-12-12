#include <incmode>.

#program base.
fluent(X) :- variable(X).
value(X, V) :- contains(X, V).

prec(A, X, V) :- precondition(A, X, V).
post(A, X, V) :- postcondition(A, _, X, V).

holds(X, V, 0) :- initialState(X, V).

#program check(t).
:- query(t), goal(X, V), not holds(X, V, t).

#program step(t).
{holds(X, V, t) : value(X, V)} = 1 :- fluent(X). %holds is a fluent 
{occurs(A, t)} :- action(A). %occurs is an action

:- occurs(A, t), post(A, X, V), not holds(X, V, t). %postcondition must be executed
:- holds(X, V, t), not holds(X, V, t-1), not occurs(A, t) : post(A, X, V). %only actions can change fluents
:- occurs(A, t), prec(A, X, V), not holds(X, V, t-1). %precondition has to hold

#show.
#show occurs(A, t) : occurs(A, t).
#show holds(X, V, t): holds(X, V, t).