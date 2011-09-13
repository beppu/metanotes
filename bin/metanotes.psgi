#!/usr/bin/env perl
use common::sense;
use Plack::Builder;

use MetaNotes 'On::PSGI';
MetaNotes->init;

builder {

  enable "Plack::Middleware::Static",
    path => qr{^/(images|js|css)/}, root => 'share/www/';

  my $app = sub {
    my $env = shift;
    MetaNotes->psgi($env);
  };

};

