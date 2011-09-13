package MetaNotes::Object::Page;
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

MetaNotes::Object::Page - formerly known as Space; where notes go

=head1 SYNOPSIS

  use MetaNotes::Models 'all';
  my $page = $Page->find('/');
  $page->title('new title');
  $page->update();

=head1 DESCRIPTION

=head1 AUTHOR

John BEPPU E<lt>beppu@metanotes.comE<gt>

=cut
