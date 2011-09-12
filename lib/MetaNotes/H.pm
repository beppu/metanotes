package MetaNotes::H;
use strict;
use warnings;
use base 'Squatting::H';

use Clone;
use Scalar::Util 'blessed';

sub TO_JSON {
  my $self = shift;
  my $copy = {};
  for (keys %$self) {
    if (blessed $self->{$_} && $self->{$_}->can('TO_JSON')) {

      $copy->{$_} = $self->{$_}->TO_JSON;

    } elsif (ref($self->{$_})) {

      if (ref($self->{$_}) eq 'ARRAY' || ref($self->{$_}) eq 'HASH') {
        $copy->{$_} = Clone::clone($self->{$_});
      }

    } else {
      $copy->{$_} = "".$self->{$_};
    }
  }
  $copy;
}

{
  no  warnings 'once';
  *to_hash = *TO_JSON;
}

1;

__END__

=head1 NAME

MetaNotes::H - a JSON-friendly subclass of Squatting::H

=head1 SYNOPSIS

  use aliased 'MetaNotes::H';
  use JSON;

  my $object = H->new({ foo => "bar" });
  my $json   = JSON->new->allow_blessed->convert_blessed;
  $json->encode($object);

=head1 DESCRIPTION

This is a subclass of Squatting::H that adds a TO_JSON method so that
JSON (and JSON::XS) can filter out all the code references before
serializing the object into JSON format.

=head1 API

=head2 $object->TO_JSON

Return an unblessed hashref representing $object with all its coderefs filtered out.

=head2 $object->to_hash

This is an alias for TO_JSON which I feel is more accurately named.

=cut
