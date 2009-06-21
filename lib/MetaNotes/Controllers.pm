package MetaNotes::Controllers;
use strict;
use warnings;

use Squatting ':controllers';
use aliased 'MetaNotes::H';
use MetaNotes::Models ':all';
use MetaNotes::Channels ':all';

use Coro;
use AnyEvent;
use Coro::AnyEvent;
use File::Slurp;

use Data::Dump 'pp';

our @C = (

  C(
    Static => [ '/((css|js|images|themes)/.*)', '/(favicon.ico)' ],

    mime  => {
      css => 'text/css',
      js  => 'text/javascript',
      jpg => 'image/jpeg',
      gif => 'image/gif',
      png => 'image/png',
    },

    get => sub {
      my ($self, $path) = @_;
      no warnings 'once';
      if ($path =~ qr{\.\.}) {
        $self->status = 403;
        return;
      }
      my ($type) = ($path =~ /\.(\w+)$/);
      $self->headers->{'Content-Type'} = $self->{mime}->{$type} || 'text/plain';
      my $file = "$MetaNotes::CONFIG{root}/$path";
      if (-e $file) {
        return scalar read_file($file); 
      } else {
        $self->status = 404;
        return;
      }
    }
  ),

  C(
    Auth => [ '/@auth' ],

    get => sub {
    },

    post => sub {
    },
  ),

  C(
    Event => [ '/@event' ],

    get => sub {
      my ($self) = @_;
    }
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
      $v->{space} = $Space->find('/');
      $self->render('space');
    },
  ),

  C(
    Object => [ '/@object/(\w+)/(.*)' ],

    get => sub {
      my ($self, $type, $id) = @_;
      my $v = $self->v;
      $v->{space} = $Object{$type}->find($id);
      $self->render('space');
    },

    post => sub {
      my ($self, $type, $id) = @_;
      my $u      = $self->state->{u};
      my $input  = $self->input;
      my %params = %{$self->input};
      delete $params{method};
      my $object = $Object{$type}->find($id);
      my $method = $input->{method};
      if ($u->may($method, $object)) {
        return $object->$method(\%params);
      } else {
        return '{"success":false}';
      }
    },
  ),

  C(
    Space => [ '/(.*)' ],
    get => sub {
      my ($self, $path) = @_;
      my $v = $self->v;
      $v->{space} = $Space->find($path);
      $self->render('space');
    }
  ),


);

1;
