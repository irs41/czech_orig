use strict;
use warnings;
use open qw/:std :utf8/;
use autodie;
use utf8;

# CHANGELOG
# v0.1, 5/18/16, Pavel Jurca
#   — diff macro names

# TODO
# make it a more general use
# [will be discussed in a next meeting]


### ============== MAIN =============
unless (@ARGV == 2) {
  #grep /--help|-h|\/\?/, @ARGV
  print <<'EOL';
NAME
    diff_macros.pl - compare two DM files

USAGE
    diff_macros.pl FILE1.dm FILE2.dm

DESCRIPTION
    Compare macro names of the two DM files, i.e. outdated macros to be removed and missing ones to be added.

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

 Return  : % line_ref (of macro names)
 Args    : source filename

=cut

sub get_macro_names {
  my $file = shift;
  die qq/(!) the file "$file" doesn't exist\n/
    unless -e $file;

  open my $in, '<:utf8', $file;
  my @lines; #(line number, macro name) pairs
  /^_([^_]+)/
    and push @lines, $., $1 while <$in>;
  close $in;

  # hash ref of the matched macro names
  return { @lines };
}

=head2 diff_macro_names

Tell which macro names differ between the two of files.

 Return  : sprintf text
 Args    : % line_ref_1, line_ref_2 (of macro names)

=cut

sub diff_macro_names {
  return -1 unless @_ == 2;

  # line number (key), macro name (value)
  my %file_1 = %{ shift @_ };
  my %file_2 = %{ shift @_ };

  # diff
  my @diff_file_1 = map {grep !/$file_1{$_}/, values %file_2} sort keys %file_1;
  my @diff_file_2 = map {grep !/$file_2{$_}/, values %file_1} sort keys %file_2;


  for my $line_num (sort keys @diff_file_1) {
    
  }
  return (sprintf "%40s %40s" x @diff_file_2, @grep_2;
}
