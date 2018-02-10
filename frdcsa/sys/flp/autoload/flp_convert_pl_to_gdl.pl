runGDL :-
	currentCapsule(Capsule),
	playGDL([capsule(Capsule)]).

playGDL([capsule(Capsule)]) :-
	timestamp(TimeStamp),
	view([1]),
	exportPDDLDomainToGDL([

			       templateDir('/var/lib/myfrdcsa/codebases/internal/verber/data/worldmodel/templates/'),
			       worldDir('/var/lib/myfrdcsa/codebases/internal/verber/data/worldmodel/worlds/'),
			       capsule(Capsule)
			      ]),
	view([2]),
	atomic_list_concat(['cd /var/lib/myfrdcsa/codebases/minor/free-life-planner/projects/gdl && ./start.sh'],'',Command),
	view([command,Command]),
	%% shell(Command),
	true.

exportPDDLDomainToGDL([templateDir(DomainDir),worldDir(WorldDir),capsule(Capsule)]) :-
	view([a]),
	exportPDDLDomain([templateDir(DomainDir),worldDir(WorldDir),capsule(Capsule),parsed(Parsed2),results(Results)]),
	view([b]),
	viewIf([results,Results]),
	convertGDDLToGDL([templateDir(DomainDir),worldDir(WorldDir),capsule(Capsule),parsed(Parsed2),results(Results)]),
	view([all1,[templateDir(DomainDir),worldDir(WorldDir),capsule(Capsule),parsed(Parsed2),results(Results)]]).

convertGDDLToGDL([templateDir(DomainDir),worldDir(WorldDir),capsule(Capsule),parsed(Parsed2),results(Results)]) :-
	%% see /var/lib/myfrdcsa/codebases/minor/gddl-to-gdl/Symbolic Exploration for Generalized Game Playing in PDDL.pdf
	%% see /var/lib/myfrdcsa/codebases/minor/gddl-to-gdl/www.tzi.de/~edelkamp/pddl-games/models
	view([all,[templateDir(DomainDir),worldDir(WorldDir),capsule(Capsule),parsed(Parsed2),results(Results)]]).

%% Explicit-State Concept  Symbolic Concept     
%% Search Frontier		Function front(S)    
%% Expanded States		Function reach(S)    
%% Initial State(s)	Function init(S)     
%% Goal			Function goal(S)     
%% Action a		Relation ta (S, S 0 )
%% Action Set		Relation t(S, S 0 )  

%% 	(pair
%% 	 (gdl
%% 	  (init (cell 1 1 b))
   	
%% 	  (init (cell 3 3 b))
%% 	  (init (control xplayer))
%% 	  (<= terminal (line x))
%% 	  (<= terminal (line o))
%% 	  (<= terminal (not open))
%% 	  (<= (goal xplayer 100)
%% 	   (line x))
   	
%% 	  (<= (goal xplayer 50)
%% 	   (not (line x))
%% 	   (not (line o))
%% 	   (not open))
   	
%% 	  (<= (goal xplayer 0)
%% 	   (line o))
%% 	  )
   	
%% 	 (gddl
%% 	  (:init
%% 	   (cell r1 c1 b)
   	
%% 	   (cell r3 c3 b)
%% 	   (control xplayer))
%% 	  (:goal
%% 	   (or
%% 	    (line x) (line o)
%% 	    (not (open))))
%% 	  (:gain ?player - role 100
%% 	   (and
%% 	    (= ?player xplayer)
%% 	    (line x)))
%% 	  (:gain ?player - role 50
%% 	   (and
%% 	    (= ?player xplayer)
%% 	    (not (line x))
%% 	    (not (line o))
%% 	    (not (open))))
%% 	  (:gain ?player - role 0
%% 	   (and
%% 	    (= ?player xplayer)
%% 	    (line o)))
%% 	  )
%% 	 )
   	
%% 	(pair
%% 	 (gdl
%% 	  (<= (row ?m ?x)
%% 	   (true (cell ?m 1 ?x))
%% 	   (true (cell ?m 2 ?x))
%% 	   (true (cell ?m 3 ?x)))
   	
%% 	  (<= (diagonal ?x)
%% 	   (true (cell 1 1 ?x))
%% 	   (true (cell 2 2 ?x))
%% 	   (true (cell 3 3 ?x)))
   	
%% 	  (<= (line ?x)
%% 	   (row ?m ?x))
   	
%% 	  (<= (line ?x)
%% 	   (diagonal ?x))
%% 	  (<= open
%% 	   (true (cell ?m ?n b)))
%% 	  )
   	
%% 	 (gddl
%% 	  (:derived (row ?m - row ?x - tok)
%% 	   (and (cell ?m c1 ?x)
%% 	    (cell ?m c2 ?x)
%% 	    (cell ?m c3 ?x)))
   	
%% 	  (:derived (diagonal ?x - tok)
%% 	   (and (cell r1 c1 ?x)
%% 	    (cell r2 c2 ?x)
%% 	    (cell r3 c3 ?x)))
   	
%% 	  (:derived (line ?x - tok)
%% 	   (exists (?m - row)
%% 	    (row ?m ?x)))
   	
%% 	  (:derived (line ?x - tok)
%% 	   (diagonal ?x))
   	
%% 	  (:derived (open)
%% 	   (exists (?m - row ?n - col)
%% 	    (cell ?m ?n b)))
%% 	  )
%% 	 )
   	
%% 	;; Figure 2: Encoding game domain axioms of TicTacToe in
%% 	;; GDL (left) and GDDL (right).
%% 	(pair
   	
%% 	 (gdl
%% 	  (<= (next (cell ?m ?n x))
%% 	   (does xplayer (mark ?m ?n))
%% 	   (true (cell ?m ?n b)))
%% 	  (<= (next (cell ?m ?n ?w))
%% 	   (true (cell ?m ?n ?w))
%% 	   (distinct ?w b))
%% 	  (<= (next (cell ?m ?n b))
%% 	   (does ?w (mark ?j ?k))
%% 	   (true (cell ?m ?n b))
%% 	   (or (distinct ?m ?j)
%% 	    (distinct ?n ?k)))
%% 	  (<= (next (control oplayer))
%% 	   (true (control xplayer)))
%% 	  (<= (legal ?w (mark ?x ?y))
%% 	   (true (cell ?x ?y b))
%% 	   (true (control ?w)))
%% 	  )
   	
%% 	 (gddl
%% 	  (:action mark
%% 	   :parameters
%% 	   (?player - role
%% 	    ?x - row ?y - col
%% 	    ?t - tok ?nplayer - role)
%% 	   :precondition
%% 	   (and
%% 	    (cell ?x ?y b)
%% 	    (control ?player)
%% 	    (= ?player xplayer)
%% 	    (= ?t x)
%% 	    (= ?nplayer oplayer)
%% 	    :effect
%% 	    (and
%% 	     (not (cell ?x ?y b))
%% 	     (cell ?x ?y ?t)
%% 	     (not (control ?player))
%% 	     (control ?nplayer)))))
%% 	 )

samplePDDL(domain(domain(flp,['negative-preconditions','conditional-effects',equality,typing,fluents,'durative-actions','derived-predicates'],[genls([person],intelligentAgent),genls([intelligentAgent,residence,vehicle,tool,container],object),genls([vehicle],container),genls([object,physicalLocation],thing),genls([residence],physicalLocation),genls([modeOfTransportation],category)],[autonomous(are(['$VAR'('A')],intelligentAgent)),location(are(['$VAR'('O')],object),are(['$VAR'('L')],physicalLocation)),contains(are(['$VAR'('C')],container),are(['$VAR'('O')],object)),mobile(are(['$VAR'('Ob')],object)),'directly-holding'(are(['$VAR'('A')],intelligentAgent),are(['$VAR'('O')],object))],[f('travel-distance',[are(['$VAR'('M')],modeOfTransportation),are(['$VAR'('L0'),'$VAR'('L1')],physicalLocation)]),f('travel-duration',[are(['$VAR'('M')],modeOfTransportation),are(['$VAR'('L0'),'$VAR'('L1')],physicalLocation)])],[durativeAction(travel,[are(['$VAR'('A')],intelligentAgent),are(['$VAR'('L0'),'$VAR'('L1')],physicalLocation)],'travel-duration'(walking,'$VAR'('L0'),'$VAR'('L1')),['over all'(autonomous('$VAR'('A'))),'at start'(location('$VAR'('A'),'$VAR'('L0')))],['at end'(not(location('$VAR'('A'),'$VAR'('L0')))),'at end'(location('$VAR'('A'),'$VAR'('L1')))]),durativeAction('pick-up',[are(['$VAR'('A')],intelligentAgent),are(['$VAR'('O')],object),are(['$VAR'('L')],physicalLocation)],0,['over all'(autonomous('$VAR'('A'))),'over all'(mobile('$VAR'('O'))),'at start'(not('directly-holding'('$VAR'('A'),'$VAR'('O')))),'at start'(location('$VAR'('A'),'$VAR'('L'))),'at start'(location('$VAR'('O'),'$VAR'('L')))],['at end'('directly-holding'('$VAR'('A'),'$VAR'('O')))]),durativeAction('set-down',[are(['$VAR'('A')],intelligentAgent),are(['$VAR'('O')],object),are(['$VAR'('L')],physicalLocation)],0,['over all'(autonomous('$VAR'('A'))),'over all'(mobile('$VAR'('O'))),'at start'('directly-holding'('$VAR'('A'),'$VAR'('O'))),'at start'(location('$VAR'('A'),'$VAR'('L')))],['at end'(location('$VAR'('O'),'$VAR'('L'))),'at end'(not('directly-holding'('$VAR'('A'),'$VAR'('O'))))]),durativeAction(carry,[are(['$VAR'('A')],intelligentAgent),are(['$VAR'('O')],object),are(['$VAR'('L0'),'$VAR'('L1')],physicalLocation)],'travel-duration'(walking,'$VAR'('L0'),'$VAR'('L1')),['over all'(autonomous('$VAR'('A'))),'over all'(mobile('$VAR'('O'))),'over all'('directly-holding'('$VAR'('A'),'$VAR'('O'))),'at start'(location('$VAR'('A'),'$VAR'('L0'))),'at start'(location('$VAR'('O'),'$VAR'('L0')))],['at end'(not(location('$VAR'('A'),'$VAR'('L0')))),'at end'(not(location('$VAR'('O'),'$VAR'('L0')))),'at end'(location('$VAR'('A'),'$VAR'('L1'))),'at end'(location('$VAR'('O'),'$VAR'('L1')))]),durativeAction('place-into',[are(['$VAR'('A')],intelligentAgent),are(['$VAR'('O')],object),are(['$VAR'('C')],container),are(['$VAR'('L')],physicalLocation)],0,['over all'(autonomous('$VAR'('A'))),'over all'(mobile('$VAR'('O'))),'at start'('directly-holding'('$VAR'('A'),'$VAR'('O'))),'at start'(location('$VAR'('A'),'$VAR'('L'))),'at start'(location('$VAR'('O'),'$VAR'('L'))),'at start'(location('$VAR'('C'),'$VAR'('L'))),'at start'(not(contains('$VAR'('C'),'$VAR'('O'))))],['at end'(contains('$VAR'('C'),'$VAR'('O'))),'at end'(not('directly-holding'('$VAR'('A'),'$VAR'('O'))))]),durativeAction(drive,[are(['$VAR'('A')],intelligentAgent),are(['$VAR'('V')],vehicle),are(['$VAR'('L0'),'$VAR'('L1')],physicalLocation)],'travel-duration'(driving,'$VAR'('L0'),'$VAR'('L1')),['over all'(autonomous('$VAR'('A'))),'over all'(mobile('$VAR'('V'))),'at start'(location('$VAR'('A'),'$VAR'('L0'))),'at start'(location('$VAR'('V'),'$VAR'('L0')))],['at end'(not(location('$VAR'('A'),'$VAR'('L0')))),'at end'(not(location('$VAR'('V'),'$VAR'('L0')))),'at end'(location('$VAR'('A'),'$VAR'('L1'))),'at end'(location('$VAR'('V'),'$VAR'('L1')))])]))).
samplePDDL(problem(problem(flp1,flp,
			   %% <REDACTED>
			   %% <REDACTED>
			   ['directly-holding'(meredithMcGhan,bluetoothKeyboard)]))).

