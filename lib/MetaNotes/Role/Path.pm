package MetaNotes::Role::Path;
use common::sense;
use Moo::Role;
use Ouch;

# like unix but for metanotes paths
requires 'basename';

# parent object; every widget needs one and almost every space needs one.
# in the widget's case, it is the space it lives in.
# in the space's case, it is the superspace it is contained within.
#   Space-/ is the only space that has no parent.
has parent_id => (
  is => 'rw'
);

# When should i set this?
has cached_path => (
  is        => 'rw',
  predicate => 'has_cached_path',
);

# 
sub path {
  my ($self) = @_;
  return $self->cached_path if $self->has_cached_path;
  if ($self->parent_id) {
    my $db            = $MetaNotes::Models::db;
    my ($type, @rest) = split /-/, $self->parent_id;
    my $types         = lc($type) . "s";
    my $parent        = $db->$types->find($self->parent_id);
    ouch('MissingParent') unless $parent;
    return ($parent->path, $self->basename);
  }
  else {
    return ($self->basename);
  }
}

around 'to_hash' => sub {
  my $orig = shift;
  my $self = $_[0];
  my $doc  = $orig->(@_);
  $doc->{parent_id}   = $self->parent_id;
  $doc->{cached_path} = $self->cached_path;
  $doc;
};

1;
