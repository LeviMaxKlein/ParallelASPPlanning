fluent(door).        fluent(location).         fluent(light).   fluent(key).
value(door, closed). value(location, inside).  value(light, 0). value(key, 0).
value(door, open).   value(location, outside). value(light, 1). value(key,1).

init(door, closed). init(location, inside).  init(light, 1). init(key, 0).
goal(door, closed). goal(location, outside). goal(light, 0).

action(openDoor).             action(closeDoor).             action(goOut).
prec(openDoor, door, closed). prec(closeDoor, door, open).   prec(goOut, location, inside).
prec(openDoor, key, 1).       post(closeDoor, door, closed). prec(goOut, door, open).
post(openDoor, door, open).                                  post(goOut, location, outside).

action(lightsOut).                 action(getKey).
prec(lightsOut, location, inside). prec(getKey, location, inside).
prec(lightsOut, light, 1).         prec(getKey, key, 0).
post(lightsOut, light, 0).         post(getKey, key, 1).