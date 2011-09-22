package MetaNotes::Object::Space;
use common::sense;
use Moo;
with 'MetaNotes::Role::CouchObject';

has owner => (
  is => 'ro'
);

has path => (
  is => 'rw'
);

has title => (
  is => 'rw'
);

1;

__END__

=head1 NAME

MetaNotes::Object::Space - a place where notes go

=head1 SYNOPSIS

  use MetaNotes::Models 'all';
  my $space = $Space->find('/Music/Perfume');
  $space->title('三人あわせてパーフュームです');
  $space->update();

=head1 DESCRIPTION

=head1 AUTHOR

John BEPPU E<lt>beppu@metanotes.comE<gt>

=cut
