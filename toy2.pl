#!/usr/bin/perl -w

# FIXME: this seems to be related to the following:
# /var/lib/myfrdcsa/codebases/minor/homeless-at-cmu/scripts/process-plan.pl
# /usr/share/perl5/IEM2/Util/Updater.pm
# /usr/share/perl5/IEM/Util/Updater2.pm
# /usr/share/perl5/IEM/Util/Updater.pm

# FIXME: both of which seem to require fixing KBS2::ImportExport and
# doing the tests.

# FIXME: and this might be useful for integration Flora-2/Prolog/CycL with KBS2
# /var/lib/myfrdcsa/codebases/minor/suppositional-reasoner/scripts/convert-prolog-to-kbs.pl


# use FreeKBS2 to model the domain

use KBS2::Client;
use KBS2::ImportExport;
use KBS2::Util;
use PerlLib::SwissArmyKnife;

# use AI::Prolog;

my $context = "Org::FRDCSA::NormalForm::Toy2::Example1";
my $kbs2 = KBS2::Client->new
  (
   Name => "normal-form-toy-2",
   Context => $context,
  );
my $importexport = KBS2::ImportExport->new();
my $format = "Emacs String";

# go ahead and parse the file, then interpret it
# my $res = $importexport->Convert
#   (
#    Input => $content,
#    InputType => $format,
#    OutputType => "Interlingua",
#   );

# if ($res->{Success}) {
#   foreach my $assertion (@{$res->{Output}}) {
#     $kbs2->Send
#       (
#        Assert => [$assertion],
#        InputType => "Interlingua",
#        Context => $context,
#        QueryAgent => 1,
#        Flags => {
# 		 AssertWithoutCheckingConsistency => 1,
# 		},
#       );
#   }
# }

# # start with some basic tests
# my $tests =
#   [
#    ['("isa" "Andrew Dougherty" "Person")',1],
#   ];

# foreach my $test (@$tests) {
#   my $res = $kbs2->Send
#     (
#      Query => $test->[0],
#      InputType => "Emacs String",
#      Context => $context,
#      QueryAgent => 1,
#      Flags => {
# 	      },
#     );
#   print Dumper($res);
#   # Data Result TruthValue
# }

# now see if we can perform a given action

my $actiontobeperformed = "move";
# my $res = $kbs2->Send
#   (
#    Query => '(":action" "'.$actiontobeperformed.'" ?PRECONDITIONS ?EFFECTS)',
#    InputType => "Emacs String",
#    Context => $context,
#    QueryAgent => 1,
#    Flags => {
# 	    },
#   );
# print Dumper($res);

my $preconditions = '("and"
    ("isa" ?p "Person")
    ("isa" ?l1 "Location")
    ("isa" ?l2 "Location")
    ("connected-to" ?l1 ?l2)
    ("not" ("=" ?l1 ?l2))
    ("at" ?p ?l1)
  )';

# my $preconditions = '("isa" ?p "Person")';


# my $freevariables = FreeVariables(Formula => $preconditions);

# sub FreeVariables {
#   return '?p ?l1 ?l2';
#   return [
# 	  \*{'::?p'},
# 	  \*{'::?l1'},
# 	  \*{'::?l2'},
# 	 ];
# }

# my $query = '("exists" ('.$freevariables.') '.$preconditions .')';

my $query = $preconditions;

my $res = $kbs2->Send
  (
   Query => $query,
   InputType => "Emacs String",
   Context => $context,
   QueryAgent => 1,
   Flags => {
	    },
  );
print Dumper($res);

# foreach my $
# take initial state, see if it is consistent, query false
# }

