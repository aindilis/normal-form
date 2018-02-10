#!/usr/bin/perl -w

# this is just a real crummy first version

use BOSS::Config;
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

my $c2 = read_file('/var/lib/myfrdcsa/codebases/minor/normal-form/conversion/classified.txt');
my $classified = {};
my $notclassified = {};
foreach my $line (split /\n/, $c2) {
  if ($line =~ /^#(\d+)\s+(.+)$/) {
    $classified->{$2} = $1;
  } elsif ($line =~ /^(\d+)\s+(.+)$/) {
    $notclassified->{$2} = $1;
  }
}

my $seen = {};
foreach my $sentence (@$sentences) {
  Release(Sentence => Clean(Sentence => $sentence))."\n";
}

if (0) {
  foreach my $key (sort {$seen->{$b} <=> $seen->{$a}} keys %$seen) {
    print $seen->{$key}."\t".$key."\n";
  }
}

sub Clean {
  my (%args) = @_;
  my $s = $args{Sentence};
  $s =~ s/[\n\r]+/ /sg;
  chomp $s;
  return $s;
}

sub Release {
  my (%args) = @_;
  my $s = $args{Sentence};
  my $tagged_text = $tagger->add_tags
    ( $s );
  my %nounphrases = $tagger->get_noun_phrases
    ($tagged_text);
  my $warning = 0;
  my $count = 0;
  my $offsets = [];
  foreach my $phrase (keys %nounphrases) {
    $seen->{$phrase} += $nounphrases{$phrase};
    if ($classified->{$phrase}) {
      $count++;
      $warning += $classified->{$phrase};
      my $s2 = $s;
      if ($s2 =~ /^(.*?)$phrase(.*)$/i) {
	push @$offsets, [length($1),length($1) + length($phrase),length($phrase)];
      }
    }
  }
  # print "<<<$s>>>\n";
  # print Dumper($offsets);
  my @chars = split //, $s;
  # print Dumper(\@chars);
  my $length = scalar @chars;
  # print $length."\n";

  my @intersperse = ();
  foreach my $i (0 .. $length) {
    push @intersperse, [];
  }
  my $j = 0;
  foreach my $offset (@$offsets) {
    push @{$intersperse[$offset->[0]]}, $j;
    push @{$intersperse[$offset->[1]]}, $j++;
  }
  my @reassemble = (scalar @{$intersperse[0]} ? '{'.join(',', sort @{$intersperse[0]}).'}' : '');
  foreach my $k (0 .. $length - 1) {
    push @reassemble, $chars[$k];

    push @reassemble, scalar @{$intersperse[$k + 1]} ? '{'.join(',', sort @{$intersperse[$k + 1]}).'}' : '';
  }
  my $output = join("", @reassemble);
  my $res = Parse
    (
     Count => $count,
     Warning => $warning,
     Sentence => $s,
     Offsets => $offsets,
     Output => $output,
    );
}

sub Parse {
  my (%args) = @_;
  my $preceding = ($args{Count} ? '#' : '').$warning;
  my $trailing = "";
  if ($args{Sentence} =~ /^"[^"]+" by "[^"]+"$/) {
    $trailing = "\n\n";
  } elsif ($args{Sentence} =~ /^Chapter \d+ - (.+?)$/) {
    $preceding = "\n\n\n$preceding";
    $trailing = "\n\n";
  } elsif ($args{Sentence} =~ /^Section \d+ - (.+?)$/) {
    $preceding = "\n\n$preceding";
    $trailing = "\n\n";
  } else {
    $trailing = "  ";
  }
  print $preceding.$args{Output}.$trailing;
}
