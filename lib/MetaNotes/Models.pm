package MetaNotes::Models;
use common::sense;
use parent 'Exporter';
use aliased 'MetaNotes::H';
use Try::Tiny;
use AnyEvent::CouchDB;
use MetaNotes::Object::Note;
use MetaNotes::Object::Space;
use MetaNotes::Object::User;

our $couchdb;
our $db;

our @EXPORT_OK = qw($couchdb $db);

sub init {
  $couchdb = couchdb($MetaNotes::CONFIG{db});

  $db = H->new({
    users  => couch_object_finder('User',  $couchdb),
    spaces => couch_object_finder('Space', $couchdb),
    notes  => couch_object_finder('Note',  $couchdb),

    view   => H->new({
      spaces_by_path => sub {
      }
    }),
  });
}

sub find {
  my ($self, $id) = @_;
  my $class = 'MetaNotes::Object::' . $self->type;
  my $db    = $self->db;
  my $doc;
  try {
    $doc = $db->open_doc($id)->recv;
  }
  catch {
    # try again; usually works
    $doc = $db->open_doc($id)->recv;
  };
  $doc->{db} = $db;
  $class->new($doc);
}

sub couch_object_finder {
  my ($type, $db) = @_;
  H->new({
    type => $type,
    db   => $db,
    find => \&find,
  });
}

1;

=head1 NAME

MetaNotes::Models - the objects MetaNotes manipulates

=head1 SYNOPSIS

  use MetaNotes::Models ':all';

  my $home  = $Space->find('/');
  my $about = $Space->find('metatron/about');
  my @notes = $about->notes;
  my $beppu = $User->find('beppu');

=head1 DESCRIPTION

This is my experiment in treating Perl like JavaScript.  Instead of defining
a whole bunch of classes to represent my data model, I've defined a bunch of
cloneable, slot-based objects, instead.

=head1 API

=head2 Mixins Objects

The following objects are meant to be mixed in to other objects.

=head3 $Modifiable

$Modifiable is a MetaNotes::H object that implements before() and after() methods.
It's intended to be used as a mixin.



=head2 Model Objects

=head3 $CouchObject

$CouchObject is a MetaNotes::H object that implements methods which will allow
other objects to persist themselves to CouchDB.

=head4 $object->create(\%options)

=head4 $object->delete


=head3 $User

$User is a specialized clone of $CouchObject for representing users.

=head4 $user->set_encrypted_password($password);

=head4 $user


=head3 $Space

$Space is a specialized clone of $CouchObject for representing spaces (which are pages in MetaNotes).


=head3 $Widget

$Widget is a specialized clone of $CouchObject for defining common attributes and behaviors
for all widgets.  

=head4 $widget->move($x, $y);

=head4 $widget->send_to_space($space);


=head3 $Note

$Note is a specialized clone of $Widget for representing the classical MetaNote.

=head4 $note->title

=head4 $note->body

=head4 $note->body_as_html


=head3 $Image

$Image is a specialized clone of $Widget for representing Image widgets.

=head4 $image->url


=head3 %Object



=head2 Other Exported Symbols

=head3 $json

=head3 $db

=head3 metaspace($user_name)


=head2 Aspects



=cut
