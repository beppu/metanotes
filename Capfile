load 'deploy' if respond_to?(:namespace) # cap2 differentiator

# Uncomment if you are using Rails' asset pipeline
# load 'deploy/assets'

Dir['vendor/gems/*/recipes/*.rb','vendor/plugins/*/recipes/*.rb'].each { |plugin| load(plugin) }

load 'config/deploy' # remove this line to skip loading any of the default tasks

# shell commands to do a minimal perlbrew setup
preamble = ". ~/.perlbrew/init && PATH=$PERLBREW_PATH:$PATH && export PERL5LIB=lib"

# Custom Tasks
#
namespace :deploy do

  # tweak tweak tweak
  task :finalize_update do
    run "cp /u/beta/MetaNotes/CONFIG.js #{latest_release}"
  end

  # start and stop the web server
  task :stop do
    run "kill $(cat #{deploy_to}/metanotes.pid)"
  end
  task :start do
    run <<-CMD
      #{preamble} && 
      cd #{latest_release} && 
      bin/with-pid-file #{deploy_to}/metanotes.pid \
        fliggy --listen :5000 bin/metanotes.psgi > /dev/null 2>&1 &
    CMD
  end
  task :restart do
    stop
    start
  end

  # this would be a good place to implement sanity checks
  task :check do
    run "#{preamble} && env"
  end

end

# vim:ft=ruby
