package MetaNotes::Role::Widget;
use common::sense;
use Moo::Role;

# x coordinate (css left)
has x => (
  is => 'rw',
);

# y coordinate (css top)
has y => (
  is => 'rw',
);

# z-index (css z-index)
has z => (
  is => 'rw',
);

#
has width => (
  is => 'rw',
);

#
has height => (
  is => 'rw',
);

# outgoing connections
has connections => (
  is => 'rw'
);

sub connect {
}

sub disconnect {
}

around 'to_hash' => sub {
  my $orig = shift;
  my $self = $_[0];
  my $doc  = $orig->(@_);
  $doc->{x}           = $self->x;
  $doc->{y}           = $self->y;
  $doc->{z}           = $self->z;
  $doc->{width}       = $self->width;
  $doc->{height}      = $self->height;
  $doc->{connections} = $self->connections;
  $doc;
};

1;

__END__

=head1 NAME

MetaNotes::Role::Widget - for any content object in a page

=head1 SYNOPSIS

Make an object be able to be on a page

  package MetaNotes::Object::Image;
  use common::sense;
  use Moo;
  with 'MetaNotes::Role::CouchObject';
  with 'MetaNotes::Role::Widget';

=head1 DESCRIPTION

=head1 AUTHORS

John BEPPU E<lt>beppu@metanotes.comE<gt>

=cut
