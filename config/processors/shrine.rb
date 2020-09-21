# frozen_string_literal: true

require 'shrine'
require 'shrine/storage/file_system'

module StreamTimer
	module Config
		module Processors
			## Shrine configuration
			class Shrine
				PLUGINS = %i[
					sequel
					cached_attachment_data
					rack_file
					determine_mime_type
				].freeze

				def initialize(config)
					@config = config

					configure_storages

					PLUGINS.each { |plugin_name| ::Shrine.plugin plugin_name }
				end

				private

				def configure_storages
					::Shrine.storages = {
						## temporary
						cache: ::Shrine::Storage::FileSystem.new(
							@config[:public_dir], prefix: 'uploads/cache'
						),
						## permanent
						store: ::Shrine::Storage::FileSystem.new(
							@config[:public_dir], prefix: 'uploads/store'
						)
					}
				end
			end
		end
	end
end
