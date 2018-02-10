%% durativeAction(walk,
%% 	       [
%% 		are(['$VAR'('A')],intelligentAgent),
%% 		are(['$VAR'('L0'),'$VAR'('L1')],physicalLocation),
%% 		are(['$VAR'('M')],modeOfTransportation)
%% 	       ],
%% 	       'travel-duration'('$VAR'('M'),'$VAR'('L0'),'$VAR'('L1')),
%% 	       [
%% 		'over all'('walking-p'('$VAR'('M'))),
%% 		'over all'('travel-path'('$VAR'('M'),'$VAR'('L0'),'$VAR'('L1'))),
%% 		'over all'(autonomous('$VAR'('A'))),
%% 		'at start'(location('$VAR'('A'),'$VAR'('L0')))
%% 	       ],
%% 	       [
%% 		'at end'(not(location('$VAR'('A'),'$VAR'('L0')))),
%% 		'at end'(location('$VAR'('A'),'$VAR'('L1')))
%% 	       ]
%% 	      ).

propagateEffects([Step,Time,Point,Action,Items],DurativeAction,Sorted,World0,World1) :-
	%% take the world, and update items as needed.  use deduction
	%% rather than unification, i.e. followsFrom(Fact,World),
	%% rather than member(Fact,World).  Also try to first see if
	%% it contradicts the world.
	true.
