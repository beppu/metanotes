package MetaNotes::Role::CouchObject;
use common::sense;
use Moo::Role;

use AnyEvent::CouchDB;
use JSON;

# all CouchDB documents have these
has _id => (
  is => 'ro',
);

has _rev => (
  is => 'ro',
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

sub create {
}

sub find {
}

sub read {
}

sub delete {
}

sub to_hash {
}

1;

__END__

=head1 NAME

MetaNotes::Object::CouchObject - a role for objects

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
