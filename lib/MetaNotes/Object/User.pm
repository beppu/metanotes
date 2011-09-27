package MetaNotes::Object::User;
use common::sense;
use Moo;
with 'MetaNotes::Role::CouchObject';

has name => (
  is => 'ro'
);

has twitter_accounts => (
  is => 'rw'
);

# constructor customization
sub BUILD {
  my ($self) = @_;
  $self->type('User');
}

sub to_hash {
  my ($self) = @_;
  {
    name             => $self->name,
    twitter_accounts => $self->twitter_accounts,
  };
}

1;

__END__

=head1 NAME

MetaNotes::Object::User - the original widget

=head1 SYNOPSIS

  use MetaNotes::Models 'all';
  my $user = $User->find('User-metatron');
  $user->name();

=head1 DESCRIPTION

=head1 AUTHOR

John BEPPU E<lt>beppu@metanotes.comE<gt>

=cut


