% Edits
% trace(TID,A,T) -> trace(TID,T,A)
%

% cur_state(K,I,S,0) -> cur_state(K,I,S,-1)
% 

% template(K,_) -> constraint(K,_)
%

% trace_len(TID,T) -> last(TID,T)
%

last(TID,T) :- trace(TID,T,_), not trace(TID,T+1,_).

cur_state(C,TID,S,0) :- 
  trace(TID,_,_), 
  initial(Template,S), 
  constraint(C,Template).

cur_state(C,TID,S2,T+1) :- 
  cur_state(C,TID,S1,T), 
  constraint(C,Template), 
  template(Template,S1, __skip__, S2), 
  trace(TID,T,A), 
  not bind(C,_,A).

cur_state(C,TID,S2,T+1) :- 
  cur_state(C,TID,S1,T), 
  constraint(C,Template), 
  template(Template,S1,Arg,S2), 
  trace(TID,T,A), 
  bind(C,Arg,A).

sat(automata,C,TID)  :- cur_state(C,TID,S,T+1), last(TID,T), constraint(C, Template), accepting(Template, S).

