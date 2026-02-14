fluent(door; loc; light; key). 
value(door, closed). value(door, open).       
value(loc, in).      value(loc, out).
value(light, 0).     value(light, 1).
value(key, 0).       value(key, 1).

init(door, closed). init(loc, in).  init(light, 1). init(key, 0).
goal(door, closed). goal(loc, out). goal(light, 0).

action(open; close; leave; turnOff; getKey).
prec(open, door, closed). prec(open, key, 1).      post(open, door, open).
prec(close, door, open).                           post(close, door, closed).
prec(leave, loc, in).     prec(leave, door, open). post(leave, loc, out).
prec(turnOff, loc, in).   prec(turnOff, light, 1). post(turnOff, light, 0).
prec(getKey, loc, in).    prec(getKey, key, 0).    post(getKey, key, 1).