#!/usr/bin/perl -w

# this is just a real crummy first version

use BOSS::Config;
use KBS2::ImportExport;
use PerlLib::SwissArmyKnife;
use Capability::TextAnalysis;

use Lingua::EN::Sentence qw(get_sentences);

$specification = q(
	-i <filename>		story.ni to process
);

my $config =
  BOSS::Config->new
  (Spec => $specification);
my $conf = $config->CLIConfig;

if (! exists $conf->{'-i'}) {
  die "The -i arg is required\n";
} elsif (! -f $conf->{'-i'}) {
  die "The file cannot be found\n";
}

my $inputfile = $conf->{'-i'};

my $c = read_file($inputfile);

my $sentences = get_sentences($c);

my $tagger = Lingua::EN::Tagger->new;

my $importexport = KBS2::ImportExport->new();


my $seen = {};
foreach my $sentence (@$sentences) {
  my $res1 = Parse(Sentence => $sentence);
  if ($res1->{Success}) {
    my $res2 = $importexport->Convert
      (
       Input => $res1->{Interlingua},
       InputType => 'Interlingua',
       OutputType => 'Prolog',
      );
    if ($res2->{Success}) {
      print $res2->{Output};
    }
  }
}

sub Clean {
  my (%args) = @_;
  my $s = $args{Sentence};
  $s =~ s/[\n\r]+/ /sg;
  chomp $s;
  return $s;
}

sub Parse {
  my (%args) = @_;
  my $original = $args{Sentence};
  my $s = Clean(Sentence => $original);
  if ($s =~ /^An? (.+?) is a kind of (.+?).$/) {
    my $first = $1;
    my $second = $2;
    return {
	    Success => 1,
	    Interlingua => [['genls',Typify($first),Typify($second)]],
	   };
  } elsif ($s =~ /^\[/) {
    return {
	    Success => 1,
	    Interlingua => [['comment']],
	   };
  } elsif ($s =~ /^(Volume|Book|Chapter|Section) (\d+) - (.+?)$/) {
    return {
	    Success => 1,
	    Interlingua => [['heading',lc($1),$2,$3]],
	   };
  } elsif ($s =~ /^(The )?(.+?) is an? (.+?)((in|on) the (.+?))?.$/) {
    my $first = $2;
    my $second = $3;
    my $pred = $5;
    my $obj = $6;
    my $interlingua = ['isa',$first,Typify($second)];
    if ($pred) {
      push @$interlingua, [$pred,$obj];
    }
    return {
  	    Success => 1,
  	    Interlingua => [$interlingua],
  	   };
  } elsif ($s =~ /^The (.+?) is (north|south|east|west|northeast|northwest|southeast|southwest|above)( of)? the (.+?)[,.]/) {
    return {
  	    Success => 1,
  	    Interlingua => [['isXOf',$1,$2,$4]],
  	   };
  } elsif ($s =~ /^(The )?(.+?) is (in|on)( the)? (.+?).$/) {
    return {
  	    Success => 1,
  	    Interlingua => [[$3,$2,$5]],
  	   };
  } elsif ($s =~ /^(Understand|Before|Report|Instead of|Carry out|After|Setting|Every turn)/) {
    return {
  	    Success => 1,
  	    Interlingua => [['notYetImplemented']],
  	   };
  } elsif ($s =~ /^A (.+?) can be (.+?) or (.+?).$/) {
    return {
  	    Success => 1,
  	    Interlingua => [['oneOf',$1,['_prolog_list',$2,$3]]],
  	   };
  } elsif ($s =~ /^The player is (.+?).$/) {
    return {
  	    Success => 1,
  	    Interlingua => [['player',$1]],
  	   };
  } elsif ($s =~ /^The matching key of the (.+?) is the (.+?).$/) {
    return {
  	    Success => 1,
  	    Interlingua => [['matchingKey',$1,$2]],
  	   };
  } else {
    # print "<$s>\n";
  }
}

sub Capitalize {
  s/^(.)(.+?)$/uc($1).$2/e;
  $_;
}

sub Typify {
  my $item = shift;
  return 't'.join('',map {Capitalize($_)} split /\s+/, $item);
};
