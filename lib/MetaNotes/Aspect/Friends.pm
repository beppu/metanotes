package MetaNotes::Aspect::Friends;
use strict;
use warnings;
use MetaNotes::Models ':all';
use Data::Dump 'pp';

sub init {
  my $class = shift;
  $User->before('hello', sub { print "*bow*\n" });
  $User->after('hello', sub { 
    my ($self, $args, $return) = @_;;
    print "*looks up*\n";
    @$return;
  });
}

1;
