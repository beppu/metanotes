#!/usr/bin/env perl
use common::sense;
use Plack::Builder;

use MetaNotes 'On::PSGI';
MetaNotes->init;

builder {

  enable 'Session::Cookie';
  enable 'DoormanTwitter',
    root_url        => 'http://localhost:5000',
    scope           => 'users',
    consumer_key    => $MetaNotes::CONFIG{consumer_key},
    consumer_secret => $MetaNotes::CONFIG{consumer_secret};
  enable 'Plack::Middleware::Static',
    path => qr{^/(themes|images|js|css)/}, root => 'share/www/';

  my $app = sub {
    my $env = shift;
    MetaNotes->psgi($env);
  };

};

