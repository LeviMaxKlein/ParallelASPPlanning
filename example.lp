variable(x1). variable(x2). variable(x3). variable(x4). variable(x5).
contains(x1,0). contains(x1,1).
contains(x2,0). contains(x2,1).
contains(x3,0). contains(x3,1).
contains(x4,0). contains(x4,1).
contains(x5,0). contains(x5,1).

initialState(x1,0).
initialState(x2,0).
initialState(x3,0).
initialState(x4,0).
initialState(x5,0).

goal(x4,1).
goal(x5,1).

action(a1).
precondition(a1,x1,0).
postcondition(a1,x1,1).
postcondition(a1,x2,1).

action(a2).
precondition(a2,x3,0).
postcondition(a2,x1,1).
postcondition(a2,x3,1).

action(a3).
precondition(a3,x2,1).
precondition(a3,x3,1).
postcondition(a3,x4,1).

action(a4).
precondition(a4,x2,1).
precondition(a4,x3,1).
postcondition(a4,x5,1).