:- consult('/var/lib/myfrdcsa/codebases/minor/free-life-planner/lib/util/util.pl').
:- consult('/var/lib/myfrdcsa/codebases/minor/normal-form/conversion/flp-convert-pl-to-pddl.pl').
:- consult('/var/lib/myfrdcsa/codebases/minor/normal-form/conversion/pddl-sample.pl').

run :-
	arguments(Arguments),
	argl(Arguments,domain,Domain),
	argl(Arguments,problem,Problem),
	argl(Arguments,solution,Solution),
	flp_convert_pl_to_pddl([domain(Domain),problem(Problem),solution(Solution)]),!.
