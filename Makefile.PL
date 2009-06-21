use inc::Module::Install;

# Define metadata
name           'MetaNotes';
all_from       'lib/MetaNotes.pm';

# Specific dependencies
requires       'Squatting'   => '0.60';
test_requires  'Test::More'  => '0.42';
no_index       'directory'   => 'eg';
install_script 'bin/meta';
install_share;

WriteAll;
