package MetaNotes::Role::CouchObject;
use common::sense;
use Moo::Role;

use AnyEvent::CouchDB;
use JSON;

# a CouchDB database object
has db => (
  is => 'rw'
);

# all CouchDB documents have these
has _id => (
  is => 'ro',
);

has _rev => (
  is => 'rw',
);

# custom fields I want all my objects to have
has type => (
  is => 'ro'
);

has created_at => (
  is => 'ro'
);

has modified_at => (
  is => 'rw'
);

# create self in database
sub create {
  my ($self) = @_;
}

# refresh self from database (if needed)
sub read {
}

# save self to database
sub update {
  my ($self) = @_;
  my $doc = $self->to_hash;
  my $db = $self->db;
  $db->save_doc($doc)->recv;
  $self->_rev($doc->{_rev});
  $self;
}

# delete self from database
sub delete {
}

## modifiers
around 'to_hash' => sub {
  my $orig = shift;
  my $self = $_[0];
  my $doc  = $orig->(@_);
  $doc->{_id}         = $self->_id;
  $doc->{_rev}        = $self->_rev;
  $doc->{type}        = $self->type;
  $doc->{created_at}  = $self->{created_at};
  $doc->{modified_at} = time;
  warn "hello from couchobject";
  $doc;
};

1;

__END__

=head1 NAME

MetaNotes::Role::CouchObject - a role for objects stored in CouchDB

=head1 SYNOPSIS

A role for anything that wants to be saved to a CouchDB database

  package MetaNotes::Object::Note;
  use Moo;
  with 'MetaNotes::Role::CouchObject';

  # Now Note objects can be saved to CouchDB

=head1 DESCRIPTION

=head1 AUTHOR

John BEPPU E<lt>beppu@metanotes.comE<gt>

=cut
