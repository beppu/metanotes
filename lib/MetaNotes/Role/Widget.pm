package MetaNotes::Role::Widget;
use common::sense;
use Moo::Role;

# the user who instantiated this widget
has creator => (
  is => 'ro'
);

# those who can see
has viewers => (
  is => 'rw'
);

# those who can edit
has editors => (
  is => 'rw'
);

# optionally password protect this object
has password => (
  is => 'rw'
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
  warn "hello from widget";
  $doc->{creator}     = $self->creator;
  $doc->{viewers}     = $self->viewers;
  $doc->{editors}     = $self->editors;
  $doc->{password}    = $self->password;
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
