# frozen_string_literal: true

require_relative '../../lib/flame/raven_context_patch'

module StreamTimer
	module Config
		module Processors
			## Configuration for Sentry
			class Sentry
				STATIC_CONFIG = {
					environments: %w[production demo].freeze,
					## The default timeouts are too short on slow networks.
					timeout: 10,
					open_timeout: 10,
					app_dirs_pattern:
						ST::APP_DIRS
							.map { |app_dir| Regexp.escape(app_dir) }
							.join('|')
							.then { |regexp_template| /(#{regexp_template})/ }
							.freeze
				}.freeze

				def initialize(config)
					@config = config

					@sentry_config = @config.load_yaml :sentry
					return unless @sentry_config

					@sentry_config['front-end'][:url] = sentry_url project: 'front-end'

					configure_raven
				end

				private

				def sentry_url(project:)
					uri = URI::HTTPS.build(
						userinfo: @sentry_config[project][:api_key], host: @sentry_config[:host]
					)
					uri.merge!(@sentry_config[project][:project_id].to_s)
					uri.to_s
				end

				def configure_raven
					Raven.configure do |raven_config|
						STATIC_CONFIG.each { |field, value| raven_config.public_send("#{field}=", value) }

						raven_config.current_environment = @config[:environment]
						raven_config.dsn = sentry_url project: 'back-end'
						raven_config.processors -= [
							Raven::Processor::Cookies,
							Raven::Processor::PostData
						]
					end
				end
			end
		end
	end
end
