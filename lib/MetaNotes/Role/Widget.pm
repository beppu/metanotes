package MetaNotes::Role::Widget;
use common::sense;
use Moo::Role;

has connections => (
  is => 'rw'
);

sub connect {
}

sub disconnect {
}

1;

__END__

=head1 NAME

MetaNotes::Role::Widget - for any content object in a page

=head1 SYNOPSIS

Make an object be able to be on a page

  package MetaNotes::Object::Image;
  use common::sense;
  use Moo;
  with 'MetaNotes::Role::CouchObject';
  with 'MetaNotes::Role::Widget';

=head1 DESCRIPTION

=head1 AUTHORS

John BEPPU E<lt>beppu@metanotes.comE<gt>

=cut
