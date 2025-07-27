# frozen_string_literal: true

module StreamTimer
	module Config
		module Processors
			## Configuration for Sentry
			class Sentry
				def initialize(config)
					@config = config

					@sentry_config = @config.load_yaml :sentry
					return unless @sentry_config

					@sentry_config['front-end'][:url] = sentry_url project: 'front-end'

					configure_sentry

					Flame::SentryContext.user_block = -> { @controller&.current_user&.to_hash }
				end

				private

				def sentry_url(project:)
					uri = URI::HTTPS.build(
						userinfo: @sentry_config[project][:api_key], host: @sentry_config[:host]
					)
					uri.merge!(@sentry_config[project][:project_id].to_s)
					uri.to_s
				end

				APP_DIRS_PATTERN =
					ST::APP_DIRS
						.map { |app_dir| Regexp.escape(app_dir) }
						.join('|')
						.then { |regexp_template| /(#{regexp_template})/ }
						.freeze

				private_constant :APP_DIRS_PATTERN

				def configure_sentry
					::Sentry.init do |sentry_config|
						sentry_config.enabled_environments = %w[production demo].freeze
						sentry_config.environment = @config[:environment]

						sentry_config.app_dirs_pattern = APP_DIRS_PATTERN

						sentry_config.dsn = sentry_url project: 'back-end'

						sentry_config.send_default_pii = true

						## The default timeouts are too short on slow networks.
						sentry_config.transport.timeout = 10
						sentry_config.transport.open_timeout = 10
					end
				end
			end
		end
	end
end
