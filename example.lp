fluent(x1). fluent(x2). fluent(x3). fluent(x4). fluent(x5).
value(x1,0). value(x1,1).
value(x2,0). value(x2,1).
value(x3,0). value(x3,1).
value(x4,0). value(x4,1).
value(x5,0). value(x5,1).

init(x1,0).
init(x2,0).
init(x3,0).
init(x4,0).
init(x5,0).

goal(x4,1).
goal(x5,1).

action(a1).
prec(a1,x1,0).
post(a1,x1,1).
post(a1,x2,1).

action(a2).
prec(a2,x3,0).
post(a2,x1,1).
post(a2,x3,1).

action(a3).
prec(a3,x2,1).
prec(a3,x3,1).
post(a3,x4,1).

action(a4).
prec(a4,x2,1).
prec(a4,x3,1).
post(a4,x5,1).