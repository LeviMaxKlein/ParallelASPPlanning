#program step(t).
cycle(t) :- action (A), not ready (A, t).
#program check(t).
:- query(t), not cycle(T): T=1..t.