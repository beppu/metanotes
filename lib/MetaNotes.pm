package MetaNotes;
use v5.008;
use strict;
use warnings;
use base 'Squatting';
use aliased 'MetaNotes::H';

use MetaNotes::Models ':all';
use MetaNotes::Controllers;
use MetaNotes::Views;

use JSON;
use Data::Dump  'pp';
use File::Slurp 'slurp';

our $VERSION = "4.000";

# app default configuration
# (I really prefer flat configuration files.)
our %CONFIG  = (
  db   => 'metanotes',
  salt => 'tasty',
  root => 'share/www',
  mode => 'development',
);

# these files will override the default configuration
our @CONFIG_FILES = qw(
  /etc/metanotes/metanotes.json
  etc/metanotes.json
  metanotes.json
);

# CSS profiles for development and production environments
our %CSS = (
  development => [
    '/themes/ui-darkness/jquery-ui-1.7.1.custom.css',
    '/css/main.css',
  ],
  production => [
    "/css/metanotes-$VERSION.css",
  ],
);

# JavaScript profiles for development and production environments
our %JS = (
  development => [
    '/js/jquery-1.3.2.js',
    '/js/jquery-ui-1.7.1.custom.min.js',
    '/js/jquery.ev.js',
    '/js/modifiable.js',
    '/js/mn.js',
    '/js/mn.metaspace.js',
    '/js/mn.panel.js',
    '/js/main.js'
  ],
  production => [
    "/js/metanotes-$VERSION.js",
  ],
);

# this is called once during app start-up
sub init {
  my ($class) = @_;
  MetaNotes::Models::init();
  MetaNotes::Views::init();

  # load config file(s)
  for my $file (grep { -e $_ } @CONFIG_FILES) {
    my $metanotes_config = decode_json(slurp($file));
    for (keys %$metanotes_config) {
      $CONFIG{$_} = $metanotes_config->{$_};
    }
  }

  $class->next::method
}

# this is called during the final phase of app start-up to start up
# the Continuity server
sub continue {
  my ($class, @args) = @_;
  $class->next::method(@args, staticp => sub { 0 });
}

# this method wraps every http request
# note that requests to continuity controllers might not ever return
sub service {
  my ($class, $c, @args) = @_;

  # be able to treat "input" and "state" like objects
  #         treating "v"                 as an object breaks Tenjin
  #                                      (which is a damned shame)
  H->bless($c->{$_}) for qw(input state);

  my $v = $c->v;
  $v->{title}      = ('MetaNotes');
  $v->{feed_title} = ('MetaNotes');
  $v->{feed_url}   = ('/feed.xml');

  $v->{css} = $CSS{$CONFIG{mode}};
  $v->{js}  = $JS{$CONFIG{mode}};

  $class->next::method($c, @args);
}

# this is invoked when running `meta install` from the command line
sub install {
  my ($class, @args) = @_;
  require 'MetaNotes::Installer';
  MetaNotes::Installer->run(@args);
}

1;

__END__

=head1 NAME

MetaNotes - a technology demo

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 AUTHOR

John BEPPU E<lt>john.beppu@gmail.comE<gt>

=head1 COPYRIGHT

Copyright (c) 2008-9 John BEPPU E<lt>beppu@cpan.orgE<gt>.

=head2 The "MIT" License

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

=cut

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
