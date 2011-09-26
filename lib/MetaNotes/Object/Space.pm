package MetaNotes::Object::Space;
use common::sense;
use Moo;
with 'MetaNotes::Role::CouchObject';
with 'MetaNotes::Role::Permissions';

has path => (
  is => 'rw'
);

has title => (
  is => 'rw'
);

sub to_hash {
  my ($self) = @_;

}

1;

__END__

=head1 NAME

MetaNotes::Object::Space - a place where notes go

=head1 SYNOPSIS

  use MetaNotes::Models 'all';
  my $space = $Space->find('Space-/Music/Perfume');
  $space->title('三人あわせてパーフュームです');
  $space->update();

=head1 DESCRIPTION

=head1 AUTHOR

John BEPPU E<lt>beppu@metanotes.comE<gt>

=cut
