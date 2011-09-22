package MetaNotes::Controllers;
use common::sense;
use aliased 'MetaNotes::H';
use Data::Dump 'pp';

our @C = (

  ## Home Page
  C(
    Home => ['/'],
    get => sub {
      my ($self) = @_;
      my $v = $self->v;
      my $doorman = $v->{doorman};

      #warn $doorman->sign_in_path;
      #warn $doorman->sign_out_path;
      #warn $doorman->twitter_screen_name;
      #warn pp(\%MetaNotes::CONFIG);
      #$v->{space} = $Space->find('/');

      $v->{space} = { test => 1, panel => [ 'reddit' ], auth => 'twitter', foo => 'bar' };
      $self->render('space');
    },
  ),

  ## Authentication
  C(
    Auth => [ '/users/sign_in', '/users/sign_out', '/users/twitter_verified' ],
    get => sub {
      my ($self) = @_;
      $self->redirect(R('Home'));
    },
    post => sub {
      my ($self) = @_;
      $self->redirect(R('Home'));
    },
  ),

  ## Help
  C(
    Help => [ '/@help' ],
    get => sub {
      my ($self) = @_;
      $self->render('_help');
    }
  ),

  ## Object
  #  Every object (whether it be a note or a page) gets its own URL.
  C(
    Object => [ '/(.*?)___(.*)' ],
    get => sub {
      my ($self, $space, $id) = @_;
      # We technically don't need $space for retrieval purposes,
      # but it might be good for SEO?
      my $v = $self->v;
    }
  ),

  ## The MetaSpace is where a user controls his own spaces.
  C(
    MetaSpace => [ '/@metaspace' ],
    get => sub {
      my ($self) = @_;
      $self->v->{metaspace} = metaspace($self->state->{u});
      $self->render('_metaspace');
    }
  ),

  ## API v5
  C(
    APIObject => [ '/api/v5/object/(\w+)/(.*)' ],

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

  # Space has to be last, because it is so general.
  C(
    Space => [ '/(.*)' ],
    get => sub {
      my ($self, $path) = @_;
      my $v = $self->v;
      #$v->{space} = $Space->find($path);
      if (1) {
        $self->render('space');
      } else {
        $self->status = 404;
        $self->render('not_found');
      }
    }
  ),

);

1;
