use inc::Module::Install;

name           'MetaNotes';
all_from       'lib/MetaNotes.pm';

requires       'parent';
requires       'aliased';
requires       'common::sense';
requires       'Moo';
requires       'Ouch';
requires       'Try::Tiny';
requires       'Text::Xslate';
requires       'XML::Feed';
requires       'Math::BigInt::GMP';
requires       'Net::OpenID::Consumer';
requires       'Net::Twitter::Lite';
requires       'LWPx::ParanoidAgent';
requires       'LWP::Protocol::https';
requires       'Doorman';
requires       'Starman';
requires       'AnyEvent::CouchDB';
requires       'Squatting::On::PSGI';
requires       'Squatting' => '0.81';

test_requires  'Test::More' => '0.42';

no_index       'directory' => 'eg';

install_script 'bin/meta';
install_share;

postamble qq{
develop :
	fliggy -p :5000 -R lib bin/metanotes.psgi &
	cd share/www && sass --watch sass:css &
};

WriteAll;
