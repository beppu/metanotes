package MetaNotes::Role::Permissions;
use common::sense;
use Moo::Role;
use List::MoreUtils 'firstidx';

# the user who has authority over this object
has owner => (
  is => 'rw'
);

# those who can see
has viewers => (
  is => 'rw',
  default => sub { undef }
);

# those who can edit
has editors => (
  is => 'rw',
  default => sub { [] }
);

# optionally password protect this object
# TODO - semantics of password protection need to be clarified
has password => (
  is => 'rw'
);

my $in = sub { 
  my ($list, $value) = @_;
  (firstidx { $_ eq $value } @$list) != -1
};

# Is this object viewably by $user?
sub viewable_by {
  my ($self, $user) = @_;
  $in->($self->viewers, $user);
}

# Is this object editable by $user?
sub editable_by {
  my ($self, $user) = @_;
  $in->($self->editors, $user);
}

around 'to_hash' => sub {
  my $orig = shift;
  my $self = $_[0];
  my $doc  = $orig->(@_);
  $doc->{owner}    = $self->creator;
  $doc->{viewers}  = $self->viewers;
  $doc->{editors}  = $self->editors;
  $doc->{password} = $self->password;
  $doc;
};

1;

__END__

=head1 NAME

MetaNotes::Role::Permissions - permissions for objects

=head1 SYNOPSIS

  if ($space->editable_by($user)) {
    # ...
  }

The rules for viewers and editors

  undef => anyone
  []    => just you
  [...] => you and your list

=head1 DESCRIPTION

This role lets an object express who may view and edit it.

=cut