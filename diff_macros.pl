use strict;
use warnings;
use open qw/:std :utf8/;
use utf8;
#use autodie;

# CHANGELOG
# v0.1, 5/18/16, Pavel Jurca
#   — print outdated macros to be removed and missing macros to be added

# TODO
# [will be discussed in the next meeting]


### ============== MAIN =============

print check_macros(
  \get_macros('english_orig.dm'), # ORIGINAL file
  \get_macros('czech_orig.dm') # TRANSLATED file to check
);

### ============ END ================



=head2 get_macros

Extract macros' names from the given DM file.

 Return  : @ macros' names
 Args    : source file

=cut

sub get_macros {
  @ARGV = shift;
  map {
    /^_([^_]+)/ and $1
  } <>;
}

=head2 check_macros



 Return  : printf text
 Args    : @ en_ref, cz_ref

=cut

sub check_macros {


# $. => print line numbers!

#my %en = map {
#  ($_, undef)
#} get_macros('english_orig.dm');
#print "$_\n" for keys %en; exit;
#
#my @cz = get_macros('czech_orig.dm');
#for my $macro (keys %en) {
#  $en{$macro} = grep /$macro/, @cz ? 1 : 0;
#}
#
#  return printf

}
