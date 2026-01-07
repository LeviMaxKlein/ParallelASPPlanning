fluent(door; loc; light; key). 
value(door, 0).  value(door, 1).       
value(loc, in).  value(loc, out).
value(light, 0). value(light, 1).
value(key, 0).   value(key, 1).

init(door, 0). init(loc, in).  init(light, 1). init(key, 0).
goal(door, 0). goal(loc, out). goal(light, 0).

action(openDoor; closeDoor; goOut; lightOut; getKey).
prec(openDoor, door, 0).  prec(openDoor, key, 1).   post(openDoor, door, 1).
prec(closeDoor, door, 1).                           post(closeDoor, door, 0).
prec(goOut, loc, in).     prec(goOut, door, 1).  post(goOut, loc, out).
prec(lightOut, loc, in).  prec(lightOut, light, 1). post(lightOut, light, 0).
prec(getKey, loc, in).    prec(getKey, key, 0).     post(getKey, key, 1).