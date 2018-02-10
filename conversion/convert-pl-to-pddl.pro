%% :- dynamic 

%% replace like genls(a,b) with holds(genls(a,b)).  replace 'item'
%% with the('item') or a('item') as needed.

:- consult('output-partial').
:- consult('/var/lib/myfrdcsa/codebases/minor/pddl/src/pddl_wrapper.pl').

%% genls(X,Y). Types
%% heading(X,Y,Z).
%% in(X,Y).
%% isa(X,Y,in(Z)).
%% isa(X,Y,on(Z)).
%% isa(X,Y).
%% isXOf(X,above,Y).  Init, Y(X,Y).
%% isXOf(X,below,Y).  Init, Y(X,Y).
%% isXOf(X,D,Y).  Init, Y(X,Y).
%% matchingKey(X,Y).
%% notYetImplemented).
%% on(X,Y).
%% oneOf(X,'_prolog_list'(A,B)).
%% player(X).


lwrupr(Low, Upp) :- upcase_atom(Low, Upp).

first_char_uppercase(WordLC, WordUC) :-
    atom_chars(WordLC, [FirstChLow|LWordLC]),
    atom_chars(FirstLow, [FirstChLow]),
    lwrupr(FirstLow, FirstUpp),
    atom_chars(FirstUpp, [FirstChUpp]),
    atom_chars(WordUC, [FirstChUpp|LWordLC]).


fix_isa(Type,NL) :-
	atom_concat('t',NL,Type).


% Domain Predicates

domainName(DomainName) :-
	storyBy(Story,Author),
	% do something here to get rid of spaces
	atom_list_concat([Story,'-',Author],DomainName).

requirements(Requirements) :-
	Requirements = [':typing', ':conditional-effects', ':disjunctive-preconditions', ':durative-actions', ':equality', ':fluents', ':derived-predicates', ':negative-preconditions'].

types(Types) :-
	genls(SubType,SuperType),
	%% add SubType to the list of subtypes of supertype SuperType,
	%% then enumerate this list of subtypes followed by a '-' and
	%% then the SuperType.

predicates(Predicates) :-
	.

functions(Functions) :-
	% hasXCalled(ItemType,PartType,FunctionName)
	% FunctionName(ItemTypeList,
	.

derived(Derived) :-
	.

durativeActions(DurativeActions) :-
	.

% Problem Functions

problemName(ProblemName) :-
	.

domainName(DomainName) :-
	.

objects(Objects) :-
	isa(Instance,Type).
	%% add Instance to the list of instances of type Type,
	%% then enumerate this list of instances followed by a '-' and
	%% then the Type.

init(Init) :-
	.

goal(Goal) :-
	.

metric(Metric) :-
	.

%% INCORPORATE heading namespaces

output(domain) :-
	domainName(DomainName),
	requirements(Requirements),
	types(Types),
	predicates(Predicates),
	functions(Functions),
	derived(Derived),
	durativeActions(DurativeActions),

	Atom = pddl_domain(define
	(
	 domain(DomainName),
	 ':requirements'(Requirements),
	 ':types'(Types),
	 ':predicates'(Predicates),
	 ':functions'(Functions),
	 Derived,
	 DurativeActions,
	 )),
	
	atom_to_string(Atom,String),
	write(String),nl.

output(problem) :-
	problemName(ProblemName),
	domainName(DomainName),
	objects(Objects),
	init(Init),
	goal(Goal),
	metric(Metric),

	Atom = pddl_problem(define
	(
	 problem(ProblemName),
	 ':domain'(DomainName),
	 ':objects'(Objects),
	 ':init'(Init),
	 ':goal'(Goal),
	 ':metric'(Metric),
	)),

	atom_to_string(Atom,String),
	write(String),nl.

do_conversion :-
	output(domain),
	output(problem).

:- do_conversion.

