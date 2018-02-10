:- use_module(library(lists)).

:- consult('/var/lib/myfrdcsa/codebases/minor/pddl/src/pddl_wrapper.pl').
:- consult('/var/lib/myfrdcsa/codebases/minor/interactive-execution-monitor/frdcsa/sys/flp/autoload/args.pl').

flp_convert_pl_to_pddl(Arguments) :-
	argt(Arguments,[domain(Domain),problem(Problem),solution(Solution),results(Results)]),
	output(domain(Domain),DomainResults),
	output(problem(Problem),ProblemResults),
	output(solution(Solution),SolutionResults),
	Results = [domainResults(DomainResults),problemResults(ProblemResults),solution(Solution,SolutionResults)],
	Arguments = [domain(Domain),problem(Problem),solution(Solution),results(Results)].

output(domain(Domain),DomainResults) :-
	Domain = domain(DomainName,TmpRequirements,TmpTypes,TmpPredicates,TmpFunctions,TmpActions),
	view([1]),
	Derived = [],

	findall(Requirement,(member(TmpRequirement,TmpRequirements),atom_concat(':',TmpRequirement,Requirement)),Tmp2Requirements),
	append([[':requirements'],Tmp2Requirements],Requirements),
	view([requirements,Requirements]),

	view([tmpTypes,TmpTypes]),
	setof([SubTypes,['-'],[SuperType]],member(genls(SubTypes,SuperType),TmpTypes),Tmp2Types),
	append(Tmp2Types,Tmp3Types),
	append(Tmp3Types,Tmp4Types),
	append([[':types'],Tmp4Types],Types),
	view([types,Types]),

	fixPredicates(TmpPredicates,Tmp2Predicates),
	append([[':predicates'],Tmp2Predicates],Predicates),
	view([predicates,Predicates]),

	view([tmpFunctions,TmpFunctions]),
	fixFunctions(TmpFunctions,Tmp2Functions),
	append([[':functions'],Tmp2Functions],Functions),
	view([functions,Functions]),

	TmpArgumentList = [domain(DomainName),Requirements,Types,Predicates,Functions],
	fixActions(TmpActions,Actions),
	append([TmpArgumentList,Derived,Actions],ArgumentList),
	view([argumentList,ArgumentList]),
	
	append([[define],ArgumentList],PDDLDomain),
	Atom = pddl_domain(PDDLDomain),

	convert_pl_to_pddl([input(PDDLDomain),inputType('Prolog'),outputType('KIF String'),results(DomainResults)]),
	displayResults(DomainResults).

fixPredicates(TmpPredicates,Predicates) :-
	findall(Predicate,
		(
		 member(TmpPredicate,TmpPredicates),
		 view([tmpPredicate,TmpPredicate]),
		 TmpPredicate =.. [PredicateName|AllTypeSpecs],
		 view([predicateName,PredicateName]),
		 view([allTypeSpecs,AllTypeSpecs]),
		 findall(Output,
			 (
			  member(are(Variables,Type),AllTypeSpecs),
			  view([type,Type,typeSpecs,Variables]),
			  findall(NewVariableName,
				  (   
				      member('$VAR'(VariableName),Variables),
				      atom_concat('?',VariableName,NewVariableName)
				  ),
				  NewVariableNames),
			  append([NewVariableNames,[-],[Type]],Output)
			 ),
			 TmpOutputs),
		 append(TmpOutputs,Outputs),
		 append([[PredicateName],Outputs],Predicate)
		),
		Predicates),
	view([predicates,Predicates]).

fixFunctions(TmpFunctions,Functions) :-
	findall(Function,
		(
		 member(TmpFunction,TmpFunctions),
		 view([tmpFunction,TmpFunction]),
		 TmpFunction =.. [f|[FunctionName|[AllTypeSpecs]]],
		 view([functionName,FunctionName]),
		 view([allTypeSpecs,AllTypeSpecs]),
		 findall(Output,
			 (
			  member(are(Variables,Type),AllTypeSpecs),
			  view([type,Type,typeSpecs,Variables]),
			  findall(NewVariableName,
				  (   
				      member('$VAR'(VariableName),Variables),
				      atom_concat('?',VariableName,NewVariableName)
				  ),
				  NewVariableNames),
			  append([NewVariableNames,[-],[Type]],Output)
			 ),
			 TmpOutputs),
		 view([tmpOutputs,TmpOutputs]),
		 append(TmpOutputs,Outputs),
		 view([outputs,Outputs]),
		 append([[FunctionName],Outputs],Function)
		),
		Functions),
	view([functions,Functions]).

fixActions(TmpActions,Actions) :-
	findall(Action,
		(
		 member(TmpAction,TmpActions),
		 view([tmpAction,TmpAction]),
		 TmpAction =.. [durativeAction|[ActionName|[AllTypeSpecs,TmpDuration,TmpPreconditions,TmpEffects]]],
		 view([actionName,ActionName,variables,AllTypeSpecs,duration,TmpDuration,preconditions,TmpPreconditions,effects,TmpEffects]),
		 findall(Parameter,
			 (
			  member(are(Variables,Type),AllTypeSpecs),
			  view([type,Type,variables,Variables]),
			  findall(NewVariableName,
				  (   
				      member('$VAR'(VariableName),Variables),
				      atom_concat('?',VariableName,NewVariableName)
				  ),
				  NewVariableNames),
			  append([NewVariableNames,[-],[Type]],Parameter)
			 ),
			 TmpParameters),
		 append(TmpParameters,Parameters),
		 renderVariables(TmpDuration,Duration),
		 append([['and'],TmpPreconditions],Tmp2Preconditions),
		 renderVariables(Tmp2Preconditions,Preconditions),
		 append([['and'],TmpEffects],Tmp2Effects),
		 renderVariables(Tmp2Effects,Effects),
		 Action = ':durative-action'(ActionName,':parameters',Parameters,':duration',['=','?duration',Duration],':condition',Preconditions,':effect',Effects)
		),
		Actions),
	view([actions,Actions]).

output(problem(Problem),ProblemResults) :-
	Problem = problem(ProblemName,ProblemDomainName,TmpObjects,TmpInit,TmpGoal),
	view([problemItems,[ProblemName,ProblemDomainName,TmpObjects,TmpInit,TmpGoal]]),

	view([tmpObjects,TmpObjects]),
	append([[':objects'],TmpObjects],Objects),
	view([objects,Objects]),

	view([tmpInit,TmpInit]),
	append([[':init'],TmpInit],Init),
	view([init,Init]),

	view([tmpGoal,TmpGoal]),
	append([[and],TmpGoal],Tmp2Goal),
	append([[':goal'],[Tmp2Goal]],Goal),
	view([goal,Goal]),

	Metric = ':metric'(minimize,'total-time'()),
	view([metric,Metric]),

	PDDLProblem = define(
			     problem(ProblemName),
			     ':domain'(ProblemDomainName),
			     Objects,
			     Init,
			     Goal,
			     Metric
			    ),
	Atom = pddl_problem(PDDLProblem),
	convert_pl_to_pddl([input(PDDLProblem),inputType('Prolog'),outputType('KIF String'),results(ProblemResults)]),
	displayResults(ProblemResults).

output(solution(Solution),SolutionResults) :-
	Atom = pddl_solution(Solution),
	view([input(Solution),inputType('Prolog'),outputType('KIF String'),results(SolutionResults)]),
	(   nonvar(Solution) -> convert_pl_to_pddl([input(Solution),inputType('Prolog'),outputType('KIF String'),results(SolutionResults)]) ; true),
	displayResults(SolutionResults).

convert_pl_to_pddl(Arguments) :-	
	%% kbs2_import_export(Arguments),
	prolog_to_pddl_pretty_print(Arguments),
	true.

prolog_to_pddl_pretty_print([input(Input),inputType(InputType),outputType(OutputType),results(Results)]) :-
	%% Generate it and if we have a connection to formalog use it,
	%% otherwise, write it to a file, and get the output.
	InputFile = '/tmp/kbs2-import-export-input.txt',
	OutputFile = '/tmp/kbs2-import-export-output.txt',
	writeq_data_to_file(Input,InputFile),
	atomic_list_concat([
			    '/var/lib/myfrdcsa/codebases/minor/normal-form/conversion/prolog-to-pddl-pretty-print -i \'',
			    InputType,
			    '\' -o \'',
			    OutputType,
			    '\' -f \'',
			    InputFile,'\' > ',
			    OutputFile
			   ],'',Command),
	shell(Command),
	read_data_from_file(OutputFile,Results).

displayResults(Results) :-
	%% view([atom,Results]),
	nl,nl,
	write(Results),
	nl,nl,
	true.

renderVariables(Pre,Post) :-
	view([pre,Pre]),
	is_list(Pre) ->
	findall(Item,(member(SubPre,Pre),renderVariables(SubPre,Item)),Post) ;
	Pre =.. ['$VAR',VariableName] ->
	atom_concat('?',VariableName,Post) ;
	Pre =.. [PredicateName|Args] ->	
	(   
	    findall(Item,(member(SubArgs,Args),renderVariables(SubArgs,Item)),Items),
	    Post =.. [PredicateName|Items]
	) ;
	Post = Pre.
