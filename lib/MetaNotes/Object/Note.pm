package MetaNotes::Object::Note;
use common::sense;
use Moo;
with 'MetaNotes::Role::CouchObject';
with 'MetaNotes::Role::Path';
with 'MetaNotes::Role::Widget';
with 'MetaNotes::Role::Permissions';

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

# for the artists
has css => (
  is => 'rw'
);

# constructor customization
sub BUILD {
  my ($self) = @_;
  $self->type('Note');
}

# path part
sub basename {
  my ($self) = @_;
  $self->_id;
}

sub to_hash {
  my ($self, $doc) = @_;
  return {
    format       => $self->format,
    title        => $self->title,
    content      => $self->content,
    html_content => $self->html_content,
    css          => $self->css,
  };
}

1;

__END__

=head1 NAME

MetaNotes::Object::Note - the original widget

=head1 SYNOPSIS

  use MetaNotes::Models 'all';
  my $note = $Note->find('c6e1c665e9a076208c97d45a82000ca9');
  $note->html_content();

=head1 DESCRIPTION

=head1 AUTHOR

John BEPPU E<lt>beppu@metanotes.comE<gt>

=cut

