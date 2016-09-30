use strict;
use warnings;
use open qw/:std :utf8/;
use autodie;
use utf8;

# CHANGELOG
# v0.1, 5/18/16, Pavel Jurca
#   — diff macro names

# TODO
# make it more of a general use [will be discussed in a next meeting]


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

print diff_macro_names(
  get_macro_names(shift), # FILE1.dm
  get_macro_names(shift)  # FILE2.dm
);
### ============ END ================



=head2 get_macro_names

Extract macro names from the given DM file.

 Return  : \@ macro names with empty lines
 Args    : source filename

=cut

sub get_macro_names {
  my $file = shift;
  die qq/(!) the file "$file" doesn't exist\n/
    unless -e $file;

  open my $in, '<:utf8', $file;
  
  my @greped;
  push @greped, (/^_([^_]+)/ ? $1 : '') while <$in>;
  
  close $in;

  # matched macro names and the empty lines between
  return \@greped;
}

=head2 diff_macro_names

Tell which macro names don't compare.

 Return  : sprintf text
 Args    : \@ macro_names_1, \@ macro_names_2

=cut

sub diff_macro_names {
  return -1 unless @_ == 2;

  my @file_1 = @{ shift @_ };
  my @file_2 = @{ shift @_ };

  # diff
  @macros_1 = map {grep /$_/} @file_1;


  @macro_names_1 = map {grep !/$file_1{$_}/, values %file_2} sort keys %file_1;

  return (sprintf "%40s %40s" x @diff_file_2, @grep_2;
}
