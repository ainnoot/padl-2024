% Absence
% X never occurs
holds(constraint(absence,X,X),TID) :- trace(TID), activity(X), not trace(TID,_,X).

% AtLeast1
% X occurs at least one time
holds(constraint(atleast1,X,X),TID) :- trace(TID,_,X).

% XtLeast2
% X occurs at least two times
holds(constraint(atleast2,X,X),TID) :- occurrences(TID,X,N), N >= 2.

% AtLeast3
% X occurs at least three times
holds(constraint(atleast3,X,X),TID) :- occurrences(TID,X,N), N >= 3.

% AtMost1
% X occurs at most one time
holds(constraint(atmost1,X,X),TID) :- occurrences(TID,X,N), N <= 1.

% AtMost2
% X occurs at most two times
holds(constraint(atmost2,X,X),TID) :- occurrences(TID,X,N), N <= 2.

% AtMost3
% X occurs at most three times
holds(constraint(atmost3,X,X),TID) :- occurrences(TID,X,N), N <= 3.

% Exactly1
% X occurs one time
holds(constraint(exactly1,X,X),TID) :- occurrences(TID,X,1).

% Exactly2
% X occurs two times
holds(constraint(exactly2,X,X),TID) :- occurrences(TID,X,2).

% Exactly3
% X occurs three times
holds(constraint(exactly3,X,X),TID) :- occurrences(TID,X,3).

% Init
% X is the first to occur
holds(constraint(init,X,X),TID) :- trace(TID,1,X).


% End
% X is the last to occur
holds(constraint(end,X,X),TID) :- length(TID,K), trace(TID,K,X).


% Responded Existence
% If X occurs then Y occurs too
__aux__not_respondedexistence(TID,X,Y) :- activity(Y), trace(TID,_,X), not trace(TID,_,Y).
holds(constraint(respondedexistence,X,Y),TID) :- X != Y, activity(X), activity(Y), trace(TID), not __aux__not_respondedexistence(TID,X,Y).

% Response
% If X occurs, then Y occurs after X
__aux_response_witness(TID,X,Y,T) :- trace(TID,T,X), trace(TID,T',Y), T' > T.
__aux_not_response(TID,X,Y) :- trace(TID,T,X), not __aux_response_witness(TID,X,Y,T), activity(Y).
holds(constraint(response,X,Y),TID) :- X != Y, trace(TID), activity(X), activity(Y), not __aux_not_response(TID,X,Y).


% Alternate Response
% If X occurs, Y occurs afterwards before X recurs
__aux_alternateresponse_witness(TID,X,Y,T) :- trace(TID,T,X), T'' = #min{X: trace(TID,X,X), X > T}, trace(TID,T',Y), T' > T, T' < T''.
__aux_not_alternateresponse(TID,X,Y) :- trace(TID,T,X), activity(Y), not __aux_alternateresponse_witness(TID,X,Y,T).
holds(constraint(alternateresponse,X,Y),TID) :- X != Y, trace(TID), activity(X), activity(Y), not __aux_not_alternateresponse(TID,X,Y).

% Chain Response
% If X occurs, Y occurs immediately after it
__aux_chainresponse_vio_witness(TID,X,Y) :- trace(TID,T,X), not trace(TID,T+1,Y), activity(Y).
holds(constraint(chainresponse,X,Y),TID) :- X != Y, activity(X), activity(Y), trace(TID), not __aux_chainresponse_vio_witness(TID,X,Y).


% Precedence
% Y occurs only if preceded by X
__aux_precedence_vio_witness(TID,X,Y) :- trace(TID,T',Y), T=#min{X: trace(TID,X,X)}, trace(TID,T,X), T' < T.
__aux_precedence_vio_witness(TID,X,Y) :- trace(TID,_,Y), activity(X), not trace(TID,_,X).
holds(constraint(precedence,X,Y),TID) :- X != Y, activity(X),activity(Y),trace(TID), not __aux_precedence_vio_witness(TID,X,Y).

% Alternate Precedence
% Y occurs only if preceded by X with no other Y in between
__aux_alternateprecedence_witness(TID,X,Y,T'') :- trace(TID,T'',Y), T = #max{X: trace(TID,X,Y), X < T''}, trace(TID,T',X), T' < T'', T' > T.
__aux_not_alternateprecedence(TID,X,Y) :- trace(TID,T,Y), activity(X), not __aux_alternateprecedence_witness(TID,X,Y,T).
holds(constraint(alternateprecedence,X,Y),TID) :- X != Y, trace(TID), activity(X), activity(Y), not __aux_not_alternateprecedence(TID,X,Y).

% Chain Precedence
% Y occurs only if X occurs immediately before it
__aux_chainprecedence_vio_witness(TID,X,Y) :- trace(TID,T,Y), not trace(TID,T-1,X), activity(X).
holds(constraint(chainprecedence,X,Y),TID) :- X != Y, activity(X), activity(Y), trace(TID), not __aux_chainprecedence_vio_witness(TID,X,Y).


% Co-Existence
% X occurs iff Y occurs
holds(constraint(coexistence,X,Y),TID) :- X < Y, holds(constraint(respondedexistence,X,Y),TID), holds(constraint(respondedexistence,Y,X),TID).

% Succession
% X occurs iff it is followed by Y
holds(constraint(succession,X,Y),TID) :- X != Y, holds(constraint(response,X,Y),TID), holds(constraint(precedence,X,Y),TID).


% Alternate Succession 
% X and Y occur iff they follow one another, alternating
holds(constraint(alternatesuccession,X,Y),TID) :- X != Y, holds(constraint(alternateprecedence,X,Y),TID), holds(constraint(alternateresponse,X,Y),TID).

% Chain Succession
% X and Y occur iff Y immediately follows X
holds(constraint(chainsuccession,X,Y),TID) :- X != Y, holds(constraint(chainresponse,X,Y),TID), holds(constraint(chainprecedence,X,Y),TID).


% Not Chain Succession
% X and Y occur iff Y does not immediately follow X
__aux_notchainsuccession_vio_witness(TID,X,Y) :- trace(TID,T,X), trace(TID,T+1,Y).
holds(constraint(notchainsuccession,X,Y),TID) :- X != Y, activity(X), activity(Y), trace(TID), not __aux_notchainsuccession_vio_witness(TID,X,Y). 

% Not Succession
% X can never occur before Y 
__aux_succession_vio_witness(TID,X,Y) :- trace(TID,T,X), trace(TID,T',Y), T < T'.
holds(constraint(notsuccession,X,Y),TID) :- X != Y, activity(X), activity(Y), trace(TID), not __aux_succession_vio_witness(TID,X,Y).


% Not Coexistence
% X and Y never co-occur
__aux_notcoexistence_vio_witness(TID,X,Y) :- trace(TID,_,X), trace(TID,_,Y).
holds(constraint(notcoexistence,X,Y),TID) :- X != Y, activity(X), activity(Y), trace(TID), not __aux_notcoexistence_vio_witness(TID,X,Y).



