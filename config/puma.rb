# frozen_string_literal: true

require 'fileutils'
require 'etc'

require_relative '../application'

config = ST::Application.config

server_config = config[:server]

environment config[:environment]

directory config[:root_dir]

## Be careful: https://github.com/puma/puma/issues/2319
prune_bundler

rackup 'config.ru'

pids_dir = config[:pids_dir]

FileUtils.mkdir_p pids_dir

pidfile File.join pids_dir, 'puma.pid'
state_path File.join pids_dir, 'puma.state'

FileUtils.mkdir_p config[:log_dir]

case (output = server_config[:output])
when :stdout
	## nothing to do, this is default
when :file
	stdout_redirect(
		config[:stdout_file],
		config[:stderr_file],
		true # append to file
	)
else
	raise "Unsupported #{output} value of `:output` config"
end

cores = Etc.nprocessors
workers_count = server_config[:workers_count] || (cores < 2 ? 1 : 2)

workers workers_count
worker_timeout config[:environment] == 'development' ? 1_000_000 : 15
threads 0, server_config[:threads_count] || 4

lowlevel_error_handler do |exception, env|
	Flame::SentryContext.new(:puma, env:).capture_exception(exception)

	## Rack response
	[
		500,
		{},
		[
			<<~BODY
				An error has occurred, and engineers have been informed. Please reload the page. If you continue to have problems, contact us.
			BODY
		]
	]
end

server_config[:binds].each do |type, value|
	value = "#{value[:host]}:#{value[:port]}" if type == :tcp
	FileUtils.mkdir_p File.join(config[:root_dir], File.dirname(value)) if type == :unix
	bind "#{type}://#{value}"
end
# activate_control_app 'tcp://0.0.0.0:3000'
