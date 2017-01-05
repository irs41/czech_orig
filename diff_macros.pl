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
  # grep /--help|-h|\/\?/, @ARGV
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


my $col = 60; # column width
my $file1 = shift;
my $file2 = shift;

# diff options
my $diff = {
  macro_name => qr|^_([^_]+)_|,
  macro_name_lang => qr|^_[^_]+_ \[l=(.{2})\]|,
};

print
  # heading
  sprintf(
    "%-${col}s%s\n\n%s\n\n", $file1, $file2, "=" x ($col*2)
  ),
  # diff
  diff_macro_names(
    get_macro_names($file1),
    get_macro_names($file2)
), "\n";
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
  push @grep, (/$diff->{macro_name}/ ? $1 : '') while <$in>;
  # push @grep, (/$diff->{macro_name_lang}/ ? $1 : '') while <$in>;

  close $in;

  # matched macro names keeping the lines between
  return \@grep;
}

=head2 diff_macro_names

Tell which macro names don't compare

=cut

sub diff_macro_names {
  return -1 unless @_ == 2;

  my @macros1 = @{shift @_};
  my @macros2 = @{shift @_};

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
    $macros1[$_] ? (sprintf "%-${col}s", ($_+1 . ": " . $macros1[$_])) : ''
  } 0..$#macros1;

  for (0..$#macros2) {
    unless (defined $diff[$_]) {
      push @diff, $macros2[$_] ? (sprintf "%${col}s%s: %s", '', $_+1, $macros2[$_]) : '';

      next;
    }

    $diff[$_] .= (sprintf "%${col}s", '') if ($macros2[$_] and not $diff[$_]);
    $diff[$_] .= ($_+1 . ": " . $macros2[$_]) if $macros2[$_];
  }

  return join "\n\n", grep !/^$/, @diff;
}
