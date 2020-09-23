# frozen_string_literal: true

## Uncomment if you want, read discussion here: https://github.com/dazuma/toys/issues/57
# truncate_load_path!

include :bundler, static: true

root_dir = "#{__dir__}/.."
config_dir = "#{root_dir}/config"
require "#{root_dir}/constants"

require 'benchmark_toys'
expand BenchmarkToys::Template
alias_tool :b, :benchmark

application_proc = proc do
	require "#{root_dir}/application"
	ST::Application
end

config_proc = proc { application_proc.call.config }

require 'config_toys'
expand ConfigToys::Template, config_dir: config_dir

db_connection_proc = proc do
	application_proc.call.db_connection
end

require 'sequel_migrations_toys'
expand SequelMigrationsToys::Template, db_connection_proc: db_connection_proc

require 'psql_toys'
expand PSQLToys::Template,
	db_config_proc: proc { config_proc.call[:database] },
	db_connection_proc: db_connection_proc,
	db_extensions: %w[citext pgcrypto].freeze

alias_tool :db, :database

require 'flame_deploy_toys'
expand FlameDeployToys::Template, config_dir: config_dir

require 'flame_generate_toys'
expand FlameGenerateToys::Template, namespace: StreamTimer

require 'flame_routes_toys'
expand FlameRoutesToys::Template, application_proc: application_proc

require 'flame_server_toys'
expand FlameServerToys::Template, config_proc: config_proc

require 'locales_toys'
expand LocalesToys::Template

# tool :locales do
# 	require 'crowdin_toys'
# 	expand CrowdinToys::Template
# end

require 'rack_console_toys'
expand RackConsoleToys::Template

require 'static_files_toys'
expand StaticFilesToys::Template
