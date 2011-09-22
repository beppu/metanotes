package MetaNotes::Object::Note;
use common::sense;
use Moo;
with 'MetaNotes::Role::CouchObject';
with 'MetaNotes::Role::Widget';

# textile, markdown, bbcode, whatever
has format => (
  is => 'rw'
);

# necessary?
has title => (
  is => 'rw'
);

# raw content
has content => (
  is => 'rw'
);

# prerendered as html
has html_content => (
  is => 'rw'
);

1;

__END__

=head1 NAME

MetaNotes::Object::Note - the original widget

=head1 SYNOPSIS

  use MetaNotes::Models 'all';
  my $page = $Note->find('/');
  $page->path();

=head1 DESCRIPTION

=head1 AUTHOR

John BEPPU E<lt>beppu@metanotes.comE<gt>

=cut

