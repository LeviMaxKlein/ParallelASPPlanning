#include <incmode>.

#program base.
fluent(X) :- variable(X).
fluent(X,V) :- initialState(X,V), fluent(X).
value(X,V) :- contains(X, V).
prec(A, X, V) :- precondition(A, X, V).
post(A, X, V) :- postcondition(A, _, X, V).

mutex(G,X) :- mutexGroup(G), contains(G,X,V), fluent(X,V).
mutex(G)   :- mutexGroup(G), #count{X : mutex(G,X)} > 1.

% Initial state
holds(X, V, 0) :- initialState(X, V).
:- fluent(X), #count{V : holds(X,V,0)} > 1.
:- mutex(G), #count{X,V : holds(X,V,0), contains(G,X,V)} > 1.

#program check(t).
:- query(t), goal(X, V), not holds(X, V, t).

#program step(t).
{holds(X, V, t) : value(X, V)} = 1 :- fluent(X).
{ occurs(A, t) } :- action(A) .

:- mutex(G), #count{X,V : holds(X,V,t), contains(G,X,V)} > 1.

:- occurs(A, t), post(A, X, V), not holds(X, V, t).
:- holds(X, V, t), not holds(X, V, t-1), not occurs(A, t) : post(A, X, V).
:- occurs(A, t) , prec(A, X, V), not holds(X, V ,t -1).

#show. 
#show occurs(A,t) : occurs(A, t).