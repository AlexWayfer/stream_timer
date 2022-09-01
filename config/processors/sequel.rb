# frozen_string_literal: true

require 'sequel'

## Sequel configuration and methods
module StreamTimer
	module Config
		module Processors
			## Database initialize for Sequel
			class Sequel
				EXTENSIONS = %i[
					error_sql
					pg_enum
					pg_json
					pg_timestamptz
					server_block
				].freeze

				PLUGINS = %i[
					timestamps
					json_serializer
					dataset_associations
					association_multi_add_remove
				].freeze

				def initialize(config)
					return unless config.load_yaml :database

					config[:database] = config[:database][config[:environment]]
					env_db_name = ENV.fetch('DB_NAME', nil)
					config[:database][:database] = env_db_name if env_db_name

					::Sequel::Model.raise_on_save_failure = false

					PLUGINS.each { |plugin_name| ::Sequel::Model.plugin plugin_name }
				end
			end
		end
	end
end
