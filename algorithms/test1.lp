plan_steps(T) :- occurs(_, T).

% === 3. Logik (ehemals #program step(t)) ===
% Statt 't' als Parameter, nutzen wir 'T' als Variable im Body.

% Apply: Eine Aktion wird angewendet, wenn alle Konflikt-Partner 'ready' sind
apply(A1, T) :- plan_steps(T), action(A1), 
    ready(A2, T) : post(A1, X, V1), prec(A2, X, V2), A1 != A2 , V1 != V2.

% Ready: Aktion ist ready, wenn sie nicht im Plan vorkommt...
ready(A, T) :- plan_steps(T), action(A), not occurs(A, T).
% ...oder wenn sie bereits angewendet wurde (rekursiv/stratifiziert).
ready(A, T) :- plan_steps(T), apply(A, T).

% Cycle: Wenn eine Aktion im Plan steht, aber nicht 'ready' wird -> Blockade!
cycle(T) :- plan_steps(T), action(A), not ready(A, T).

% === 4. Check (ehemals #program check(t)) ===
% Paper Logik: Wir suchen gezielt nach Fehlern.
% Wenn SATISFIABLE rauskommt, existiert ein Cycle -> Plan UNGÜLTIG.
% Wenn UNSATISFIABLE rauskommt, gibt es keinen Cycle -> Plan GÜLTIG.

% Dieser Constraint erzwingt, dass ein Cycle gefunden werden MUSS.
:- plan_steps(T), not cycle(T). 
% (Hinweis: Das prüft streng genommen, ob JEDER Schritt einen Cycle hat. 
%  Für "irgendeinen Fehler" reicht oft: ":- not cycle(_)." wenn man nur wissen will ob der Plan kaputt ist.)

#show.
#show cycle/1.