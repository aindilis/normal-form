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
  Release(Sentence => Clean(Sentence => $sentence))."\n";
}

foreach my $key (sort {$seen->{$b} <=> $seen->{$a}} keys %$seen) {
  print $seen->{$key}."\t".$key."\n";
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
  foreach my $phrase (keys %nounphrases) {
    $seen->{$phrase} += $nounphrases{$phrase};
  }
}

