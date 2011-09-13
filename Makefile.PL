use inc::Module::Install;

name           'MetaNotes';
all_from       'lib/MetaNotes.pm';

requires       'Squatting'   => '0.81';
requires       'Moo';
requires       'AnyEvent::CouchDB';
requires       'Text::Xslate';

test_requires  'Test::More'  => '0.42';

no_index       'directory'   => 'eg';

install_script 'bin/meta';
install_share;

WriteAll;
