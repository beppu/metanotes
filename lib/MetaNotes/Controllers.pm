package MetaNotes::Controllers;
use common::sense;

use Squatting;
use aliased 'MetaNotes::H';

use Data::Dump 'pp';

our @C = (

  C(
    Auth => [ '/@auth' ],
    get => sub {
    },
    post => sub {
    },
  ),

  C(
    MetaSpace => [ '/@metaspace' ],

    get => sub {
      my ($self) = @_;
      $self->v->{metaspace} = metaspace($self->state->{u});
      $self->render('_metaspace');
    }
  ),

  C(
    Home => ['/'],
    get => sub {
      my ($self) = @_;
      my $v = $self->v;
      #$v->{space} = $Space->find('/');
      $v->{space} = { truth => 'optimized', secret => 'weapon', amused => 1 };
      $self->render('space');
    },
  ),

  C(
    Space => [ '/(.*)' ],
    get => sub {
      my ($self, $path) = @_;
      my $v = $self->v;
      #$v->{space} = $Space->find($path);
      $self->render('space');
    }
  ),

  C(
    Object => [ '/api/v5/object/(\w+)/(.*)' ],

    get => sub {
      my ($self, $type, $id) = @_;
      my $v = $self->v;
      #$v->{space} = $Object{$type}->find($id);
      $self->render('space');
    },

    post => sub {
      my ($self, $type, $id) = @_;
      my $u      = $self->state->{u};
      my $input  = $self->input;
      my %params = %{$self->input};
      delete $params{method};
      #my $object = $Object{$type}->find($id);
      #my $method = $input->{method};
      #if ($u->may($method, $object)) {
      #  return $object->$method(\%params);
      #} else {
      #  return '{"success":false}';
      #}
    },
  ),

);

1;
