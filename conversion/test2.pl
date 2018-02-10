:- consult('/var/lib/myfrdcsa/codebases/minor/normal-form/frdcsa/sys/flp/autoload/').


run :-
	arguments(Arguments),
	argl(Arguments,domain,Domain),
	argl(Arguments,problem,Problem),
	argl(Arguments,solution,Solution),
	flp_convert_pl_to_pddl([domain(Domain),problem(Problem),solution(Solution)]),!.
