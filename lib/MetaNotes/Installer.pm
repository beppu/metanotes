package MetaNotes::Installer;
use strict;
use warnings;

sub run {
  my ($class, $opts) = @_;
  warn "TODO";
}

1;

__END__

=head1 NAME

MetaNotes::Installer - helping you deploy metanotes

=head1 SYNOPSIS

Use from the command line:

  cd /www/metanotes.com
  meta install

=head1 DESCRIPTION

The purpose of this module is to help automate the deployment of MetaNotes.
When you run `meta install`, it will attempt to do the following:

=over 2

=item 1. Copy templates into `pwd`

=item 2. Copy a default configuration file into `pwd`/etc

=item 3. Provide a default F<vw_harness.pl> script for use with L<App::VW>.

=cut
