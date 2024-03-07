#show.
#show ok((T,A,B),TID): sat(_,C,TID), constraint(C,T), bind(C,arg_0,A), bind(C,arg_1,B).
#show fail((T,A,B),TID): not sat(_,C,TID), trace(TID,_,_), constraint(C,T), bind(C,arg_0,A), bind(C,arg_1,B).
