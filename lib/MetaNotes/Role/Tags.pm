package MetaNotes::Role::Tags;
use common::sense;
use Moo::Role;
use ElasticSearch;

has tags => (
  is      => 'rw',
  default => sub { [ ] },
);

sub search_by_tags {
  my ($self, @tags) = @_;

}

1;

__END__

=head1 NAME

MetaNotes::Roles::Tags - make objects taggable

=cut
