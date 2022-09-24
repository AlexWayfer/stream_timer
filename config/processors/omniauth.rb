# frozen_string_literal: true

require 'omniauth'

module StreamTimer
	module Config
		module Processors
			## Configuration for OmniAuth
			class OmniAuth
				using GorillaPatch::Blank

				def initialize(_config)
					::OmniAuth::AuthenticityTokenProtection.default_options(
						key: 'csrf.token', authenticity_param: '_csrf'
					)

					::OmniAuth.config.path_prefix = '/connect'
					::OmniAuth.config.logger = ST::Application.logger
				end
			end
		end
	end
end
