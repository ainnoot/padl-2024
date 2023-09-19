% Absence
holds(absence(X),TID) :- 
  constraint(C, "Absence"),
  bind(C, activation, X),
  trace(TID,_,_),
  not trace(TID,_,X).

% Existence
holds(exists(X),TID) :- 
  constraint(C, "Existence"),
  bind(C, activation, X),
  trace(TID,_,X).


compute(responded_existence(X,Y)) :- constraint(C, "Responded Existence"), bind(C, activation, X), bind(C, target, Y).
compute(responded_existence(X,Y)) :- constraint(C, "Co-Existence"), bind(C, activation, X), bind(C, target, Y).
compute(responded_existence(Y,X)) :- constraint(C, "Co-Existence"), bind(C, activation, X), bind(C, target, Y).

% Responded Existence
fail(responded_existence(X,Y),TID) :-
  compute(responded_existence(X,Y)),
  trace(TID,_,X), 
  not trace(TID,_,Y).

holds(responded_existence(X,Y),TID) :- 
  constraint(C, "Responded Existence"),
  bind(C, activation, X), 
  bind(C, target, Y), 
  trace(TID,_,_), not fail(responded_existence(X,Y),TID).

compute(response(X,Y)) :- constraint(C, "Response"), bind(C, activation, X), bind(C, target, Y).
compute(response(X,Y)) :- constraint(C, "Succession"), bind(C, activation, X), bind(C, target, Y).

% Response
witness(response(X,Y),T,TID) :- 
  compute(response(X,Y)),
  trace(TID, T, X), trace(TID, T', Y), T' > T.

fail(response(X,Y),TID) :-
  compute(response(X,Y)),
  trace(TID, T, X), not witness(response(X,Y),T,TID).
 
holds(response(X,Y),TID) :- 
  compute(response(X,Y)),
  trace(TID,_,_), not fail(response(X,Y),TID).

compute(alternate_response(X,Y)) :- constraint(C, "Alternate Response"), bind(C, activation, X), bind(C, target, Y).
compute(alternate_response(X,Y)) :- constraint(C, "Alternate Succession"), bind(C, activation, X), bind(C, target, Y).

% Alternate Response
witness(alternate_response(X,Y),T,TID) :-
  compute(alternate_response(X,Y)),
  trace(TID,T,X),
  T'' = #min{Q: trace(TID,Q,X), Q > T}, 
  trace(TID,T',Y), T'' > T', T' > T.

fail(alternate_response(X,Y),TID) :- 
  compute(alternate_response(X,Y)),
  trace(TID,T,X), not witness(alternate_response(X,Y),T,TID).

holds(alternate_response(X,Y),TID) :-
  compute(alternate_response(X,Y)),
  trace(TID,_,_), not fail(alternate_response(X,Y),TID).

compute(chain_response(X,Y)) :- constraint(C, "Chain Response"), bind(C, activation, X), bind(C, target, Y).
compute(chain_response(X,Y)) :- constraint(C, "Chain Succession"), bind(C, activation, X), bind(C, target, Y).

% Chain Response
fail(chain_response(X,Y),TID) :- 
  compute(chain_response(X,Y)),
  trace(TID,T,X), 
  not trace(TID,T+1,Y).

holds(chain_response(X,Y),TID) :- 
  compute(chain_response(X,Y)),
  trace(TID,_,_), not fail(chain_response(X,Y),TID).

compute(precedence(X,Y)) :- constraint(C, "Precedence"), bind(C, activation, Y), bind(C, target, X).
compute(precedence(X,Y)) :- constraint(C, "Succession"), bind(C, activation, Y), bind(C, target, X).

% Precedence
fail(precedence(X,Y),TID) :-
  compute(precedence(X,Y)),
  trace(TID,T',Y),
  T = #min{Q: trace(TID,Q,X)}, 
  T' < T.

holds(precedence(X,Y),TID) :- 
  compute(precedence(X,Y)),
  trace(TID,_,_), not fail(precedence(X,Y),TID).

compute(alternate_precedence(X,Y)) :- constraint(C, "Alternate Precedence"), bind(C, activation, Y), bind(C, target, X).
compute(alternate_precedence(X,Y)) :- constraint(C, "Alternate Succession"), bind(C, activation, Y), bind(C, target, X).


% Alternate Precedence
witness(alternate_precedence(X,Y),T'',TID) :-
  compute(alternate_precedence(X,Y)),
  trace(TID,T'',Y),
  T = #max{Q: trace(TID,Q,Y), Q < T''},
  trace(TID,T',X), T' > T, T'' > T'.

fail(alternate_precedence(X,Y),TID) :-
  compute(alternate_precedence(X,Y)),
  not witness(alternate_precedence(X,Y),T,TID),
  trace(TID,T,Y).

holds(alternate_precedence(X,Y),TID) :-
  compute(alternate_precedence(X,Y)),
  trace(TID,_,_), not fail(alternate_precedence(X,Y),TID).

compute(chain_precedence(X,Y)) :- constraint(C, "Chain Precedence"), bind(C, activation, Y), bind(C, target, X).
compute(chain_precedence(X,Y)) :- constraint(C, "Chain Succession"), bind(C, activation, Y), bind(C, target, X).

% Chain Precedence
fail(chain_precedence(X,Y),TID) :- 
  compute(chain_precedence(X,Y)),
  trace(TID,T,Y), 
  not trace(TID,T-1,X).

holds(chain_precedence(X,Y),TID) :- 
  compute(chain_precedence(X,Y)),
  trace(TID,_,_), not fail(chain_precedence(X,Y),TID).

% Co-Existence
holds(co_existence(X,Y),TID) :- 
  constraint(C, "Co-Existence"), 
  bind(C, activation, X), 
  bind(C, target, Y), 
  holds(responded_existence(X,Y),TID),
  holds(responded_existence(Y,X),TID).

% Succession
holds(succession(X,Y),TID) :- 
  constraint(C, "Succession"), 
  bind(C, activation, X), 
  bind(C, target, Y),
  holds(response(X,Y),TID), 
  holds(precedence(X,Y),TID).

% Alternate Succession 
holds(alternate_succession(X,Y),TID) :- 
  constraint(C, "Alternate Succession"), 
  bind(C, activation, X), 
  bind(C, target, Y), 
  holds(alternate_precedence(X,Y),TID), 
  holds(alternate_response(X,Y),TID).

% Chain Succession
holds(chain_succession(X,Y),TID) :- 
  constraint(C, "Chain Succession"),
  bind(C, activation, X), 
  bind(C, target, X), 
  holds(chain_response(X,Y),TID),
  holds(chain_precedence(X,Y),TID).

sat(adhoc,C,TID) :- holds(C,TID).
