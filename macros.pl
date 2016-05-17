use strict;
use warnings;
use open qw/:std :utf8/;
#use autodie;

my @en = get_macros('english_orig.dm');
my @cz = get_macros('czech_orig.dm');

=head2 get_macros

Extract macros' names from the given DM file.

 Return  : @ macros' names
 Args    : source file

=cut

sub get_macros {
  @ARGV = shift;
  map {
    ###
  } <>;
}

=head2 sort_macros

Todo.

=cut

sub sort_macros {
}
