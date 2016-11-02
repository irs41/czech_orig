use strict;
use warnings;
use open qw/:std :utf8/;
use autodie;
use utf8;

# CHANGELOG
# v0.1, 5/18/16, Pavel Jurca
#   — diff macro names

# TODO
# will be discussed in a next meeting


### ============== MAIN =============
unless (@ARGV == 2) {
  #grep /--help|-h|\/\?/, @ARGV
  print <<'EOL';
NAME
    diff_macros.pl - compare two DM files

USAGE
    diff_macros.pl FILE1.dm FILE2.dm

DESCRIPTION
    Check upon macro names between the two DM files

EOL
exit 2;
}


my $col = 40; # column width
my $file1 = shift;
my $file2 = shift;

print
  # heading
  sprintf(
    "%${col}s || %${col}s\n\n", $file1, $file2
  ),
  # diff
  diff_macro_names(
    get_macro_names($file1),
    get_macro_names($file2)
);
### ============ END ================



=head2 get_macro_names

Get macro names from the given DM file

=cut

sub get_macro_names {
  my $file = shift;
  die qq/(!) file "$file" doesn't exist\n/
    unless -e $file;

  open my $in, '<:utf8', $file;
  
  my @grep;
  push @grep, (/^_([^_]+)_/ ? $1 : '') while <$in>;
  
  close $in;

  # matched macro names keeping the lines between
  return \@grep;
}

=head2 diff_macro_names

Tell which macro names don't compare

=cut

sub diff_macro_names {
  return -1 unless @_ == 2;

  my @macros1 = @$_[0];
  my @macros2 = @$_[1];

  FILE_1:
  for my $m1 (@macros1) {
    next FILE_1 unless $m1;
    
    FILE_2:
    for my $m2 (@macros2) {
      next FILE_2 unless $m2;
      
      if ($m1 eq $m2) {
        $m1 = '';
        $m2 = '';
        
        next FILE_1;
      }
    }
  }

  my @diff = map {
    $macros1[$_] ? sprintf "%s: %${col}s", $_, $macros1[$_-1] : ()
  } 1..@macros1;

  for (1..@diff) {
    $diff[$_-1] .= "$_: " . $macros2[$_-1] if $macros2[$_];
  }

  #if @diff < @macros2 ...

  return join "\n", grep !/^$/, @diff;
}
