activity("a_0").
activity("a_1").
activity("a_2").
activity("a_3").
activity("a_4").
activity("a_5").
activity("a_6").
activity("a_7").
activity("a_8").
activity("a_9").
actitity("b_0").
activity("b_1").
activity("b_2").
activity("b_3").
activity("b_4").


#external negative.
#const t=-1.

:- t < 0.

time(0..t-1).
{ trace(0,T,A): activity(A) } = 1 :- time(T).
:- not trace(0,_,A), bind(0,arg_0,A).
:- not trace(0,_,A), bind(0,arg_1,A).

positive :- not negative.

:- not sat(_,0,0), positive.
:- sat(_,0,0), negative.

#show.
#show trace/3.

