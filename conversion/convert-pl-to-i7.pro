%% replace like genls(a,b) with holds(genls(a,b)).  replace 'item'
%% with the('item') or a('item') as needed.

:- consult('output-partial').

convert_pl_to_i7(genls(X,Y)) :-
	atomic_list_concat(['A ',X,' is a kind of ',Y,'.'], '', Result),
	write(Result),nl.

convert_pl_to_i7(heading(X,Y,Z)) :-
	first_char_uppercase(X,X1),
	atomic_list_concat([X1,' ',Y,' - ',Z,'.'], '', Result),
	write(Result),nl.

lwrupr(Low, Upp) :- upcase_atom(Low, Upp).

first_char_uppercase(WordLC, WordUC) :-
    atom_chars(WordLC, [FirstChLow|LWordLC]),
    atom_chars(FirstLow, [FirstChLow]),
    lwrupr(FirstLow, FirstUpp),
    atom_chars(FirstUpp, [FirstChUpp]),
    atom_chars(WordUC, [FirstChUpp|LWordLC]).

convert_pl_to_i7(in(X,Y)) :-
	atomic_list_concat(['The ',X,' is in the ',Y,'.'], '', Result),
	write(Result),nl.

convert_pl_to_i7(isa(X,Y,in(Z))) :-
	fix_isa(Y,Y1),
	atomic_list_concat(['The ',X,' is a ',Y1,' in the ',Z,'.'], '', Result),
	write(Result),nl.
convert_pl_to_i7(isa(X,Y,on(Z))) :-
	fix_isa(Y,Y1),
	atomic_list_concat(['The ',X,' is a ',Y1,' on the ',Z,'.'], '', Result),
	write(Result),nl.
convert_pl_to_i7(isa(X,Y)) :-
	fix_isa(Y,Y1),
	atomic_list_concat(['The ',X,' is a ',Y1,'.'], '', Result),
	write(Result),nl.

fix_isa(Type,NL) :-
	atom_concat('t',NL,Type).

convert_pl_to_i7(isXOf(X,above,Y)) :-
	atomic_list_concat(['The ',X,' is ',above,' the ',Y,'.'], '', Result),
	write(Result),nl.
convert_pl_to_i7(isXOf(X,below,Y)) :-
	atomic_list_concat(['The ',X,' is ',below,' the ',Y,'.'], '', Result),
	write(Result),nl.
convert_pl_to_i7(isXOf(X,D,Y)) :-
	not(D = above),
	not(D = below),
	atomic_list_concat(['The ',X,' is ',D,' of the ',Y,'.'], '', Result),
	write(Result),nl.

convert_pl_to_i7(matchingKey(X,Y)) :-
	atomic_list_concat(['The matching key of the ',X,' is the ',Y,'.'], '', Result),
	write(Result),nl.

convert_pl_to_i7(notYetImplemented).
	
convert_pl_to_i7(on(X,Y)) :-
	atomic_list_concat(['The ',X,' is on the ',Y,'.'], '', Result),
	write(Result),nl.

convert_pl_to_i7(oneOf(X,'_prolog_list'(A,B))) :-
	atomic_list_concat(['A ',X,' can be ',A,' or ',B,'.'], '', Result),
	write(Result),nl.

convert_pl_to_i7(player(X)) :-
	atomic_list_concat(['The player is ',X,'.'], '', Result),
	write(Result),nl.

do_conversion :-
	holds(X),
	convert_pl_to_i7(X),
	fail.
do_conversion.

:- do_conversion.

