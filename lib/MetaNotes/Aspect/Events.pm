package MetaNotes::Aspect::Events;
use strict;
use warnings;
use MetaNotes::Models ':all';

sub init {
  my $class = shift;
  $Note->after('create', sub {
    my ($self, $args, $return) = @_;
    @$return;
  });
  $Note->after('move', sub {
    my ($self, $args, $return) = @_;
    @$return;
  });
  $Note->after('delete', sub {
    my ($self, $args, $return) = @_;
    @$return;
  });
}

1;
