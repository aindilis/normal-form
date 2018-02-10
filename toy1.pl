#!/usr/bin/perl -w


# two actions

write(?X),?X[writtenIn -> Perl]:Planner.

read(?Y),?Y[about -> inform]:Manual.

# suppose we write the planner

     # then what is the situation

     # well I suppose we start writing the planner

     # however, this action might fail

     # what do we do if it fails

     # what do we do if it succeeds

     #  if it succeeds, then we have started to write the planner

     #     what effects does this have?  lots of small effects, difficult to quantify, but progress can proceed.  This is a difficult goal, so there is a lot to it.

     #     we could get distracted from our goal, we could become bored with it, something might arise which prevents it from happening,

     #     at this point we are committed to maintaining this goal

     #        however, something might transpire which forces us to abandon it.  Say it becomes more profitable to do something else - due to some exogenous event.

     #        do we maintain lists of conditions that are valid contract termination events, in which we could give up the goal.  what about unknown conditions
     #           therefore do we maintain a sensor sweep, or anticipate follow particular signs that would indicate the world has changed

     # this is the beginning of a durative action.  we must have more
     # detailed semantics for durative actions - specifically their
     # starting conditions, termination conditions, etc.  For
     # instance, we could model it as action start_writing_planner.
     # It could have conditions which must be true for it to work,
     # although these might be defeasible.


     # it seems intuitively there are range of actions which would
     # prevent us from working on the planner.  modeling them all
     # would take a lot of world knowledge.

     # remember the anticipation of the car hitting the building.  can
     # use probabilistic information to make inferences.  Note the
     # incompleteness of that though, as in the case Dad disagreed
     # with AI for various reasons.

     # need process models for lots of different actions.  need to be
     # able to anticipate what are likely conditions for being able to
     # write them.  Note how violations of these conditions is typical
     # as the rules are not expressive enough to model the variety of
     # other possibilities.  Such as rules on NLU which are too
     # general or miss certain senses.


# I can read inform model.

# task becomes too difficult - use our data mining to suggest things
# that happen in situations like this.  for instance, fates of tasks.
# Use NLP to get that.

# Maybe we can be more specific write first part of planner by such
# and such time.  Then if this is violated, we have an appropriate
# response.

# Remember things that Paul mentioned about things like debugging -
# it's not possible to provide an estimate ahead of time until the
# problem is solved, and then it is solved.  Deal with actions in this
# category.

# try simplifying this a bit, either we get it done or we don't.  If
# we don't, what is our move then.  Don't try to stretch everything
# out ahead of time, i.e. be super efficient, accept losses due to
# lack of model and proceed to come up with a plan anyway which is
# sufficient to ultimately achieve the desired outcome.

try(write(perlplanner)):
     if (fail(write(perlplanner))) {
       try(read(inform(manual)))
     }
}

try(read(inform(manual))):
      if (fail (read(inform(manual)))) {
	retry(write(perlplanner))
	  or
	    
      }
    }

# it seems like this is an awful lot like the development of
# character.

# there will be other goals asking to be achieved (most likely I
# guess).  So if these fail then there are other concerns.


# note that there are better performing algorithms than others.

# what would be nice is the ability to think out the consequences of a
# given situation in detail - however, the system must keep tabs on
# when such thinking is appropriate, by planning it's own planning
# process.

# remember Todd Freitag's analysis paralysis.  Need to inventory
# concepts such as these and try to proof our algorithms against such
# problems.

# develop mechanism to plan out daily activities.

# develop basic mechanism which is binary - only concerns success or
# failure.  Plan out different actions to get through the day - add
# the execution engine.  so for instance, all the things I need to do.
# Eat, sleep, bathroom, work, etc.  Look to our existing domains for
# inspiration.
