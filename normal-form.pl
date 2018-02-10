#!/usr/bin/perl -w

use PerlLib::SwissArmyKnife;

# okay, have to get the initial situation
my $initial_situation = read_file('initial-sit.kbs');

# all the facts about the house

# the domains for possible actions


# now run the planning process

# for each granularity

	# what are the goals states?

	# push a given move onto the stack

	# run the execution-engine Flora-2 rules

	# evaluate the position, derive facts about the position - positional theorem proving

	# recursively enter the position

	# follow to a prescribed depth - or even better, try some analogue to minimax or a-b pruning

# end for each

# now look to see what changes exist in the world, as measured through
# sensors

# 

