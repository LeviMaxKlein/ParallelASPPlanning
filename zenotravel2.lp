% variables
variable(variable(0)).
contains(variable(0), value("fuel-level(plane1, fl0)", true)).
contains(variable(0), value("fuel-level(plane1, fl1)", true)).
contains(variable(0), value("fuel-level(plane1, fl2)", true)).
contains(variable(0), value("fuel-level(plane1, fl3)", true)).
contains(variable(0), value("fuel-level(plane1, fl4)", true)).
contains(variable(0), value("fuel-level(plane1, fl5)", true)).
contains(variable(0), value("fuel-level(plane1, fl6)", true)).

variable(variable(1)).
contains(variable(1), value("at(plane1, city0)", true)).
contains(variable(1), value("at(plane1, city1)", true)).
contains(variable(1), value("at(plane1, city2)", true)).

variable(variable(2)).
contains(variable(2), value("at(person3, city0)", true)).
contains(variable(2), value("at(person3, city1)", true)).
contains(variable(2), value("at(person3, city2)", true)).
contains(variable(2), value("in(person3, plane1)", true)).

variable(variable(3)).
contains(variable(3), value("at(person1, city0)", true)).
contains(variable(3), value("at(person1, city1)", true)).
contains(variable(3), value("at(person1, city2)", true)).
contains(variable(3), value("in(person1, plane1)", true)).

% actions
action(action(("board", "person1", "plane1", "city0"))).
precondition(action(("board", "person1", "plane1", "city0")), variable(1), value("at(plane1, city0)", true)).
precondition(action(("board", "person1", "plane1", "city0")), variable(3), value("at(person1, city0)", true)).
postcondition(action(("board", "person1", "plane1", "city0")), effect(unconditional), variable(3), value("in(person1, plane1)", true)).
costs(action(("board", "person1", "plane1", "city0")), 1).

action(action(("board", "person1", "plane1", "city1"))).
precondition(action(("board", "person1", "plane1", "city1")), variable(1), value("at(plane1, city1)", true)).
precondition(action(("board", "person1", "plane1", "city1")), variable(3), value("at(person1, city1)", true)).
postcondition(action(("board", "person1", "plane1", "city1")), effect(unconditional), variable(3), value("in(person1, plane1)", true)).
costs(action(("board", "person1", "plane1", "city1")), 1).

action(action(("board", "person1", "plane1", "city2"))).
precondition(action(("board", "person1", "plane1", "city2")), variable(1), value("at(plane1, city2)", true)).
precondition(action(("board", "person1", "plane1", "city2")), variable(3), value("at(person1, city2)", true)).
postcondition(action(("board", "person1", "plane1", "city2")), effect(unconditional), variable(3), value("in(person1, plane1)", true)).
costs(action(("board", "person1", "plane1", "city2")), 1).

action(action(("board", "person3", "plane1", "city0"))).
precondition(action(("board", "person3", "plane1", "city0")), variable(1), value("at(plane1, city0)", true)).
precondition(action(("board", "person3", "plane1", "city0")), variable(2), value("at(person3, city0)", true)).
postcondition(action(("board", "person3", "plane1", "city0")), effect(unconditional), variable(2), value("in(person3, plane1)", true)).
costs(action(("board", "person3", "plane1", "city0")), 1).

action(action(("board", "person3", "plane1", "city1"))).
precondition(action(("board", "person3", "plane1", "city1")), variable(1), value("at(plane1, city1)", true)).
precondition(action(("board", "person3", "plane1", "city1")), variable(2), value("at(person3, city1)", true)).
postcondition(action(("board", "person3", "plane1", "city1")), effect(unconditional), variable(2), value("in(person3, plane1)", true)).
costs(action(("board", "person3", "plane1", "city1")), 1).

action(action(("board", "person3", "plane1", "city2"))).
precondition(action(("board", "person3", "plane1", "city2")), variable(1), value("at(plane1, city2)", true)).
precondition(action(("board", "person3", "plane1", "city2")), variable(2), value("at(person3, city2)", true)).
postcondition(action(("board", "person3", "plane1", "city2")), effect(unconditional), variable(2), value("in(person3, plane1)", true)).
costs(action(("board", "person3", "plane1", "city2")), 1).

action(action(("debark", "person1", "plane1", "city0"))).
precondition(action(("debark", "person1", "plane1", "city0")), variable(1), value("at(plane1, city0)", true)).
precondition(action(("debark", "person1", "plane1", "city0")), variable(3), value("in(person1, plane1)", true)).
postcondition(action(("debark", "person1", "plane1", "city0")), effect(unconditional), variable(3), value("at(person1, city0)", true)).
costs(action(("debark", "person1", "plane1", "city0")), 1).

action(action(("debark", "person1", "plane1", "city1"))).
precondition(action(("debark", "person1", "plane1", "city1")), variable(1), value("at(plane1, city1)", true)).
precondition(action(("debark", "person1", "plane1", "city1")), variable(3), value("in(person1, plane1)", true)).
postcondition(action(("debark", "person1", "plane1", "city1")), effect(unconditional), variable(3), value("at(person1, city1)", true)).
costs(action(("debark", "person1", "plane1", "city1")), 1).

action(action(("debark", "person1", "plane1", "city2"))).
precondition(action(("debark", "person1", "plane1", "city2")), variable(1), value("at(plane1, city2)", true)).
precondition(action(("debark", "person1", "plane1", "city2")), variable(3), value("in(person1, plane1)", true)).
postcondition(action(("debark", "person1", "plane1", "city2")), effect(unconditional), variable(3), value("at(person1, city2)", true)).
costs(action(("debark", "person1", "plane1", "city2")), 1).

action(action(("debark", "person3", "plane1", "city0"))).
precondition(action(("debark", "person3", "plane1", "city0")), variable(1), value("at(plane1, city0)", true)).
precondition(action(("debark", "person3", "plane1", "city0")), variable(2), value("in(person3, plane1)", true)).
postcondition(action(("debark", "person3", "plane1", "city0")), effect(unconditional), variable(2), value("at(person3, city0)", true)).
costs(action(("debark", "person3", "plane1", "city0")), 1).

action(action(("debark", "person3", "plane1", "city1"))).
precondition(action(("debark", "person3", "plane1", "city1")), variable(1), value("at(plane1, city1)", true)).
precondition(action(("debark", "person3", "plane1", "city1")), variable(2), value("in(person3, plane1)", true)).
postcondition(action(("debark", "person3", "plane1", "city1")), effect(unconditional), variable(2), value("at(person3, city1)", true)).
costs(action(("debark", "person3", "plane1", "city1")), 1).

action(action(("debark", "person3", "plane1", "city2"))).
precondition(action(("debark", "person3", "plane1", "city2")), variable(1), value("at(plane1, city2)", true)).
precondition(action(("debark", "person3", "plane1", "city2")), variable(2), value("in(person3, plane1)", true)).
postcondition(action(("debark", "person3", "plane1", "city2")), effect(unconditional), variable(2), value("at(person3, city2)", true)).
costs(action(("debark", "person3", "plane1", "city2")), 1).

action(action(("fly", "plane1", "city0", "city0", "fl1", "fl0"))).
precondition(action(("fly", "plane1", "city0", "city0", "fl1", "fl0")), variable(1), value("at(plane1, city0)", true)).
precondition(action(("fly", "plane1", "city0", "city0", "fl1", "fl0")), variable(0), value("fuel-level(plane1, fl1)", true)).
postcondition(action(("fly", "plane1", "city0", "city0", "fl1", "fl0")), effect(unconditional), variable(0), value("fuel-level(plane1, fl0)", true)).
costs(action(("fly", "plane1", "city0", "city0", "fl1", "fl0")), 1).

action(action(("fly", "plane1", "city0", "city0", "fl2", "fl1"))).
precondition(action(("fly", "plane1", "city0", "city0", "fl2", "fl1")), variable(1), value("at(plane1, city0)", true)).
precondition(action(("fly", "plane1", "city0", "city0", "fl2", "fl1")), variable(0), value("fuel-level(plane1, fl2)", true)).
postcondition(action(("fly", "plane1", "city0", "city0", "fl2", "fl1")), effect(unconditional), variable(0), value("fuel-level(plane1, fl1)", true)).
costs(action(("fly", "plane1", "city0", "city0", "fl2", "fl1")), 1).

action(action(("fly", "plane1", "city0", "city0", "fl3", "fl2"))).
precondition(action(("fly", "plane1", "city0", "city0", "fl3", "fl2")), variable(1), value("at(plane1, city0)", true)).
precondition(action(("fly", "plane1", "city0", "city0", "fl3", "fl2")), variable(0), value("fuel-level(plane1, fl3)", true)).
postcondition(action(("fly", "plane1", "city0", "city0", "fl3", "fl2")), effect(unconditional), variable(0), value("fuel-level(plane1, fl2)", true)).
costs(action(("fly", "plane1", "city0", "city0", "fl3", "fl2")), 1).

action(action(("fly", "plane1", "city0", "city0", "fl4", "fl3"))).
precondition(action(("fly", "plane1", "city0", "city0", "fl4", "fl3")), variable(1), value("at(plane1, city0)", true)).
precondition(action(("fly", "plane1", "city0", "city0", "fl4", "fl3")), variable(0), value("fuel-level(plane1, fl4)", true)).
postcondition(action(("fly", "plane1", "city0", "city0", "fl4", "fl3")), effect(unconditional), variable(0), value("fuel-level(plane1, fl3)", true)).
costs(action(("fly", "plane1", "city0", "city0", "fl4", "fl3")), 1).

action(action(("fly", "plane1", "city0", "city0", "fl5", "fl4"))).
precondition(action(("fly", "plane1", "city0", "city0", "fl5", "fl4")), variable(1), value("at(plane1, city0)", true)).
precondition(action(("fly", "plane1", "city0", "city0", "fl5", "fl4")), variable(0), value("fuel-level(plane1, fl5)", true)).
postcondition(action(("fly", "plane1", "city0", "city0", "fl5", "fl4")), effect(unconditional), variable(0), value("fuel-level(plane1, fl4)", true)).
costs(action(("fly", "plane1", "city0", "city0", "fl5", "fl4")), 1).

action(action(("fly", "plane1", "city0", "city0", "fl6", "fl5"))).
precondition(action(("fly", "plane1", "city0", "city0", "fl6", "fl5")), variable(1), value("at(plane1, city0)", true)).
precondition(action(("fly", "plane1", "city0", "city0", "fl6", "fl5")), variable(0), value("fuel-level(plane1, fl6)", true)).
postcondition(action(("fly", "plane1", "city0", "city0", "fl6", "fl5")), effect(unconditional), variable(0), value("fuel-level(plane1, fl5)", true)).
costs(action(("fly", "plane1", "city0", "city0", "fl6", "fl5")), 1).

action(action(("fly", "plane1", "city0", "city1", "fl1", "fl0"))).
precondition(action(("fly", "plane1", "city0", "city1", "fl1", "fl0")), variable(1), value("at(plane1, city0)", true)).
precondition(action(("fly", "plane1", "city0", "city1", "fl1", "fl0")), variable(0), value("fuel-level(plane1, fl1)", true)).
postcondition(action(("fly", "plane1", "city0", "city1", "fl1", "fl0")), effect(unconditional), variable(1), value("at(plane1, city1)", true)).
postcondition(action(("fly", "plane1", "city0", "city1", "fl1", "fl0")), effect(unconditional), variable(0), value("fuel-level(plane1, fl0)", true)).
costs(action(("fly", "plane1", "city0", "city1", "fl1", "fl0")), 1).

action(action(("fly", "plane1", "city0", "city1", "fl2", "fl1"))).
precondition(action(("fly", "plane1", "city0", "city1", "fl2", "fl1")), variable(1), value("at(plane1, city0)", true)).
precondition(action(("fly", "plane1", "city0", "city1", "fl2", "fl1")), variable(0), value("fuel-level(plane1, fl2)", true)).
postcondition(action(("fly", "plane1", "city0", "city1", "fl2", "fl1")), effect(unconditional), variable(1), value("at(plane1, city1)", true)).
postcondition(action(("fly", "plane1", "city0", "city1", "fl2", "fl1")), effect(unconditional), variable(0), value("fuel-level(plane1, fl1)", true)).
costs(action(("fly", "plane1", "city0", "city1", "fl2", "fl1")), 1).

action(action(("fly", "plane1", "city0", "city1", "fl3", "fl2"))).
precondition(action(("fly", "plane1", "city0", "city1", "fl3", "fl2")), variable(1), value("at(plane1, city0)", true)).
precondition(action(("fly", "plane1", "city0", "city1", "fl3", "fl2")), variable(0), value("fuel-level(plane1, fl3)", true)).
postcondition(action(("fly", "plane1", "city0", "city1", "fl3", "fl2")), effect(unconditional), variable(1), value("at(plane1, city1)", true)).
postcondition(action(("fly", "plane1", "city0", "city1", "fl3", "fl2")), effect(unconditional), variable(0), value("fuel-level(plane1, fl2)", true)).
costs(action(("fly", "plane1", "city0", "city1", "fl3", "fl2")), 1).

action(action(("fly", "plane1", "city0", "city1", "fl4", "fl3"))).
precondition(action(("fly", "plane1", "city0", "city1", "fl4", "fl3")), variable(1), value("at(plane1, city0)", true)).
precondition(action(("fly", "plane1", "city0", "city1", "fl4", "fl3")), variable(0), value("fuel-level(plane1, fl4)", true)).
postcondition(action(("fly", "plane1", "city0", "city1", "fl4", "fl3")), effect(unconditional), variable(1), value("at(plane1, city1)", true)).
postcondition(action(("fly", "plane1", "city0", "city1", "fl4", "fl3")), effect(unconditional), variable(0), value("fuel-level(plane1, fl3)", true)).
costs(action(("fly", "plane1", "city0", "city1", "fl4", "fl3")), 1).

action(action(("fly", "plane1", "city0", "city1", "fl5", "fl4"))).
precondition(action(("fly", "plane1", "city0", "city1", "fl5", "fl4")), variable(1), value("at(plane1, city0)", true)).
precondition(action(("fly", "plane1", "city0", "city1", "fl5", "fl4")), variable(0), value("fuel-level(plane1, fl5)", true)).
postcondition(action(("fly", "plane1", "city0", "city1", "fl5", "fl4")), effect(unconditional), variable(1), value("at(plane1, city1)", true)).
postcondition(action(("fly", "plane1", "city0", "city1", "fl5", "fl4")), effect(unconditional), variable(0), value("fuel-level(plane1, fl4)", true)).
costs(action(("fly", "plane1", "city0", "city1", "fl5", "fl4")), 1).

action(action(("fly", "plane1", "city0", "city1", "fl6", "fl5"))).
precondition(action(("fly", "plane1", "city0", "city1", "fl6", "fl5")), variable(1), value("at(plane1, city0)", true)).
precondition(action(("fly", "plane1", "city0", "city1", "fl6", "fl5")), variable(0), value("fuel-level(plane1, fl6)", true)).
postcondition(action(("fly", "plane1", "city0", "city1", "fl6", "fl5")), effect(unconditional), variable(1), value("at(plane1, city1)", true)).
postcondition(action(("fly", "plane1", "city0", "city1", "fl6", "fl5")), effect(unconditional), variable(0), value("fuel-level(plane1, fl5)", true)).
costs(action(("fly", "plane1", "city0", "city1", "fl6", "fl5")), 1).

action(action(("fly", "plane1", "city0", "city2", "fl1", "fl0"))).
precondition(action(("fly", "plane1", "city0", "city2", "fl1", "fl0")), variable(1), value("at(plane1, city0)", true)).
precondition(action(("fly", "plane1", "city0", "city2", "fl1", "fl0")), variable(0), value("fuel-level(plane1, fl1)", true)).
postcondition(action(("fly", "plane1", "city0", "city2", "fl1", "fl0")), effect(unconditional), variable(1), value("at(plane1, city2)", true)).
postcondition(action(("fly", "plane1", "city0", "city2", "fl1", "fl0")), effect(unconditional), variable(0), value("fuel-level(plane1, fl0)", true)).
costs(action(("fly", "plane1", "city0", "city2", "fl1", "fl0")), 1).

action(action(("fly", "plane1", "city0", "city2", "fl2", "fl1"))).
precondition(action(("fly", "plane1", "city0", "city2", "fl2", "fl1")), variable(1), value("at(plane1, city0)", true)).
precondition(action(("fly", "plane1", "city0", "city2", "fl2", "fl1")), variable(0), value("fuel-level(plane1, fl2)", true)).
postcondition(action(("fly", "plane1", "city0", "city2", "fl2", "fl1")), effect(unconditional), variable(1), value("at(plane1, city2)", true)).
postcondition(action(("fly", "plane1", "city0", "city2", "fl2", "fl1")), effect(unconditional), variable(0), value("fuel-level(plane1, fl1)", true)).
costs(action(("fly", "plane1", "city0", "city2", "fl2", "fl1")), 1).

action(action(("fly", "plane1", "city0", "city2", "fl3", "fl2"))).
precondition(action(("fly", "plane1", "city0", "city2", "fl3", "fl2")), variable(1), value("at(plane1, city0)", true)).
precondition(action(("fly", "plane1", "city0", "city2", "fl3", "fl2")), variable(0), value("fuel-level(plane1, fl3)", true)).
postcondition(action(("fly", "plane1", "city0", "city2", "fl3", "fl2")), effect(unconditional), variable(1), value("at(plane1, city2)", true)).
postcondition(action(("fly", "plane1", "city0", "city2", "fl3", "fl2")), effect(unconditional), variable(0), value("fuel-level(plane1, fl2)", true)).
costs(action(("fly", "plane1", "city0", "city2", "fl3", "fl2")), 1).

action(action(("fly", "plane1", "city0", "city2", "fl4", "fl3"))).
precondition(action(("fly", "plane1", "city0", "city2", "fl4", "fl3")), variable(1), value("at(plane1, city0)", true)).
precondition(action(("fly", "plane1", "city0", "city2", "fl4", "fl3")), variable(0), value("fuel-level(plane1, fl4)", true)).
postcondition(action(("fly", "plane1", "city0", "city2", "fl4", "fl3")), effect(unconditional), variable(1), value("at(plane1, city2)", true)).
postcondition(action(("fly", "plane1", "city0", "city2", "fl4", "fl3")), effect(unconditional), variable(0), value("fuel-level(plane1, fl3)", true)).
costs(action(("fly", "plane1", "city0", "city2", "fl4", "fl3")), 1).

action(action(("fly", "plane1", "city0", "city2", "fl5", "fl4"))).
precondition(action(("fly", "plane1", "city0", "city2", "fl5", "fl4")), variable(1), value("at(plane1, city0)", true)).
precondition(action(("fly", "plane1", "city0", "city2", "fl5", "fl4")), variable(0), value("fuel-level(plane1, fl5)", true)).
postcondition(action(("fly", "plane1", "city0", "city2", "fl5", "fl4")), effect(unconditional), variable(1), value("at(plane1, city2)", true)).
postcondition(action(("fly", "plane1", "city0", "city2", "fl5", "fl4")), effect(unconditional), variable(0), value("fuel-level(plane1, fl4)", true)).
costs(action(("fly", "plane1", "city0", "city2", "fl5", "fl4")), 1).

action(action(("fly", "plane1", "city0", "city2", "fl6", "fl5"))).
precondition(action(("fly", "plane1", "city0", "city2", "fl6", "fl5")), variable(1), value("at(plane1, city0)", true)).
precondition(action(("fly", "plane1", "city0", "city2", "fl6", "fl5")), variable(0), value("fuel-level(plane1, fl6)", true)).
postcondition(action(("fly", "plane1", "city0", "city2", "fl6", "fl5")), effect(unconditional), variable(1), value("at(plane1, city2)", true)).
postcondition(action(("fly", "plane1", "city0", "city2", "fl6", "fl5")), effect(unconditional), variable(0), value("fuel-level(plane1, fl5)", true)).
costs(action(("fly", "plane1", "city0", "city2", "fl6", "fl5")), 1).

action(action(("fly", "plane1", "city1", "city0", "fl1", "fl0"))).
precondition(action(("fly", "plane1", "city1", "city0", "fl1", "fl0")), variable(1), value("at(plane1, city1)", true)).
precondition(action(("fly", "plane1", "city1", "city0", "fl1", "fl0")), variable(0), value("fuel-level(plane1, fl1)", true)).
postcondition(action(("fly", "plane1", "city1", "city0", "fl1", "fl0")), effect(unconditional), variable(1), value("at(plane1, city0)", true)).
postcondition(action(("fly", "plane1", "city1", "city0", "fl1", "fl0")), effect(unconditional), variable(0), value("fuel-level(plane1, fl0)", true)).
costs(action(("fly", "plane1", "city1", "city0", "fl1", "fl0")), 1).

action(action(("fly", "plane1", "city1", "city0", "fl2", "fl1"))).
precondition(action(("fly", "plane1", "city1", "city0", "fl2", "fl1")), variable(1), value("at(plane1, city1)", true)).
precondition(action(("fly", "plane1", "city1", "city0", "fl2", "fl1")), variable(0), value("fuel-level(plane1, fl2)", true)).
postcondition(action(("fly", "plane1", "city1", "city0", "fl2", "fl1")), effect(unconditional), variable(1), value("at(plane1, city0)", true)).
postcondition(action(("fly", "plane1", "city1", "city0", "fl2", "fl1")), effect(unconditional), variable(0), value("fuel-level(plane1, fl1)", true)).
costs(action(("fly", "plane1", "city1", "city0", "fl2", "fl1")), 1).

action(action(("fly", "plane1", "city1", "city0", "fl3", "fl2"))).
precondition(action(("fly", "plane1", "city1", "city0", "fl3", "fl2")), variable(1), value("at(plane1, city1)", true)).
precondition(action(("fly", "plane1", "city1", "city0", "fl3", "fl2")), variable(0), value("fuel-level(plane1, fl3)", true)).
postcondition(action(("fly", "plane1", "city1", "city0", "fl3", "fl2")), effect(unconditional), variable(1), value("at(plane1, city0)", true)).
postcondition(action(("fly", "plane1", "city1", "city0", "fl3", "fl2")), effect(unconditional), variable(0), value("fuel-level(plane1, fl2)", true)).
costs(action(("fly", "plane1", "city1", "city0", "fl3", "fl2")), 1).

action(action(("fly", "plane1", "city1", "city0", "fl4", "fl3"))).
precondition(action(("fly", "plane1", "city1", "city0", "fl4", "fl3")), variable(1), value("at(plane1, city1)", true)).
precondition(action(("fly", "plane1", "city1", "city0", "fl4", "fl3")), variable(0), value("fuel-level(plane1, fl4)", true)).
postcondition(action(("fly", "plane1", "city1", "city0", "fl4", "fl3")), effect(unconditional), variable(1), value("at(plane1, city0)", true)).
postcondition(action(("fly", "plane1", "city1", "city0", "fl4", "fl3")), effect(unconditional), variable(0), value("fuel-level(plane1, fl3)", true)).
costs(action(("fly", "plane1", "city1", "city0", "fl4", "fl3")), 1).

action(action(("fly", "plane1", "city1", "city0", "fl5", "fl4"))).
precondition(action(("fly", "plane1", "city1", "city0", "fl5", "fl4")), variable(1), value("at(plane1, city1)", true)).
precondition(action(("fly", "plane1", "city1", "city0", "fl5", "fl4")), variable(0), value("fuel-level(plane1, fl5)", true)).
postcondition(action(("fly", "plane1", "city1", "city0", "fl5", "fl4")), effect(unconditional), variable(1), value("at(plane1, city0)", true)).
postcondition(action(("fly", "plane1", "city1", "city0", "fl5", "fl4")), effect(unconditional), variable(0), value("fuel-level(plane1, fl4)", true)).
costs(action(("fly", "plane1", "city1", "city0", "fl5", "fl4")), 1).

action(action(("fly", "plane1", "city1", "city0", "fl6", "fl5"))).
precondition(action(("fly", "plane1", "city1", "city0", "fl6", "fl5")), variable(1), value("at(plane1, city1)", true)).
precondition(action(("fly", "plane1", "city1", "city0", "fl6", "fl5")), variable(0), value("fuel-level(plane1, fl6)", true)).
postcondition(action(("fly", "plane1", "city1", "city0", "fl6", "fl5")), effect(unconditional), variable(1), value("at(plane1, city0)", true)).
postcondition(action(("fly", "plane1", "city1", "city0", "fl6", "fl5")), effect(unconditional), variable(0), value("fuel-level(plane1, fl5)", true)).
costs(action(("fly", "plane1", "city1", "city0", "fl6", "fl5")), 1).

action(action(("fly", "plane1", "city1", "city1", "fl1", "fl0"))).
precondition(action(("fly", "plane1", "city1", "city1", "fl1", "fl0")), variable(1), value("at(plane1, city1)", true)).
precondition(action(("fly", "plane1", "city1", "city1", "fl1", "fl0")), variable(0), value("fuel-level(plane1, fl1)", true)).
postcondition(action(("fly", "plane1", "city1", "city1", "fl1", "fl0")), effect(unconditional), variable(0), value("fuel-level(plane1, fl0)", true)).
costs(action(("fly", "plane1", "city1", "city1", "fl1", "fl0")), 1).

action(action(("fly", "plane1", "city1", "city1", "fl2", "fl1"))).
precondition(action(("fly", "plane1", "city1", "city1", "fl2", "fl1")), variable(1), value("at(plane1, city1)", true)).
precondition(action(("fly", "plane1", "city1", "city1", "fl2", "fl1")), variable(0), value("fuel-level(plane1, fl2)", true)).
postcondition(action(("fly", "plane1", "city1", "city1", "fl2", "fl1")), effect(unconditional), variable(0), value("fuel-level(plane1, fl1)", true)).
costs(action(("fly", "plane1", "city1", "city1", "fl2", "fl1")), 1).

action(action(("fly", "plane1", "city1", "city1", "fl3", "fl2"))).
precondition(action(("fly", "plane1", "city1", "city1", "fl3", "fl2")), variable(1), value("at(plane1, city1)", true)).
precondition(action(("fly", "plane1", "city1", "city1", "fl3", "fl2")), variable(0), value("fuel-level(plane1, fl3)", true)).
postcondition(action(("fly", "plane1", "city1", "city1", "fl3", "fl2")), effect(unconditional), variable(0), value("fuel-level(plane1, fl2)", true)).
costs(action(("fly", "plane1", "city1", "city1", "fl3", "fl2")), 1).

action(action(("fly", "plane1", "city1", "city1", "fl4", "fl3"))).
precondition(action(("fly", "plane1", "city1", "city1", "fl4", "fl3")), variable(1), value("at(plane1, city1)", true)).
precondition(action(("fly", "plane1", "city1", "city1", "fl4", "fl3")), variable(0), value("fuel-level(plane1, fl4)", true)).
postcondition(action(("fly", "plane1", "city1", "city1", "fl4", "fl3")), effect(unconditional), variable(0), value("fuel-level(plane1, fl3)", true)).
costs(action(("fly", "plane1", "city1", "city1", "fl4", "fl3")), 1).

action(action(("fly", "plane1", "city1", "city1", "fl5", "fl4"))).
precondition(action(("fly", "plane1", "city1", "city1", "fl5", "fl4")), variable(1), value("at(plane1, city1)", true)).
precondition(action(("fly", "plane1", "city1", "city1", "fl5", "fl4")), variable(0), value("fuel-level(plane1, fl5)", true)).
postcondition(action(("fly", "plane1", "city1", "city1", "fl5", "fl4")), effect(unconditional), variable(0), value("fuel-level(plane1, fl4)", true)).
costs(action(("fly", "plane1", "city1", "city1", "fl5", "fl4")), 1).

action(action(("fly", "plane1", "city1", "city1", "fl6", "fl5"))).
precondition(action(("fly", "plane1", "city1", "city1", "fl6", "fl5")), variable(1), value("at(plane1, city1)", true)).
precondition(action(("fly", "plane1", "city1", "city1", "fl6", "fl5")), variable(0), value("fuel-level(plane1, fl6)", true)).
postcondition(action(("fly", "plane1", "city1", "city1", "fl6", "fl5")), effect(unconditional), variable(0), value("fuel-level(plane1, fl5)", true)).
costs(action(("fly", "plane1", "city1", "city1", "fl6", "fl5")), 1).

action(action(("fly", "plane1", "city1", "city2", "fl1", "fl0"))).
precondition(action(("fly", "plane1", "city1", "city2", "fl1", "fl0")), variable(1), value("at(plane1, city1)", true)).
precondition(action(("fly", "plane1", "city1", "city2", "fl1", "fl0")), variable(0), value("fuel-level(plane1, fl1)", true)).
postcondition(action(("fly", "plane1", "city1", "city2", "fl1", "fl0")), effect(unconditional), variable(1), value("at(plane1, city2)", true)).
postcondition(action(("fly", "plane1", "city1", "city2", "fl1", "fl0")), effect(unconditional), variable(0), value("fuel-level(plane1, fl0)", true)).
costs(action(("fly", "plane1", "city1", "city2", "fl1", "fl0")), 1).

action(action(("fly", "plane1", "city1", "city2", "fl2", "fl1"))).
precondition(action(("fly", "plane1", "city1", "city2", "fl2", "fl1")), variable(1), value("at(plane1, city1)", true)).
precondition(action(("fly", "plane1", "city1", "city2", "fl2", "fl1")), variable(0), value("fuel-level(plane1, fl2)", true)).
postcondition(action(("fly", "plane1", "city1", "city2", "fl2", "fl1")), effect(unconditional), variable(1), value("at(plane1, city2)", true)).
postcondition(action(("fly", "plane1", "city1", "city2", "fl2", "fl1")), effect(unconditional), variable(0), value("fuel-level(plane1, fl1)", true)).
costs(action(("fly", "plane1", "city1", "city2", "fl2", "fl1")), 1).

action(action(("fly", "plane1", "city1", "city2", "fl3", "fl2"))).
precondition(action(("fly", "plane1", "city1", "city2", "fl3", "fl2")), variable(1), value("at(plane1, city1)", true)).
precondition(action(("fly", "plane1", "city1", "city2", "fl3", "fl2")), variable(0), value("fuel-level(plane1, fl3)", true)).
postcondition(action(("fly", "plane1", "city1", "city2", "fl3", "fl2")), effect(unconditional), variable(1), value("at(plane1, city2)", true)).
postcondition(action(("fly", "plane1", "city1", "city2", "fl3", "fl2")), effect(unconditional), variable(0), value("fuel-level(plane1, fl2)", true)).
costs(action(("fly", "plane1", "city1", "city2", "fl3", "fl2")), 1).

action(action(("fly", "plane1", "city1", "city2", "fl4", "fl3"))).
precondition(action(("fly", "plane1", "city1", "city2", "fl4", "fl3")), variable(1), value("at(plane1, city1)", true)).
precondition(action(("fly", "plane1", "city1", "city2", "fl4", "fl3")), variable(0), value("fuel-level(plane1, fl4)", true)).
postcondition(action(("fly", "plane1", "city1", "city2", "fl4", "fl3")), effect(unconditional), variable(1), value("at(plane1, city2)", true)).
postcondition(action(("fly", "plane1", "city1", "city2", "fl4", "fl3")), effect(unconditional), variable(0), value("fuel-level(plane1, fl3)", true)).
costs(action(("fly", "plane1", "city1", "city2", "fl4", "fl3")), 1).

action(action(("fly", "plane1", "city1", "city2", "fl5", "fl4"))).
precondition(action(("fly", "plane1", "city1", "city2", "fl5", "fl4")), variable(1), value("at(plane1, city1)", true)).
precondition(action(("fly", "plane1", "city1", "city2", "fl5", "fl4")), variable(0), value("fuel-level(plane1, fl5)", true)).
postcondition(action(("fly", "plane1", "city1", "city2", "fl5", "fl4")), effect(unconditional), variable(1), value("at(plane1, city2)", true)).
postcondition(action(("fly", "plane1", "city1", "city2", "fl5", "fl4")), effect(unconditional), variable(0), value("fuel-level(plane1, fl4)", true)).
costs(action(("fly", "plane1", "city1", "city2", "fl5", "fl4")), 1).

action(action(("fly", "plane1", "city1", "city2", "fl6", "fl5"))).
precondition(action(("fly", "plane1", "city1", "city2", "fl6", "fl5")), variable(1), value("at(plane1, city1)", true)).
precondition(action(("fly", "plane1", "city1", "city2", "fl6", "fl5")), variable(0), value("fuel-level(plane1, fl6)", true)).
postcondition(action(("fly", "plane1", "city1", "city2", "fl6", "fl5")), effect(unconditional), variable(1), value("at(plane1, city2)", true)).
postcondition(action(("fly", "plane1", "city1", "city2", "fl6", "fl5")), effect(unconditional), variable(0), value("fuel-level(plane1, fl5)", true)).
costs(action(("fly", "plane1", "city1", "city2", "fl6", "fl5")), 1).

action(action(("fly", "plane1", "city2", "city0", "fl1", "fl0"))).
precondition(action(("fly", "plane1", "city2", "city0", "fl1", "fl0")), variable(1), value("at(plane1, city2)", true)).
precondition(action(("fly", "plane1", "city2", "city0", "fl1", "fl0")), variable(0), value("fuel-level(plane1, fl1)", true)).
postcondition(action(("fly", "plane1", "city2", "city0", "fl1", "fl0")), effect(unconditional), variable(1), value("at(plane1, city0)", true)).
postcondition(action(("fly", "plane1", "city2", "city0", "fl1", "fl0")), effect(unconditional), variable(0), value("fuel-level(plane1, fl0)", true)).
costs(action(("fly", "plane1", "city2", "city0", "fl1", "fl0")), 1).

action(action(("fly", "plane1", "city2", "city0", "fl2", "fl1"))).
precondition(action(("fly", "plane1", "city2", "city0", "fl2", "fl1")), variable(1), value("at(plane1, city2)", true)).
precondition(action(("fly", "plane1", "city2", "city0", "fl2", "fl1")), variable(0), value("fuel-level(plane1, fl2)", true)).
postcondition(action(("fly", "plane1", "city2", "city0", "fl2", "fl1")), effect(unconditional), variable(1), value("at(plane1, city0)", true)).
postcondition(action(("fly", "plane1", "city2", "city0", "fl2", "fl1")), effect(unconditional), variable(0), value("fuel-level(plane1, fl1)", true)).
costs(action(("fly", "plane1", "city2", "city0", "fl2", "fl1")), 1).

action(action(("fly", "plane1", "city2", "city0", "fl3", "fl2"))).
precondition(action(("fly", "plane1", "city2", "city0", "fl3", "fl2")), variable(1), value("at(plane1, city2)", true)).
precondition(action(("fly", "plane1", "city2", "city0", "fl3", "fl2")), variable(0), value("fuel-level(plane1, fl3)", true)).
postcondition(action(("fly", "plane1", "city2", "city0", "fl3", "fl2")), effect(unconditional), variable(1), value("at(plane1, city0)", true)).
postcondition(action(("fly", "plane1", "city2", "city0", "fl3", "fl2")), effect(unconditional), variable(0), value("fuel-level(plane1, fl2)", true)).
costs(action(("fly", "plane1", "city2", "city0", "fl3", "fl2")), 1).

action(action(("fly", "plane1", "city2", "city0", "fl4", "fl3"))).
precondition(action(("fly", "plane1", "city2", "city0", "fl4", "fl3")), variable(1), value("at(plane1, city2)", true)).
precondition(action(("fly", "plane1", "city2", "city0", "fl4", "fl3")), variable(0), value("fuel-level(plane1, fl4)", true)).
postcondition(action(("fly", "plane1", "city2", "city0", "fl4", "fl3")), effect(unconditional), variable(1), value("at(plane1, city0)", true)).
postcondition(action(("fly", "plane1", "city2", "city0", "fl4", "fl3")), effect(unconditional), variable(0), value("fuel-level(plane1, fl3)", true)).
costs(action(("fly", "plane1", "city2", "city0", "fl4", "fl3")), 1).

action(action(("fly", "plane1", "city2", "city0", "fl5", "fl4"))).
precondition(action(("fly", "plane1", "city2", "city0", "fl5", "fl4")), variable(1), value("at(plane1, city2)", true)).
precondition(action(("fly", "plane1", "city2", "city0", "fl5", "fl4")), variable(0), value("fuel-level(plane1, fl5)", true)).
postcondition(action(("fly", "plane1", "city2", "city0", "fl5", "fl4")), effect(unconditional), variable(1), value("at(plane1, city0)", true)).
postcondition(action(("fly", "plane1", "city2", "city0", "fl5", "fl4")), effect(unconditional), variable(0), value("fuel-level(plane1, fl4)", true)).
costs(action(("fly", "plane1", "city2", "city0", "fl5", "fl4")), 1).

action(action(("fly", "plane1", "city2", "city0", "fl6", "fl5"))).
precondition(action(("fly", "plane1", "city2", "city0", "fl6", "fl5")), variable(1), value("at(plane1, city2)", true)).
precondition(action(("fly", "plane1", "city2", "city0", "fl6", "fl5")), variable(0), value("fuel-level(plane1, fl6)", true)).
postcondition(action(("fly", "plane1", "city2", "city0", "fl6", "fl5")), effect(unconditional), variable(1), value("at(plane1, city0)", true)).
postcondition(action(("fly", "plane1", "city2", "city0", "fl6", "fl5")), effect(unconditional), variable(0), value("fuel-level(plane1, fl5)", true)).
costs(action(("fly", "plane1", "city2", "city0", "fl6", "fl5")), 1).

action(action(("fly", "plane1", "city2", "city1", "fl1", "fl0"))).
precondition(action(("fly", "plane1", "city2", "city1", "fl1", "fl0")), variable(1), value("at(plane1, city2)", true)).
precondition(action(("fly", "plane1", "city2", "city1", "fl1", "fl0")), variable(0), value("fuel-level(plane1, fl1)", true)).
postcondition(action(("fly", "plane1", "city2", "city1", "fl1", "fl0")), effect(unconditional), variable(1), value("at(plane1, city1)", true)).
postcondition(action(("fly", "plane1", "city2", "city1", "fl1", "fl0")), effect(unconditional), variable(0), value("fuel-level(plane1, fl0)", true)).
costs(action(("fly", "plane1", "city2", "city1", "fl1", "fl0")), 1).

action(action(("fly", "plane1", "city2", "city1", "fl2", "fl1"))).
precondition(action(("fly", "plane1", "city2", "city1", "fl2", "fl1")), variable(1), value("at(plane1, city2)", true)).
precondition(action(("fly", "plane1", "city2", "city1", "fl2", "fl1")), variable(0), value("fuel-level(plane1, fl2)", true)).
postcondition(action(("fly", "plane1", "city2", "city1", "fl2", "fl1")), effect(unconditional), variable(1), value("at(plane1, city1)", true)).
postcondition(action(("fly", "plane1", "city2", "city1", "fl2", "fl1")), effect(unconditional), variable(0), value("fuel-level(plane1, fl1)", true)).
costs(action(("fly", "plane1", "city2", "city1", "fl2", "fl1")), 1).

action(action(("fly", "plane1", "city2", "city1", "fl3", "fl2"))).
precondition(action(("fly", "plane1", "city2", "city1", "fl3", "fl2")), variable(1), value("at(plane1, city2)", true)).
precondition(action(("fly", "plane1", "city2", "city1", "fl3", "fl2")), variable(0), value("fuel-level(plane1, fl3)", true)).
postcondition(action(("fly", "plane1", "city2", "city1", "fl3", "fl2")), effect(unconditional), variable(1), value("at(plane1, city1)", true)).
postcondition(action(("fly", "plane1", "city2", "city1", "fl3", "fl2")), effect(unconditional), variable(0), value("fuel-level(plane1, fl2)", true)).
costs(action(("fly", "plane1", "city2", "city1", "fl3", "fl2")), 1).

action(action(("fly", "plane1", "city2", "city1", "fl4", "fl3"))).
precondition(action(("fly", "plane1", "city2", "city1", "fl4", "fl3")), variable(1), value("at(plane1, city2)", true)).
precondition(action(("fly", "plane1", "city2", "city1", "fl4", "fl3")), variable(0), value("fuel-level(plane1, fl4)", true)).
postcondition(action(("fly", "plane1", "city2", "city1", "fl4", "fl3")), effect(unconditional), variable(1), value("at(plane1, city1)", true)).
postcondition(action(("fly", "plane1", "city2", "city1", "fl4", "fl3")), effect(unconditional), variable(0), value("fuel-level(plane1, fl3)", true)).
costs(action(("fly", "plane1", "city2", "city1", "fl4", "fl3")), 1).

action(action(("fly", "plane1", "city2", "city1", "fl5", "fl4"))).
precondition(action(("fly", "plane1", "city2", "city1", "fl5", "fl4")), variable(1), value("at(plane1, city2)", true)).
precondition(action(("fly", "plane1", "city2", "city1", "fl5", "fl4")), variable(0), value("fuel-level(plane1, fl5)", true)).
postcondition(action(("fly", "plane1", "city2", "city1", "fl5", "fl4")), effect(unconditional), variable(1), value("at(plane1, city1)", true)).
postcondition(action(("fly", "plane1", "city2", "city1", "fl5", "fl4")), effect(unconditional), variable(0), value("fuel-level(plane1, fl4)", true)).
costs(action(("fly", "plane1", "city2", "city1", "fl5", "fl4")), 1).

action(action(("fly", "plane1", "city2", "city1", "fl6", "fl5"))).
precondition(action(("fly", "plane1", "city2", "city1", "fl6", "fl5")), variable(1), value("at(plane1, city2)", true)).
precondition(action(("fly", "plane1", "city2", "city1", "fl6", "fl5")), variable(0), value("fuel-level(plane1, fl6)", true)).
postcondition(action(("fly", "plane1", "city2", "city1", "fl6", "fl5")), effect(unconditional), variable(1), value("at(plane1, city1)", true)).
postcondition(action(("fly", "plane1", "city2", "city1", "fl6", "fl5")), effect(unconditional), variable(0), value("fuel-level(plane1, fl5)", true)).
costs(action(("fly", "plane1", "city2", "city1", "fl6", "fl5")), 1).

action(action(("fly", "plane1", "city2", "city2", "fl1", "fl0"))).
precondition(action(("fly", "plane1", "city2", "city2", "fl1", "fl0")), variable(1), value("at(plane1, city2)", true)).
precondition(action(("fly", "plane1", "city2", "city2", "fl1", "fl0")), variable(0), value("fuel-level(plane1, fl1)", true)).
postcondition(action(("fly", "plane1", "city2", "city2", "fl1", "fl0")), effect(unconditional), variable(0), value("fuel-level(plane1, fl0)", true)).
costs(action(("fly", "plane1", "city2", "city2", "fl1", "fl0")), 1).

action(action(("fly", "plane1", "city2", "city2", "fl2", "fl1"))).
precondition(action(("fly", "plane1", "city2", "city2", "fl2", "fl1")), variable(1), value("at(plane1, city2)", true)).
precondition(action(("fly", "plane1", "city2", "city2", "fl2", "fl1")), variable(0), value("fuel-level(plane1, fl2)", true)).
postcondition(action(("fly", "plane1", "city2", "city2", "fl2", "fl1")), effect(unconditional), variable(0), value("fuel-level(plane1, fl1)", true)).
costs(action(("fly", "plane1", "city2", "city2", "fl2", "fl1")), 1).

action(action(("fly", "plane1", "city2", "city2", "fl3", "fl2"))).
precondition(action(("fly", "plane1", "city2", "city2", "fl3", "fl2")), variable(1), value("at(plane1, city2)", true)).
precondition(action(("fly", "plane1", "city2", "city2", "fl3", "fl2")), variable(0), value("fuel-level(plane1, fl3)", true)).
postcondition(action(("fly", "plane1", "city2", "city2", "fl3", "fl2")), effect(unconditional), variable(0), value("fuel-level(plane1, fl2)", true)).
costs(action(("fly", "plane1", "city2", "city2", "fl3", "fl2")), 1).

action(action(("fly", "plane1", "city2", "city2", "fl4", "fl3"))).
precondition(action(("fly", "plane1", "city2", "city2", "fl4", "fl3")), variable(1), value("at(plane1, city2)", true)).
precondition(action(("fly", "plane1", "city2", "city2", "fl4", "fl3")), variable(0), value("fuel-level(plane1, fl4)", true)).
postcondition(action(("fly", "plane1", "city2", "city2", "fl4", "fl3")), effect(unconditional), variable(0), value("fuel-level(plane1, fl3)", true)).
costs(action(("fly", "plane1", "city2", "city2", "fl4", "fl3")), 1).

action(action(("fly", "plane1", "city2", "city2", "fl5", "fl4"))).
precondition(action(("fly", "plane1", "city2", "city2", "fl5", "fl4")), variable(1), value("at(plane1, city2)", true)).
precondition(action(("fly", "plane1", "city2", "city2", "fl5", "fl4")), variable(0), value("fuel-level(plane1, fl5)", true)).
postcondition(action(("fly", "plane1", "city2", "city2", "fl5", "fl4")), effect(unconditional), variable(0), value("fuel-level(plane1, fl4)", true)).
costs(action(("fly", "plane1", "city2", "city2", "fl5", "fl4")), 1).

action(action(("fly", "plane1", "city2", "city2", "fl6", "fl5"))).
precondition(action(("fly", "plane1", "city2", "city2", "fl6", "fl5")), variable(1), value("at(plane1, city2)", true)).
precondition(action(("fly", "plane1", "city2", "city2", "fl6", "fl5")), variable(0), value("fuel-level(plane1, fl6)", true)).
postcondition(action(("fly", "plane1", "city2", "city2", "fl6", "fl5")), effect(unconditional), variable(0), value("fuel-level(plane1, fl5)", true)).
costs(action(("fly", "plane1", "city2", "city2", "fl6", "fl5")), 1).

action(action(("refuel", "plane1", "city0", "fl0", "fl1"))).
precondition(action(("refuel", "plane1", "city0", "fl0", "fl1")), variable(1), value("at(plane1, city0)", true)).
precondition(action(("refuel", "plane1", "city0", "fl0", "fl1")), variable(0), value("fuel-level(plane1, fl0)", true)).
postcondition(action(("refuel", "plane1", "city0", "fl0", "fl1")), effect(unconditional), variable(0), value("fuel-level(plane1, fl1)", true)).
costs(action(("refuel", "plane1", "city0", "fl0", "fl1")), 1).

action(action(("refuel", "plane1", "city0", "fl1", "fl2"))).
precondition(action(("refuel", "plane1", "city0", "fl1", "fl2")), variable(1), value("at(plane1, city0)", true)).
precondition(action(("refuel", "plane1", "city0", "fl1", "fl2")), variable(0), value("fuel-level(plane1, fl1)", true)).
postcondition(action(("refuel", "plane1", "city0", "fl1", "fl2")), effect(unconditional), variable(0), value("fuel-level(plane1, fl2)", true)).
costs(action(("refuel", "plane1", "city0", "fl1", "fl2")), 1).

action(action(("refuel", "plane1", "city0", "fl2", "fl3"))).
precondition(action(("refuel", "plane1", "city0", "fl2", "fl3")), variable(1), value("at(plane1, city0)", true)).
precondition(action(("refuel", "plane1", "city0", "fl2", "fl3")), variable(0), value("fuel-level(plane1, fl2)", true)).
postcondition(action(("refuel", "plane1", "city0", "fl2", "fl3")), effect(unconditional), variable(0), value("fuel-level(plane1, fl3)", true)).
costs(action(("refuel", "plane1", "city0", "fl2", "fl3")), 1).

action(action(("refuel", "plane1", "city0", "fl3", "fl4"))).
precondition(action(("refuel", "plane1", "city0", "fl3", "fl4")), variable(1), value("at(plane1, city0)", true)).
precondition(action(("refuel", "plane1", "city0", "fl3", "fl4")), variable(0), value("fuel-level(plane1, fl3)", true)).
postcondition(action(("refuel", "plane1", "city0", "fl3", "fl4")), effect(unconditional), variable(0), value("fuel-level(plane1, fl4)", true)).
costs(action(("refuel", "plane1", "city0", "fl3", "fl4")), 1).

action(action(("refuel", "plane1", "city0", "fl4", "fl5"))).
precondition(action(("refuel", "plane1", "city0", "fl4", "fl5")), variable(1), value("at(plane1, city0)", true)).
precondition(action(("refuel", "plane1", "city0", "fl4", "fl5")), variable(0), value("fuel-level(plane1, fl4)", true)).
postcondition(action(("refuel", "plane1", "city0", "fl4", "fl5")), effect(unconditional), variable(0), value("fuel-level(plane1, fl5)", true)).
costs(action(("refuel", "plane1", "city0", "fl4", "fl5")), 1).

action(action(("refuel", "plane1", "city0", "fl5", "fl6"))).
precondition(action(("refuel", "plane1", "city0", "fl5", "fl6")), variable(1), value("at(plane1, city0)", true)).
precondition(action(("refuel", "plane1", "city0", "fl5", "fl6")), variable(0), value("fuel-level(plane1, fl5)", true)).
postcondition(action(("refuel", "plane1", "city0", "fl5", "fl6")), effect(unconditional), variable(0), value("fuel-level(plane1, fl6)", true)).
costs(action(("refuel", "plane1", "city0", "fl5", "fl6")), 1).

action(action(("refuel", "plane1", "city1", "fl0", "fl1"))).
precondition(action(("refuel", "plane1", "city1", "fl0", "fl1")), variable(1), value("at(plane1, city1)", true)).
precondition(action(("refuel", "plane1", "city1", "fl0", "fl1")), variable(0), value("fuel-level(plane1, fl0)", true)).
postcondition(action(("refuel", "plane1", "city1", "fl0", "fl1")), effect(unconditional), variable(0), value("fuel-level(plane1, fl1)", true)).
costs(action(("refuel", "plane1", "city1", "fl0", "fl1")), 1).

action(action(("refuel", "plane1", "city1", "fl1", "fl2"))).
precondition(action(("refuel", "plane1", "city1", "fl1", "fl2")), variable(1), value("at(plane1, city1)", true)).
precondition(action(("refuel", "plane1", "city1", "fl1", "fl2")), variable(0), value("fuel-level(plane1, fl1)", true)).
postcondition(action(("refuel", "plane1", "city1", "fl1", "fl2")), effect(unconditional), variable(0), value("fuel-level(plane1, fl2)", true)).
costs(action(("refuel", "plane1", "city1", "fl1", "fl2")), 1).

action(action(("refuel", "plane1", "city1", "fl2", "fl3"))).
precondition(action(("refuel", "plane1", "city1", "fl2", "fl3")), variable(1), value("at(plane1, city1)", true)).
precondition(action(("refuel", "plane1", "city1", "fl2", "fl3")), variable(0), value("fuel-level(plane1, fl2)", true)).
postcondition(action(("refuel", "plane1", "city1", "fl2", "fl3")), effect(unconditional), variable(0), value("fuel-level(plane1, fl3)", true)).
costs(action(("refuel", "plane1", "city1", "fl2", "fl3")), 1).

action(action(("refuel", "plane1", "city1", "fl3", "fl4"))).
precondition(action(("refuel", "plane1", "city1", "fl3", "fl4")), variable(1), value("at(plane1, city1)", true)).
precondition(action(("refuel", "plane1", "city1", "fl3", "fl4")), variable(0), value("fuel-level(plane1, fl3)", true)).
postcondition(action(("refuel", "plane1", "city1", "fl3", "fl4")), effect(unconditional), variable(0), value("fuel-level(plane1, fl4)", true)).
costs(action(("refuel", "plane1", "city1", "fl3", "fl4")), 1).

action(action(("refuel", "plane1", "city1", "fl4", "fl5"))).
precondition(action(("refuel", "plane1", "city1", "fl4", "fl5")), variable(1), value("at(plane1, city1)", true)).
precondition(action(("refuel", "plane1", "city1", "fl4", "fl5")), variable(0), value("fuel-level(plane1, fl4)", true)).
postcondition(action(("refuel", "plane1", "city1", "fl4", "fl5")), effect(unconditional), variable(0), value("fuel-level(plane1, fl5)", true)).
costs(action(("refuel", "plane1", "city1", "fl4", "fl5")), 1).

action(action(("refuel", "plane1", "city1", "fl5", "fl6"))).
precondition(action(("refuel", "plane1", "city1", "fl5", "fl6")), variable(1), value("at(plane1, city1)", true)).
precondition(action(("refuel", "plane1", "city1", "fl5", "fl6")), variable(0), value("fuel-level(plane1, fl5)", true)).
postcondition(action(("refuel", "plane1", "city1", "fl5", "fl6")), effect(unconditional), variable(0), value("fuel-level(plane1, fl6)", true)).
costs(action(("refuel", "plane1", "city1", "fl5", "fl6")), 1).

action(action(("refuel", "plane1", "city2", "fl0", "fl1"))).
precondition(action(("refuel", "plane1", "city2", "fl0", "fl1")), variable(1), value("at(plane1, city2)", true)).
precondition(action(("refuel", "plane1", "city2", "fl0", "fl1")), variable(0), value("fuel-level(plane1, fl0)", true)).
postcondition(action(("refuel", "plane1", "city2", "fl0", "fl1")), effect(unconditional), variable(0), value("fuel-level(plane1, fl1)", true)).
costs(action(("refuel", "plane1", "city2", "fl0", "fl1")), 1).

action(action(("refuel", "plane1", "city2", "fl1", "fl2"))).
precondition(action(("refuel", "plane1", "city2", "fl1", "fl2")), variable(1), value("at(plane1, city2)", true)).
precondition(action(("refuel", "plane1", "city2", "fl1", "fl2")), variable(0), value("fuel-level(plane1, fl1)", true)).
postcondition(action(("refuel", "plane1", "city2", "fl1", "fl2")), effect(unconditional), variable(0), value("fuel-level(plane1, fl2)", true)).
costs(action(("refuel", "plane1", "city2", "fl1", "fl2")), 1).

action(action(("refuel", "plane1", "city2", "fl2", "fl3"))).
precondition(action(("refuel", "plane1", "city2", "fl2", "fl3")), variable(1), value("at(plane1, city2)", true)).
precondition(action(("refuel", "plane1", "city2", "fl2", "fl3")), variable(0), value("fuel-level(plane1, fl2)", true)).
postcondition(action(("refuel", "plane1", "city2", "fl2", "fl3")), effect(unconditional), variable(0), value("fuel-level(plane1, fl3)", true)).
costs(action(("refuel", "plane1", "city2", "fl2", "fl3")), 1).

action(action(("refuel", "plane1", "city2", "fl3", "fl4"))).
precondition(action(("refuel", "plane1", "city2", "fl3", "fl4")), variable(1), value("at(plane1, city2)", true)).
precondition(action(("refuel", "plane1", "city2", "fl3", "fl4")), variable(0), value("fuel-level(plane1, fl3)", true)).
postcondition(action(("refuel", "plane1", "city2", "fl3", "fl4")), effect(unconditional), variable(0), value("fuel-level(plane1, fl4)", true)).
costs(action(("refuel", "plane1", "city2", "fl3", "fl4")), 1).

action(action(("refuel", "plane1", "city2", "fl4", "fl5"))).
precondition(action(("refuel", "plane1", "city2", "fl4", "fl5")), variable(1), value("at(plane1, city2)", true)).
precondition(action(("refuel", "plane1", "city2", "fl4", "fl5")), variable(0), value("fuel-level(plane1, fl4)", true)).
postcondition(action(("refuel", "plane1", "city2", "fl4", "fl5")), effect(unconditional), variable(0), value("fuel-level(plane1, fl5)", true)).
costs(action(("refuel", "plane1", "city2", "fl4", "fl5")), 1).

action(action(("refuel", "plane1", "city2", "fl5", "fl6"))).
precondition(action(("refuel", "plane1", "city2", "fl5", "fl6")), variable(1), value("at(plane1, city2)", true)).
precondition(action(("refuel", "plane1", "city2", "fl5", "fl6")), variable(0), value("fuel-level(plane1, fl5)", true)).
postcondition(action(("refuel", "plane1", "city2", "fl5", "fl6")), effect(unconditional), variable(0), value("fuel-level(plane1, fl6)", true)).
costs(action(("refuel", "plane1", "city2", "fl5", "fl6")), 1).

action(action(("zoom", "plane1", "city0", "city0", "fl2", "fl1", "fl0"))).
precondition(action(("zoom", "plane1", "city0", "city0", "fl2", "fl1", "fl0")), variable(1), value("at(plane1, city0)", true)).
precondition(action(("zoom", "plane1", "city0", "city0", "fl2", "fl1", "fl0")), variable(0), value("fuel-level(plane1, fl2)", true)).
postcondition(action(("zoom", "plane1", "city0", "city0", "fl2", "fl1", "fl0")), effect(unconditional), variable(0), value("fuel-level(plane1, fl0)", true)).
costs(action(("zoom", "plane1", "city0", "city0", "fl2", "fl1", "fl0")), 1).

action(action(("zoom", "plane1", "city0", "city0", "fl3", "fl2", "fl1"))).
precondition(action(("zoom", "plane1", "city0", "city0", "fl3", "fl2", "fl1")), variable(1), value("at(plane1, city0)", true)).
precondition(action(("zoom", "plane1", "city0", "city0", "fl3", "fl2", "fl1")), variable(0), value("fuel-level(plane1, fl3)", true)).
postcondition(action(("zoom", "plane1", "city0", "city0", "fl3", "fl2", "fl1")), effect(unconditional), variable(0), value("fuel-level(plane1, fl1)", true)).
costs(action(("zoom", "plane1", "city0", "city0", "fl3", "fl2", "fl1")), 1).

action(action(("zoom", "plane1", "city0", "city0", "fl4", "fl3", "fl2"))).
precondition(action(("zoom", "plane1", "city0", "city0", "fl4", "fl3", "fl2")), variable(1), value("at(plane1, city0)", true)).
precondition(action(("zoom", "plane1", "city0", "city0", "fl4", "fl3", "fl2")), variable(0), value("fuel-level(plane1, fl4)", true)).
postcondition(action(("zoom", "plane1", "city0", "city0", "fl4", "fl3", "fl2")), effect(unconditional), variable(0), value("fuel-level(plane1, fl2)", true)).
costs(action(("zoom", "plane1", "city0", "city0", "fl4", "fl3", "fl2")), 1).

action(action(("zoom", "plane1", "city0", "city0", "fl5", "fl4", "fl3"))).
precondition(action(("zoom", "plane1", "city0", "city0", "fl5", "fl4", "fl3")), variable(1), value("at(plane1, city0)", true)).
precondition(action(("zoom", "plane1", "city0", "city0", "fl5", "fl4", "fl3")), variable(0), value("fuel-level(plane1, fl5)", true)).
postcondition(action(("zoom", "plane1", "city0", "city0", "fl5", "fl4", "fl3")), effect(unconditional), variable(0), value("fuel-level(plane1, fl3)", true)).
costs(action(("zoom", "plane1", "city0", "city0", "fl5", "fl4", "fl3")), 1).

action(action(("zoom", "plane1", "city0", "city0", "fl6", "fl5", "fl4"))).
precondition(action(("zoom", "plane1", "city0", "city0", "fl6", "fl5", "fl4")), variable(1), value("at(plane1, city0)", true)).
precondition(action(("zoom", "plane1", "city0", "city0", "fl6", "fl5", "fl4")), variable(0), value("fuel-level(plane1, fl6)", true)).
postcondition(action(("zoom", "plane1", "city0", "city0", "fl6", "fl5", "fl4")), effect(unconditional), variable(0), value("fuel-level(plane1, fl4)", true)).
costs(action(("zoom", "plane1", "city0", "city0", "fl6", "fl5", "fl4")), 1).

action(action(("zoom", "plane1", "city0", "city1", "fl2", "fl1", "fl0"))).
precondition(action(("zoom", "plane1", "city0", "city1", "fl2", "fl1", "fl0")), variable(1), value("at(plane1, city0)", true)).
precondition(action(("zoom", "plane1", "city0", "city1", "fl2", "fl1", "fl0")), variable(0), value("fuel-level(plane1, fl2)", true)).
postcondition(action(("zoom", "plane1", "city0", "city1", "fl2", "fl1", "fl0")), effect(unconditional), variable(1), value("at(plane1, city1)", true)).
postcondition(action(("zoom", "plane1", "city0", "city1", "fl2", "fl1", "fl0")), effect(unconditional), variable(0), value("fuel-level(plane1, fl0)", true)).
costs(action(("zoom", "plane1", "city0", "city1", "fl2", "fl1", "fl0")), 1).

action(action(("zoom", "plane1", "city0", "city1", "fl3", "fl2", "fl1"))).
precondition(action(("zoom", "plane1", "city0", "city1", "fl3", "fl2", "fl1")), variable(1), value("at(plane1, city0)", true)).
precondition(action(("zoom", "plane1", "city0", "city1", "fl3", "fl2", "fl1")), variable(0), value("fuel-level(plane1, fl3)", true)).
postcondition(action(("zoom", "plane1", "city0", "city1", "fl3", "fl2", "fl1")), effect(unconditional), variable(1), value("at(plane1, city1)", true)).
postcondition(action(("zoom", "plane1", "city0", "city1", "fl3", "fl2", "fl1")), effect(unconditional), variable(0), value("fuel-level(plane1, fl1)", true)).
costs(action(("zoom", "plane1", "city0", "city1", "fl3", "fl2", "fl1")), 1).

action(action(("zoom", "plane1", "city0", "city1", "fl4", "fl3", "fl2"))).
precondition(action(("zoom", "plane1", "city0", "city1", "fl4", "fl3", "fl2")), variable(1), value("at(plane1, city0)", true)).
precondition(action(("zoom", "plane1", "city0", "city1", "fl4", "fl3", "fl2")), variable(0), value("fuel-level(plane1, fl4)", true)).
postcondition(action(("zoom", "plane1", "city0", "city1", "fl4", "fl3", "fl2")), effect(unconditional), variable(1), value("at(plane1, city1)", true)).
postcondition(action(("zoom", "plane1", "city0", "city1", "fl4", "fl3", "fl2")), effect(unconditional), variable(0), value("fuel-level(plane1, fl2)", true)).
costs(action(("zoom", "plane1", "city0", "city1", "fl4", "fl3", "fl2")), 1).

action(action(("zoom", "plane1", "city0", "city1", "fl5", "fl4", "fl3"))).
precondition(action(("zoom", "plane1", "city0", "city1", "fl5", "fl4", "fl3")), variable(1), value("at(plane1, city0)", true)).
precondition(action(("zoom", "plane1", "city0", "city1", "fl5", "fl4", "fl3")), variable(0), value("fuel-level(plane1, fl5)", true)).
postcondition(action(("zoom", "plane1", "city0", "city1", "fl5", "fl4", "fl3")), effect(unconditional), variable(1), value("at(plane1, city1)", true)).
postcondition(action(("zoom", "plane1", "city0", "city1", "fl5", "fl4", "fl3")), effect(unconditional), variable(0), value("fuel-level(plane1, fl3)", true)).
costs(action(("zoom", "plane1", "city0", "city1", "fl5", "fl4", "fl3")), 1).

action(action(("zoom", "plane1", "city0", "city1", "fl6", "fl5", "fl4"))).
precondition(action(("zoom", "plane1", "city0", "city1", "fl6", "fl5", "fl4")), variable(1), value("at(plane1, city0)", true)).
precondition(action(("zoom", "plane1", "city0", "city1", "fl6", "fl5", "fl4")), variable(0), value("fuel-level(plane1, fl6)", true)).
postcondition(action(("zoom", "plane1", "city0", "city1", "fl6", "fl5", "fl4")), effect(unconditional), variable(1), value("at(plane1, city1)", true)).
postcondition(action(("zoom", "plane1", "city0", "city1", "fl6", "fl5", "fl4")), effect(unconditional), variable(0), value("fuel-level(plane1, fl4)", true)).
costs(action(("zoom", "plane1", "city0", "city1", "fl6", "fl5", "fl4")), 1).

action(action(("zoom", "plane1", "city0", "city2", "fl2", "fl1", "fl0"))).
precondition(action(("zoom", "plane1", "city0", "city2", "fl2", "fl1", "fl0")), variable(1), value("at(plane1, city0)", true)).
precondition(action(("zoom", "plane1", "city0", "city2", "fl2", "fl1", "fl0")), variable(0), value("fuel-level(plane1, fl2)", true)).
postcondition(action(("zoom", "plane1", "city0", "city2", "fl2", "fl1", "fl0")), effect(unconditional), variable(1), value("at(plane1, city2)", true)).
postcondition(action(("zoom", "plane1", "city0", "city2", "fl2", "fl1", "fl0")), effect(unconditional), variable(0), value("fuel-level(plane1, fl0)", true)).
costs(action(("zoom", "plane1", "city0", "city2", "fl2", "fl1", "fl0")), 1).

action(action(("zoom", "plane1", "city0", "city2", "fl3", "fl2", "fl1"))).
precondition(action(("zoom", "plane1", "city0", "city2", "fl3", "fl2", "fl1")), variable(1), value("at(plane1, city0)", true)).
precondition(action(("zoom", "plane1", "city0", "city2", "fl3", "fl2", "fl1")), variable(0), value("fuel-level(plane1, fl3)", true)).
postcondition(action(("zoom", "plane1", "city0", "city2", "fl3", "fl2", "fl1")), effect(unconditional), variable(1), value("at(plane1, city2)", true)).
postcondition(action(("zoom", "plane1", "city0", "city2", "fl3", "fl2", "fl1")), effect(unconditional), variable(0), value("fuel-level(plane1, fl1)", true)).
costs(action(("zoom", "plane1", "city0", "city2", "fl3", "fl2", "fl1")), 1).

action(action(("zoom", "plane1", "city0", "city2", "fl4", "fl3", "fl2"))).
precondition(action(("zoom", "plane1", "city0", "city2", "fl4", "fl3", "fl2")), variable(1), value("at(plane1, city0)", true)).
precondition(action(("zoom", "plane1", "city0", "city2", "fl4", "fl3", "fl2")), variable(0), value("fuel-level(plane1, fl4)", true)).
postcondition(action(("zoom", "plane1", "city0", "city2", "fl4", "fl3", "fl2")), effect(unconditional), variable(1), value("at(plane1, city2)", true)).
postcondition(action(("zoom", "plane1", "city0", "city2", "fl4", "fl3", "fl2")), effect(unconditional), variable(0), value("fuel-level(plane1, fl2)", true)).
costs(action(("zoom", "plane1", "city0", "city2", "fl4", "fl3", "fl2")), 1).

action(action(("zoom", "plane1", "city0", "city2", "fl5", "fl4", "fl3"))).
precondition(action(("zoom", "plane1", "city0", "city2", "fl5", "fl4", "fl3")), variable(1), value("at(plane1, city0)", true)).
precondition(action(("zoom", "plane1", "city0", "city2", "fl5", "fl4", "fl3")), variable(0), value("fuel-level(plane1, fl5)", true)).
postcondition(action(("zoom", "plane1", "city0", "city2", "fl5", "fl4", "fl3")), effect(unconditional), variable(1), value("at(plane1, city2)", true)).
postcondition(action(("zoom", "plane1", "city0", "city2", "fl5", "fl4", "fl3")), effect(unconditional), variable(0), value("fuel-level(plane1, fl3)", true)).
costs(action(("zoom", "plane1", "city0", "city2", "fl5", "fl4", "fl3")), 1).

action(action(("zoom", "plane1", "city0", "city2", "fl6", "fl5", "fl4"))).
precondition(action(("zoom", "plane1", "city0", "city2", "fl6", "fl5", "fl4")), variable(1), value("at(plane1, city0)", true)).
precondition(action(("zoom", "plane1", "city0", "city2", "fl6", "fl5", "fl4")), variable(0), value("fuel-level(plane1, fl6)", true)).
postcondition(action(("zoom", "plane1", "city0", "city2", "fl6", "fl5", "fl4")), effect(unconditional), variable(1), value("at(plane1, city2)", true)).
postcondition(action(("zoom", "plane1", "city0", "city2", "fl6", "fl5", "fl4")), effect(unconditional), variable(0), value("fuel-level(plane1, fl4)", true)).
costs(action(("zoom", "plane1", "city0", "city2", "fl6", "fl5", "fl4")), 1).

action(action(("zoom", "plane1", "city1", "city0", "fl2", "fl1", "fl0"))).
precondition(action(("zoom", "plane1", "city1", "city0", "fl2", "fl1", "fl0")), variable(1), value("at(plane1, city1)", true)).
precondition(action(("zoom", "plane1", "city1", "city0", "fl2", "fl1", "fl0")), variable(0), value("fuel-level(plane1, fl2)", true)).
postcondition(action(("zoom", "plane1", "city1", "city0", "fl2", "fl1", "fl0")), effect(unconditional), variable(1), value("at(plane1, city0)", true)).
postcondition(action(("zoom", "plane1", "city1", "city0", "fl2", "fl1", "fl0")), effect(unconditional), variable(0), value("fuel-level(plane1, fl0)", true)).
costs(action(("zoom", "plane1", "city1", "city0", "fl2", "fl1", "fl0")), 1).

action(action(("zoom", "plane1", "city1", "city0", "fl3", "fl2", "fl1"))).
precondition(action(("zoom", "plane1", "city1", "city0", "fl3", "fl2", "fl1")), variable(1), value("at(plane1, city1)", true)).
precondition(action(("zoom", "plane1", "city1", "city0", "fl3", "fl2", "fl1")), variable(0), value("fuel-level(plane1, fl3)", true)).
postcondition(action(("zoom", "plane1", "city1", "city0", "fl3", "fl2", "fl1")), effect(unconditional), variable(1), value("at(plane1, city0)", true)).
postcondition(action(("zoom", "plane1", "city1", "city0", "fl3", "fl2", "fl1")), effect(unconditional), variable(0), value("fuel-level(plane1, fl1)", true)).
costs(action(("zoom", "plane1", "city1", "city0", "fl3", "fl2", "fl1")), 1).

action(action(("zoom", "plane1", "city1", "city0", "fl4", "fl3", "fl2"))).
precondition(action(("zoom", "plane1", "city1", "city0", "fl4", "fl3", "fl2")), variable(1), value("at(plane1, city1)", true)).
precondition(action(("zoom", "plane1", "city1", "city0", "fl4", "fl3", "fl2")), variable(0), value("fuel-level(plane1, fl4)", true)).
postcondition(action(("zoom", "plane1", "city1", "city0", "fl4", "fl3", "fl2")), effect(unconditional), variable(1), value("at(plane1, city0)", true)).
postcondition(action(("zoom", "plane1", "city1", "city0", "fl4", "fl3", "fl2")), effect(unconditional), variable(0), value("fuel-level(plane1, fl2)", true)).
costs(action(("zoom", "plane1", "city1", "city0", "fl4", "fl3", "fl2")), 1).

action(action(("zoom", "plane1", "city1", "city0", "fl5", "fl4", "fl3"))).
precondition(action(("zoom", "plane1", "city1", "city0", "fl5", "fl4", "fl3")), variable(1), value("at(plane1, city1)", true)).
precondition(action(("zoom", "plane1", "city1", "city0", "fl5", "fl4", "fl3")), variable(0), value("fuel-level(plane1, fl5)", true)).
postcondition(action(("zoom", "plane1", "city1", "city0", "fl5", "fl4", "fl3")), effect(unconditional), variable(1), value("at(plane1, city0)", true)).
postcondition(action(("zoom", "plane1", "city1", "city0", "fl5", "fl4", "fl3")), effect(unconditional), variable(0), value("fuel-level(plane1, fl3)", true)).
costs(action(("zoom", "plane1", "city1", "city0", "fl5", "fl4", "fl3")), 1).

action(action(("zoom", "plane1", "city1", "city0", "fl6", "fl5", "fl4"))).
precondition(action(("zoom", "plane1", "city1", "city0", "fl6", "fl5", "fl4")), variable(1), value("at(plane1, city1)", true)).
precondition(action(("zoom", "plane1", "city1", "city0", "fl6", "fl5", "fl4")), variable(0), value("fuel-level(plane1, fl6)", true)).
postcondition(action(("zoom", "plane1", "city1", "city0", "fl6", "fl5", "fl4")), effect(unconditional), variable(1), value("at(plane1, city0)", true)).
postcondition(action(("zoom", "plane1", "city1", "city0", "fl6", "fl5", "fl4")), effect(unconditional), variable(0), value("fuel-level(plane1, fl4)", true)).
costs(action(("zoom", "plane1", "city1", "city0", "fl6", "fl5", "fl4")), 1).

action(action(("zoom", "plane1", "city1", "city1", "fl2", "fl1", "fl0"))).
precondition(action(("zoom", "plane1", "city1", "city1", "fl2", "fl1", "fl0")), variable(1), value("at(plane1, city1)", true)).
precondition(action(("zoom", "plane1", "city1", "city1", "fl2", "fl1", "fl0")), variable(0), value("fuel-level(plane1, fl2)", true)).
postcondition(action(("zoom", "plane1", "city1", "city1", "fl2", "fl1", "fl0")), effect(unconditional), variable(0), value("fuel-level(plane1, fl0)", true)).
costs(action(("zoom", "plane1", "city1", "city1", "fl2", "fl1", "fl0")), 1).

action(action(("zoom", "plane1", "city1", "city1", "fl3", "fl2", "fl1"))).
precondition(action(("zoom", "plane1", "city1", "city1", "fl3", "fl2", "fl1")), variable(1), value("at(plane1, city1)", true)).
precondition(action(("zoom", "plane1", "city1", "city1", "fl3", "fl2", "fl1")), variable(0), value("fuel-level(plane1, fl3)", true)).
postcondition(action(("zoom", "plane1", "city1", "city1", "fl3", "fl2", "fl1")), effect(unconditional), variable(0), value("fuel-level(plane1, fl1)", true)).
costs(action(("zoom", "plane1", "city1", "city1", "fl3", "fl2", "fl1")), 1).

action(action(("zoom", "plane1", "city1", "city1", "fl4", "fl3", "fl2"))).
precondition(action(("zoom", "plane1", "city1", "city1", "fl4", "fl3", "fl2")), variable(1), value("at(plane1, city1)", true)).
precondition(action(("zoom", "plane1", "city1", "city1", "fl4", "fl3", "fl2")), variable(0), value("fuel-level(plane1, fl4)", true)).
postcondition(action(("zoom", "plane1", "city1", "city1", "fl4", "fl3", "fl2")), effect(unconditional), variable(0), value("fuel-level(plane1, fl2)", true)).
costs(action(("zoom", "plane1", "city1", "city1", "fl4", "fl3", "fl2")), 1).

action(action(("zoom", "plane1", "city1", "city1", "fl5", "fl4", "fl3"))).
precondition(action(("zoom", "plane1", "city1", "city1", "fl5", "fl4", "fl3")), variable(1), value("at(plane1, city1)", true)).
precondition(action(("zoom", "plane1", "city1", "city1", "fl5", "fl4", "fl3")), variable(0), value("fuel-level(plane1, fl5)", true)).
postcondition(action(("zoom", "plane1", "city1", "city1", "fl5", "fl4", "fl3")), effect(unconditional), variable(0), value("fuel-level(plane1, fl3)", true)).
costs(action(("zoom", "plane1", "city1", "city1", "fl5", "fl4", "fl3")), 1).

action(action(("zoom", "plane1", "city1", "city1", "fl6", "fl5", "fl4"))).
precondition(action(("zoom", "plane1", "city1", "city1", "fl6", "fl5", "fl4")), variable(1), value("at(plane1, city1)", true)).
precondition(action(("zoom", "plane1", "city1", "city1", "fl6", "fl5", "fl4")), variable(0), value("fuel-level(plane1, fl6)", true)).
postcondition(action(("zoom", "plane1", "city1", "city1", "fl6", "fl5", "fl4")), effect(unconditional), variable(0), value("fuel-level(plane1, fl4)", true)).
costs(action(("zoom", "plane1", "city1", "city1", "fl6", "fl5", "fl4")), 1).

action(action(("zoom", "plane1", "city1", "city2", "fl2", "fl1", "fl0"))).
precondition(action(("zoom", "plane1", "city1", "city2", "fl2", "fl1", "fl0")), variable(1), value("at(plane1, city1)", true)).
precondition(action(("zoom", "plane1", "city1", "city2", "fl2", "fl1", "fl0")), variable(0), value("fuel-level(plane1, fl2)", true)).
postcondition(action(("zoom", "plane1", "city1", "city2", "fl2", "fl1", "fl0")), effect(unconditional), variable(1), value("at(plane1, city2)", true)).
postcondition(action(("zoom", "plane1", "city1", "city2", "fl2", "fl1", "fl0")), effect(unconditional), variable(0), value("fuel-level(plane1, fl0)", true)).
costs(action(("zoom", "plane1", "city1", "city2", "fl2", "fl1", "fl0")), 1).

action(action(("zoom", "plane1", "city1", "city2", "fl3", "fl2", "fl1"))).
precondition(action(("zoom", "plane1", "city1", "city2", "fl3", "fl2", "fl1")), variable(1), value("at(plane1, city1)", true)).
precondition(action(("zoom", "plane1", "city1", "city2", "fl3", "fl2", "fl1")), variable(0), value("fuel-level(plane1, fl3)", true)).
postcondition(action(("zoom", "plane1", "city1", "city2", "fl3", "fl2", "fl1")), effect(unconditional), variable(1), value("at(plane1, city2)", true)).
postcondition(action(("zoom", "plane1", "city1", "city2", "fl3", "fl2", "fl1")), effect(unconditional), variable(0), value("fuel-level(plane1, fl1)", true)).
costs(action(("zoom", "plane1", "city1", "city2", "fl3", "fl2", "fl1")), 1).

action(action(("zoom", "plane1", "city1", "city2", "fl4", "fl3", "fl2"))).
precondition(action(("zoom", "plane1", "city1", "city2", "fl4", "fl3", "fl2")), variable(1), value("at(plane1, city1)", true)).
precondition(action(("zoom", "plane1", "city1", "city2", "fl4", "fl3", "fl2")), variable(0), value("fuel-level(plane1, fl4)", true)).
postcondition(action(("zoom", "plane1", "city1", "city2", "fl4", "fl3", "fl2")), effect(unconditional), variable(1), value("at(plane1, city2)", true)).
postcondition(action(("zoom", "plane1", "city1", "city2", "fl4", "fl3", "fl2")), effect(unconditional), variable(0), value("fuel-level(plane1, fl2)", true)).
costs(action(("zoom", "plane1", "city1", "city2", "fl4", "fl3", "fl2")), 1).

action(action(("zoom", "plane1", "city1", "city2", "fl5", "fl4", "fl3"))).
precondition(action(("zoom", "plane1", "city1", "city2", "fl5", "fl4", "fl3")), variable(1), value("at(plane1, city1)", true)).
precondition(action(("zoom", "plane1", "city1", "city2", "fl5", "fl4", "fl3")), variable(0), value("fuel-level(plane1, fl5)", true)).
postcondition(action(("zoom", "plane1", "city1", "city2", "fl5", "fl4", "fl3")), effect(unconditional), variable(1), value("at(plane1, city2)", true)).
postcondition(action(("zoom", "plane1", "city1", "city2", "fl5", "fl4", "fl3")), effect(unconditional), variable(0), value("fuel-level(plane1, fl3)", true)).
costs(action(("zoom", "plane1", "city1", "city2", "fl5", "fl4", "fl3")), 1).

action(action(("zoom", "plane1", "city1", "city2", "fl6", "fl5", "fl4"))).
precondition(action(("zoom", "plane1", "city1", "city2", "fl6", "fl5", "fl4")), variable(1), value("at(plane1, city1)", true)).
precondition(action(("zoom", "plane1", "city1", "city2", "fl6", "fl5", "fl4")), variable(0), value("fuel-level(plane1, fl6)", true)).
postcondition(action(("zoom", "plane1", "city1", "city2", "fl6", "fl5", "fl4")), effect(unconditional), variable(1), value("at(plane1, city2)", true)).
postcondition(action(("zoom", "plane1", "city1", "city2", "fl6", "fl5", "fl4")), effect(unconditional), variable(0), value("fuel-level(plane1, fl4)", true)).
costs(action(("zoom", "plane1", "city1", "city2", "fl6", "fl5", "fl4")), 1).

action(action(("zoom", "plane1", "city2", "city0", "fl2", "fl1", "fl0"))).
precondition(action(("zoom", "plane1", "city2", "city0", "fl2", "fl1", "fl0")), variable(1), value("at(plane1, city2)", true)).
precondition(action(("zoom", "plane1", "city2", "city0", "fl2", "fl1", "fl0")), variable(0), value("fuel-level(plane1, fl2)", true)).
postcondition(action(("zoom", "plane1", "city2", "city0", "fl2", "fl1", "fl0")), effect(unconditional), variable(1), value("at(plane1, city0)", true)).
postcondition(action(("zoom", "plane1", "city2", "city0", "fl2", "fl1", "fl0")), effect(unconditional), variable(0), value("fuel-level(plane1, fl0)", true)).
costs(action(("zoom", "plane1", "city2", "city0", "fl2", "fl1", "fl0")), 1).

action(action(("zoom", "plane1", "city2", "city0", "fl3", "fl2", "fl1"))).
precondition(action(("zoom", "plane1", "city2", "city0", "fl3", "fl2", "fl1")), variable(1), value("at(plane1, city2)", true)).
precondition(action(("zoom", "plane1", "city2", "city0", "fl3", "fl2", "fl1")), variable(0), value("fuel-level(plane1, fl3)", true)).
postcondition(action(("zoom", "plane1", "city2", "city0", "fl3", "fl2", "fl1")), effect(unconditional), variable(1), value("at(plane1, city0)", true)).
postcondition(action(("zoom", "plane1", "city2", "city0", "fl3", "fl2", "fl1")), effect(unconditional), variable(0), value("fuel-level(plane1, fl1)", true)).
costs(action(("zoom", "plane1", "city2", "city0", "fl3", "fl2", "fl1")), 1).

action(action(("zoom", "plane1", "city2", "city0", "fl4", "fl3", "fl2"))).
precondition(action(("zoom", "plane1", "city2", "city0", "fl4", "fl3", "fl2")), variable(1), value("at(plane1, city2)", true)).
precondition(action(("zoom", "plane1", "city2", "city0", "fl4", "fl3", "fl2")), variable(0), value("fuel-level(plane1, fl4)", true)).
postcondition(action(("zoom", "plane1", "city2", "city0", "fl4", "fl3", "fl2")), effect(unconditional), variable(1), value("at(plane1, city0)", true)).
postcondition(action(("zoom", "plane1", "city2", "city0", "fl4", "fl3", "fl2")), effect(unconditional), variable(0), value("fuel-level(plane1, fl2)", true)).
costs(action(("zoom", "plane1", "city2", "city0", "fl4", "fl3", "fl2")), 1).

action(action(("zoom", "plane1", "city2", "city0", "fl5", "fl4", "fl3"))).
precondition(action(("zoom", "plane1", "city2", "city0", "fl5", "fl4", "fl3")), variable(1), value("at(plane1, city2)", true)).
precondition(action(("zoom", "plane1", "city2", "city0", "fl5", "fl4", "fl3")), variable(0), value("fuel-level(plane1, fl5)", true)).
postcondition(action(("zoom", "plane1", "city2", "city0", "fl5", "fl4", "fl3")), effect(unconditional), variable(1), value("at(plane1, city0)", true)).
postcondition(action(("zoom", "plane1", "city2", "city0", "fl5", "fl4", "fl3")), effect(unconditional), variable(0), value("fuel-level(plane1, fl3)", true)).
costs(action(("zoom", "plane1", "city2", "city0", "fl5", "fl4", "fl3")), 1).

action(action(("zoom", "plane1", "city2", "city0", "fl6", "fl5", "fl4"))).
precondition(action(("zoom", "plane1", "city2", "city0", "fl6", "fl5", "fl4")), variable(1), value("at(plane1, city2)", true)).
precondition(action(("zoom", "plane1", "city2", "city0", "fl6", "fl5", "fl4")), variable(0), value("fuel-level(plane1, fl6)", true)).
postcondition(action(("zoom", "plane1", "city2", "city0", "fl6", "fl5", "fl4")), effect(unconditional), variable(1), value("at(plane1, city0)", true)).
postcondition(action(("zoom", "plane1", "city2", "city0", "fl6", "fl5", "fl4")), effect(unconditional), variable(0), value("fuel-level(plane1, fl4)", true)).
costs(action(("zoom", "plane1", "city2", "city0", "fl6", "fl5", "fl4")), 1).

action(action(("zoom", "plane1", "city2", "city1", "fl2", "fl1", "fl0"))).
precondition(action(("zoom", "plane1", "city2", "city1", "fl2", "fl1", "fl0")), variable(1), value("at(plane1, city2)", true)).
precondition(action(("zoom", "plane1", "city2", "city1", "fl2", "fl1", "fl0")), variable(0), value("fuel-level(plane1, fl2)", true)).
postcondition(action(("zoom", "plane1", "city2", "city1", "fl2", "fl1", "fl0")), effect(unconditional), variable(1), value("at(plane1, city1)", true)).
postcondition(action(("zoom", "plane1", "city2", "city1", "fl2", "fl1", "fl0")), effect(unconditional), variable(0), value("fuel-level(plane1, fl0)", true)).
costs(action(("zoom", "plane1", "city2", "city1", "fl2", "fl1", "fl0")), 1).

action(action(("zoom", "plane1", "city2", "city1", "fl3", "fl2", "fl1"))).
precondition(action(("zoom", "plane1", "city2", "city1", "fl3", "fl2", "fl1")), variable(1), value("at(plane1, city2)", true)).
precondition(action(("zoom", "plane1", "city2", "city1", "fl3", "fl2", "fl1")), variable(0), value("fuel-level(plane1, fl3)", true)).
postcondition(action(("zoom", "plane1", "city2", "city1", "fl3", "fl2", "fl1")), effect(unconditional), variable(1), value("at(plane1, city1)", true)).
postcondition(action(("zoom", "plane1", "city2", "city1", "fl3", "fl2", "fl1")), effect(unconditional), variable(0), value("fuel-level(plane1, fl1)", true)).
costs(action(("zoom", "plane1", "city2", "city1", "fl3", "fl2", "fl1")), 1).

action(action(("zoom", "plane1", "city2", "city1", "fl4", "fl3", "fl2"))).
precondition(action(("zoom", "plane1", "city2", "city1", "fl4", "fl3", "fl2")), variable(1), value("at(plane1, city2)", true)).
precondition(action(("zoom", "plane1", "city2", "city1", "fl4", "fl3", "fl2")), variable(0), value("fuel-level(plane1, fl4)", true)).
postcondition(action(("zoom", "plane1", "city2", "city1", "fl4", "fl3", "fl2")), effect(unconditional), variable(1), value("at(plane1, city1)", true)).
postcondition(action(("zoom", "plane1", "city2", "city1", "fl4", "fl3", "fl2")), effect(unconditional), variable(0), value("fuel-level(plane1, fl2)", true)).
costs(action(("zoom", "plane1", "city2", "city1", "fl4", "fl3", "fl2")), 1).

action(action(("zoom", "plane1", "city2", "city1", "fl5", "fl4", "fl3"))).
precondition(action(("zoom", "plane1", "city2", "city1", "fl5", "fl4", "fl3")), variable(1), value("at(plane1, city2)", true)).
precondition(action(("zoom", "plane1", "city2", "city1", "fl5", "fl4", "fl3")), variable(0), value("fuel-level(plane1, fl5)", true)).
postcondition(action(("zoom", "plane1", "city2", "city1", "fl5", "fl4", "fl3")), effect(unconditional), variable(1), value("at(plane1, city1)", true)).
postcondition(action(("zoom", "plane1", "city2", "city1", "fl5", "fl4", "fl3")), effect(unconditional), variable(0), value("fuel-level(plane1, fl3)", true)).
costs(action(("zoom", "plane1", "city2", "city1", "fl5", "fl4", "fl3")), 1).

action(action(("zoom", "plane1", "city2", "city1", "fl6", "fl5", "fl4"))).
precondition(action(("zoom", "plane1", "city2", "city1", "fl6", "fl5", "fl4")), variable(1), value("at(plane1, city2)", true)).
precondition(action(("zoom", "plane1", "city2", "city1", "fl6", "fl5", "fl4")), variable(0), value("fuel-level(plane1, fl6)", true)).
postcondition(action(("zoom", "plane1", "city2", "city1", "fl6", "fl5", "fl4")), effect(unconditional), variable(1), value("at(plane1, city1)", true)).
postcondition(action(("zoom", "plane1", "city2", "city1", "fl6", "fl5", "fl4")), effect(unconditional), variable(0), value("fuel-level(plane1, fl4)", true)).
costs(action(("zoom", "plane1", "city2", "city1", "fl6", "fl5", "fl4")), 1).

action(action(("zoom", "plane1", "city2", "city2", "fl2", "fl1", "fl0"))).
precondition(action(("zoom", "plane1", "city2", "city2", "fl2", "fl1", "fl0")), variable(1), value("at(plane1, city2)", true)).
precondition(action(("zoom", "plane1", "city2", "city2", "fl2", "fl1", "fl0")), variable(0), value("fuel-level(plane1, fl2)", true)).
postcondition(action(("zoom", "plane1", "city2", "city2", "fl2", "fl1", "fl0")), effect(unconditional), variable(0), value("fuel-level(plane1, fl0)", true)).
costs(action(("zoom", "plane1", "city2", "city2", "fl2", "fl1", "fl0")), 1).

action(action(("zoom", "plane1", "city2", "city2", "fl3", "fl2", "fl1"))).
precondition(action(("zoom", "plane1", "city2", "city2", "fl3", "fl2", "fl1")), variable(1), value("at(plane1, city2)", true)).
precondition(action(("zoom", "plane1", "city2", "city2", "fl3", "fl2", "fl1")), variable(0), value("fuel-level(plane1, fl3)", true)).
postcondition(action(("zoom", "plane1", "city2", "city2", "fl3", "fl2", "fl1")), effect(unconditional), variable(0), value("fuel-level(plane1, fl1)", true)).
costs(action(("zoom", "plane1", "city2", "city2", "fl3", "fl2", "fl1")), 1).

action(action(("zoom", "plane1", "city2", "city2", "fl4", "fl3", "fl2"))).
precondition(action(("zoom", "plane1", "city2", "city2", "fl4", "fl3", "fl2")), variable(1), value("at(plane1, city2)", true)).
precondition(action(("zoom", "plane1", "city2", "city2", "fl4", "fl3", "fl2")), variable(0), value("fuel-level(plane1, fl4)", true)).
postcondition(action(("zoom", "plane1", "city2", "city2", "fl4", "fl3", "fl2")), effect(unconditional), variable(0), value("fuel-level(plane1, fl2)", true)).
costs(action(("zoom", "plane1", "city2", "city2", "fl4", "fl3", "fl2")), 1).

action(action(("zoom", "plane1", "city2", "city2", "fl5", "fl4", "fl3"))).
precondition(action(("zoom", "plane1", "city2", "city2", "fl5", "fl4", "fl3")), variable(1), value("at(plane1, city2)", true)).
precondition(action(("zoom", "plane1", "city2", "city2", "fl5", "fl4", "fl3")), variable(0), value("fuel-level(plane1, fl5)", true)).
postcondition(action(("zoom", "plane1", "city2", "city2", "fl5", "fl4", "fl3")), effect(unconditional), variable(0), value("fuel-level(plane1, fl3)", true)).
costs(action(("zoom", "plane1", "city2", "city2", "fl5", "fl4", "fl3")), 1).

action(action(("zoom", "plane1", "city2", "city2", "fl6", "fl5", "fl4"))).
precondition(action(("zoom", "plane1", "city2", "city2", "fl6", "fl5", "fl4")), variable(1), value("at(plane1, city2)", true)).
precondition(action(("zoom", "plane1", "city2", "city2", "fl6", "fl5", "fl4")), variable(0), value("fuel-level(plane1, fl6)", true)).
postcondition(action(("zoom", "plane1", "city2", "city2", "fl6", "fl5", "fl4")), effect(unconditional), variable(0), value("fuel-level(plane1, fl4)", true)).
costs(action(("zoom", "plane1", "city2", "city2", "fl6", "fl5", "fl4")), 1).

% initial state
initialState(variable(0), value("fuel-level(plane1, fl2)", true)).
initialState(variable(1), value("at(plane1, city0)", true)).
initialState(variable(2), value("at(person3, city2)", true)).
initialState(variable(3), value("at(person1, city2)", true)).

% goal
goal(variable(1), value("at(plane1, city2)", true)).
goal(variable(2), value("at(person3, city2)", true)).
goal(variable(3), value("at(person1, city1)", true)).
