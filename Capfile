load 'deploy' if respond_to?(:namespace) # cap2 differentiator

# Uncomment if you are using Rails' asset pipeline
# load 'deploy/assets'

Dir['vendor/gems/*/recipes/*.rb','vendor/plugins/*/recipes/*.rb'].each { |plugin| load(plugin) }

load 'config/deploy' # remove this line to skip loading any of the default tasks

# Custom Tasks
#
namespace :deploy do

  # if data directories need to be symlinked in, this would be the place to do it
  task :finalize_update do
    run "cp /u/beta/MetaNotes/CONFIG.js #{latest_release}"
  end

  # should this restart the appN or feN or both?
  task :restart do ; end
  task :stop do ; end
  task :start do ; end

  # this would be a good place to implement sanity checks
  task :check do ; end

end
