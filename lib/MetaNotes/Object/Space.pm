package MetaNotes::Object::Space;
use common::sense;
use Moo;
use File::Spec;
with 'MetaNotes::Role::CouchObject';
with 'MetaNotes::Role::Path';
with 'MetaNotes::Role::Permissions';

has title => (
  is => 'rw'
);

has width => (
  is => 'rw'
);

has height => (
  is => 'rw'
);

sub basename {
  my ($self) = @_;
  my $path = $self->_id;
  ouch('NoId') unless $path;
  $path =~ s/^Space-//;
  my @parts = File::Spec->splitdir($path);
  $parts[-1];
}

sub to_hash {
  my ($self) = @_;
  return {
    title  => $self->title,
    width  => $self->width,
    height => $self->height,
  };
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
