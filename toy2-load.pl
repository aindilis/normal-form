#!/usr/bin/perl -w

# use FreeKBS2 to model the domain

use KBS2::Client;
use KBS2::ImportExport;
use KBS2::Util;
use PerlLib::SwissArmyKnife;

# use AI::Prolog;

my $content =<<EOF10;
("=>" ("genls" ?X ?Y) ("forall" (?Z) ("and" ("isa" ?X ?Z) ("isa" ?Y ?Z))))
("genls" "Location" "Thing")
("genls" "Room" "Location")
("genls" "Person" "Thing")
(":action" "move"
  ("and"
    ("isa" ?p "Person")
    ("isa" ?l1 "Location")
    ("isa" ?l2 "Location")
    ("connected-to" ?l1 ?l2)
    ("not" ("=" ?l1 ?l2))
    ("at" ?p ?l1)
  )
  ("and"
    ("not" ("at" ?p ?l1))
    ("at" ?p ?l2)
  )
)
("isa" "Andrew Dougherty" "Person")
("isa" "Computer room" "Room")
("isa" "Downstairs entryway" "Room")
("at" "Andrew Dougherty" "Computer room")
("connected-to" "Computer room" "Downstairs entryway")
("connected-to" "Downstairs entryway" "Computer room")
EOF10

my $context = "Org::FRDCSA::NormalForm::Toy2::Example1";
my $kbs2 = KBS2::Client->new
  (
   Name => "normal-form-toy-2",
   Context => $context,
  );
my $importexport = KBS2::ImportExport->new();
my $guess = KBS2::ImportExport::Guess->new
  (
   ImportExport => $importexport,
  );

# clear the context
$kbs2->ClearContext();

my $format = "Emacs String";

# go ahead and parse the file, then interpret it
my $res = $importexport->Convert
  (
   Input => $content,
   InputType => $format,
   OutputType => "Interlingua",
  );

if ($res->{Success}) {
  foreach my $assertion (@{$res->{Output}}) {
    $kbs2->Send
      (
       Assert => [$assertion],
       InputType => "Interlingua",
       Context => $context,
       QueryAgent => 1,
       Flags => {
		 AssertWithoutCheckingConsistency => 1,
		},
      );
  }
}

print "Done\n";

# foreach my $
# take initial state, see if it is consistent, query false
# }



# # possible actions must be planned for, all actions can fail for violation of some of their preconditions

# my $database = <<'END_PROLOG';
# append([], X, X).
# append([W|X],Y,[W|Z]) :- append(X,Y,Z).
# END_PROLOG

# my $prolog = AI::Prolog->new($database);

# my $list   = $prolog->list(qw/a b c d/);
# $prolog->query("append(X,Y,[$list]).");
# while (my $result = $prolog->results) {
#   print Dumper $result;
# }
