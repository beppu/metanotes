package MetaNotes::Channels;
use strict;
use warnings;
use base 'Exporter';

use aliased 'MetaNotes::H';

use Time::HiRes 'time';
use AnyEvent;
use Coro;
use Coro::AnyEvent;
use Coro::Signal;

our @EXPORT_OK   = qw($Channel %channels channel);
our %EXPORT_TAGS = (all => \@EXPORT_OK);

# a hash of all Channel objects by name
our %channels;

# base Channel object
our $Channel = H->new({
  name     => '',
  i        => 0,
  size     => 16,
  messages => [],
  signal   => Coro::Signal->new,

  write => sub {
    my ($self, @messages) = @_;
    my $i    = $self->{i};
    # warn $i;
    my $size = $self->{size};
    my $m    = $self->{messages};
    for (@messages) {
      $_->{created_on} = time;
      $m->[$i++] = $_;
      $i = 0 if ($i >= $size); # circular-array
    }
    # warn $i;
    $self->{i} = $i;
    $self->signal->broadcast;
    @messages;
  },

  read => sub {
    my ($self, $since) = @_;
    $since ||= 0;
    sort    { $a->{created_on} <=> $b->{created_on} }
      grep  { $_->{created_on} > $since             } @{$self->{messages}};
  },
});

# Channel object factory
sub channel {
  $channels{$_[0]} ||= $Channel->clone({ name => $_[0] });
}

1;

__END__

# Local Variables: ***
# mode: cperl ***
# indent-tabs-mode: nil ***
# cperl-close-paren-offset: -2 ***
# cperl-continued-statement-offset: 2 ***
# cperl-indent-level: 2 ***
# cperl-indent-parens-as-block: t ***
# cperl-tab-always-indent: nil ***
# End: ***
# vim:tabstop=2 softtabstop=2 shiftwidth=2 shiftround expandtab
