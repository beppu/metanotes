set :stages, %w(production beta)
set :default_stage, "beta"
require 'capistrano/ext/multistage'

set :application, "MetaNotes"
set :repository,  "git@github.com:beppu/metanotes.git"

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
