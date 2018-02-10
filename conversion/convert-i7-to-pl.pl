#!/usr/bin/perl -w

# this is just a real crummy first version

use BOSS::Config;
use KBS2::ImportExport;
use PerlLib::SwissArmyKnife;
use Capability::TextAnalysis;

use Lingua::EN::Sentence qw(get_sentences);

$specification = q(
	-i <filename>		story.ni to process
	-o <filename>		prolog outfile
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
my $fh = IO::File->new();

$fh->open('>'.$conf->{'-o'}) or die "cannot open out file:".$conf->{'-o'}."\n";

my $c = read_file($inputfile);

my $importexport = KBS2::ImportExport->new();

my $sentences = get_sentences($c);
foreach my $s (@$sentences) {
  my $res1 = Parse(Sentence => $s);
  if ($res1->{Success}) {
    my $res2 = $importexport->Convert
      (
       Input => [['holds',$res1->{Interlingua}[0]]],
       InputType => 'Interlingua',
       OutputType => 'Prolog',
      );
    if ($res2->{Success}) {
      print $fh $res2->{Output};
    }
  }

  # my $res1 = $importexport->Convert
  #   (
  #    Input => $c,
  #    InputType => 'Prolog',
  #    OutputType => 'Interlingua',
  #   );
  # print Dumper($res1);
  # die;

}

sub Clean {
  my (%args) = @_;
  my $s = $args{Sentence};
  $s =~ s/[\n\r]+/ /sg;
  chomp $s;
  return $s;
}

my $noun;
my $second;

sub Parse {
  my (%args) = @_;
  my $original = $args{Sentence};
  my $s = Clean(Sentence => $original);
  if ($s =~ /^An? (.+?) is a kind of (.+?).$/) {
    $noun = $1;
    $secondnoun = $2;
    return {
	    Success => 1,
	    Interlingua => [['genls',Typify($noun),Typify($secondnoun)]],
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
  } elsif ($s =~ /^(The |An? )?(.+?) is an? (.+?)((in|on) the (.+?))?.$/) {
    my $noun = $2;
    my $secondnoun = $3;
    my $pred = $5;
    my $obj = $6;
    my $interlingua = ['isa',$noun,Typify($secondnoun)];
    if ($pred) {
      push @$interlingua, [$pred,$obj];
    }
    return {
  	    Success => 1,
  	    Interlingua => [$interlingua],
  	   };
  } elsif ($s =~ /^((The |An? )(.+?)|It) is (north|south|east|west|northeast|northwest|southeast|southwest|above)( of)? the (.+?)[,.]/) {
    my $tmp = $3;
    if ($tmp) {
      $noun = $tmp;
    }
    $secondnoun = $6;
    return {
  	    Success => 1,
  	    Interlingua => [['isXOf',$noun,$4,$secondnoun]],
  	   };
  } elsif ($s =~ /^((The |An? )?(.+?)|It) is (in|on)( the)? (.+?).$/) {
    my $tmp = $3;
    if ($tmp) {
      $noun = $tmp;
    }
    return {
  	    Success => 1,
  	    Interlingua => [[$3,$noun,$5]],
  	   };
  } elsif ($s =~ /^(Understand|Before|Report|Instead of|Carry out|After|Setting|Every turn)/) {
    return {
  	    Success => 1,
  	    Interlingua => [['notYetImplemented']],
  	   };
  } elsif ($s =~ /^(The |An? )(.+?) can be (.+?) or (.+?).$/) {
    $noun = $2;
    return {
  	    Success => 1,
  	    Interlingua => [['oneOf',$noun,['_prolog_list',$3,$4]]],
  	   };
  } elsif ($s =~ /^The player is (.+?).$/) {
    $noun = $1;
    return {
  	    Success => 1,
  	    Interlingua => [['player',$noun]],
  	   };
  } elsif ($s =~ /^The matching key of the (.+?) is the (.+?).$/) {
    $noun = $1;
    return {
  	    Success => 1,
  	    Interlingua => [['matchingKey',$noun,$2]],
  	   };
  } elsif ($s =~ /^((The |An? )?(.+?)|It) is part of (the )?(.+?).$/) {
    my $tmp = $3;
    if ($tmp) {
      $noun = $tmp;
    }
    return {
  	    Success => 1,
  	    Interlingua => [['isPartOf',$noun,$5]],
  	   };
  } elsif ($s =~ /^((The |An? )?(.+?)|It) has (a |the )?(.+?) called (a |the )?(.+?).$/) {
    # A clock has a time called the current time.
    my $tmp = $3;
    if ($tmp) {
      $noun = $tmp;
    }
    return {
  	    Success => 1,
  	    Interlingua => [['hasXCalled',Typify($noun),Typify($5),$7]],
  	   };
  } elsif ($s =~ /^(The |An? )?(.+?) of (a |the )?(.+?) is( (usually)?)? (a |the )?(.+?).$/) {
    # The current time of a clock is usually 9:01 AM.
    $noun = $2;
    my $usually = $6 ? 'Usually' : '';
    return {
  	    Success => 1,
  	    Interlingua => [['is'.$usually,$noun,Typify($4),$8]],
  	   };
  } elsif ($s =~ /^"(.+?)" by "(.+?)"$/) {
    # The current time of a clock is usually 9:01 AM.
    return {
  	    Success => 1,
  	    Interlingua => [['storyBy',$1,$2]],
  	   };
  } elsif ($s =~ /^Include (.+?) by (.+?).$/) {
    # The current time of a clock is usually 9:01 AM.
    return {
  	    Success => 1,
  	    Interlingua => [['include',$1,$2]],
  	   };
  } elsif ($s =~ /^(.+?) are kinds of (.+?).$/) {
    #A computer, a computer peripheral, a monitor and a KVM are kinds of devices.
    my $items = $1;
    my $tmp1 = Typify(Depluralize($2));
    my @items;

    foreach my $item (split /(, | and )/,$items) {
      next if ($item eq ', ' or $item eq ' and ');
      # print "<I:$item>\n";
      if ($item =~ /^((a|the) )?(.+?)$/i) {
	my $tmp2 = $2;
	my $type = Typify($3);
	# print "<T:$type>\n";
	if ($tmp2) {
	  push @items, [$tmp2,$type];
	} else {
	  push @items, $type;
	}
      }
    }
    unshift @items, '_prolog_list';
    return {
  	    Success => 1,
  	    Interlingua => [['isaItems',\@items,$tmp1]],
  	   };
  } else {
    print "<$s>\n";
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

sub Depluralize {
  # FIXME: implement this function
  return $_;
}
