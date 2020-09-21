# frozen_string_literal: true

module StreamTimer
	module Config
		module Processors
			## Server (Puma) config
			class Server
				def initialize(config)
					server_config = config.load_yaml :server, required: true

					environment = config[:environment] =
						ENV['RACK_ENV'] ||= server_config[:environment] || 'development'

					Bundler.require environment

					server_config = config[:server] = server_config[environment]

					server_config[:puma_pid_file] = "#{config[:pids_dir]}/#{server_config[:puma_pid_file]}"
				end
			end
		end
	end
end
