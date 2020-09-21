# frozen_string_literal: true

require 'flame/r18n'

module StreamTimer
	module Config
		module Processors
			## Configuration for R18n
			class R18n
				def initialize(config)
					config[:locales_dir] = File.join config[:root_dir], 'locales'

					::R18n.default_places = config[:locales_dir]

					::R18n::I18n.default = 'en-US'

					::R18n::Filters.on(:named_variables)

					::R18n::Filters.add(::R18n::Untranslated, :raise_untranslated) do |content|
						request_context = Flame::RavenContext.new(:translations, key: content)
						Raven.capture_message(*request_context.exception_with_context)
						content
					end
				end
			end
		end
	end
end
