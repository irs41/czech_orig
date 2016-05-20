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
 Args    : source file

=cut

sub get_macro_names {
  my $file = shift;
  die qq/(!) "$file" doesn't exist\n/
    unless -e $file;

  open my $in, '<:utf8', $file;
  my %line_of = map {
                #line number, macro name
    /^_([^_]+)/ and ($., $1)
  } <$in>;

  return \%line_of;
}

=head2 diff_macro_names

Tell which macro names differ between the two of files.

 Return  : sprintf text
 Args    : % line_ref1, line_ref2 (of macro names)

=cut

sub diff_macro_names {
  return -1 unless @_ == 2;


#sort keys 

#return sprintf("%s",);

#  $en{$macro} = grep /$macro/, @cz ? 1 : 0;
}
