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

my $seen = {};
foreach my $sentence (@$sentences) {
  Parse(Sentence => $sentence)."\n";
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
  print "$s\n";
  return $s;
}

